package service

import (
	"crypto/sha1"
	"errors"
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/StepAlex1995/ddx-server/pkg/repository"
	"github.com/dgrijalva/jwt-go"
	"time"
)

const (
	salt       = "kwerfjnl34rh789erf78w"
	signingKey = "werfh934f2h89e1230sdac9qecd"
	tokenTTL   = time.Hour * 24 * 30
	noData     = "no_data"
)

type tokenClaims struct {
	jwt.StandardClaims
	UserId int `json:"user_id"`
}

type AuthService struct {
	repo repository.Authorization
}

func NewAuthService(repo repository.Authorization) *AuthService {
	return &AuthService{repo: repo}
}

func (s *AuthService) CreateUser(user model.UserAuthRequest) (int, int) {
	user.Password = s.generatePasswordHash(user.Password)
	return s.repo.CreateUser(user)
}

func (s *AuthService) generatePasswordHash(password string) string {
	hash := sha1.New()
	hash.Write([]byte(password))
	return fmt.Sprintf("%x", hash.Sum([]byte(salt)))
}

func (s *AuthService) LogIn(userResp model.UserAuthRequest) (model.UserAuthResponse, int) {
	userResp.Password = s.generatePasswordHash(userResp.Password)
	user, err := s.repo.GetUser(userResp)
	if err > 0 {
		return model.UserAuthResponse{}, err
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, &tokenClaims{
		jwt.StandardClaims{
			ExpiresAt: time.Now().Add(tokenTTL).Unix(),
			IssuedAt:  time.Now().Unix(),
		},
		user.Id,
	})

	tokenResult, errToken := token.SignedString([]byte(signingKey))
	if errToken != nil {
		return model.UserAuthResponse{}, 500
	}
	user.Token = tokenResult

	return user, 0
}

func (s *AuthService) ParseToken(accessToken string) (model.UserAuthResponse, int) {
	token, err := jwt.ParseWithClaims(accessToken, &tokenClaims{}, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, errors.New("unexpected signing method")
		}

		return []byte(signingKey), nil
	})
	if err != nil {
		return model.UserAuthResponse{}, 401
	}
	claims, ok := token.Claims.(*tokenClaims)
	if !ok || !token.Valid {
		return model.UserAuthResponse{}, 401
	}
	return s.repo.GetUserById(claims.UserId)
}
