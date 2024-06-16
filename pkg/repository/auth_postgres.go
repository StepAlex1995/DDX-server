package repository

import (
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/entity"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/jmoiron/sqlx"
	"time"
)

type AuthPostgres struct {
	db *sqlx.DB
}

func NewAuthPostgres(db *sqlx.DB) *AuthPostgres {
	return &AuthPostgres{db: db}
}

func (r *AuthPostgres) CreateUser(user model.UserAuthRequest) (int, int) {
	var userList []entity.User
	queryGetUser := fmt.Sprintf("SELECT * FROM %s users WHERE users.login = $1", usersTable)
	err := r.db.Select(&userList, queryGetUser, user.Login)
	if err != nil {
		return 0, 500
	}
	if len(userList) > 0 {
		return 0, 401
	}

	var idClient int
	queryCreateClient := fmt.Sprintf("INSERT INTO %s (name, is_man, phone, birthdate, trainer_id) values ($1,$2,$3,$4,$5) RETURNING id", clientsTable)
	rowCreateClient := r.db.QueryRow(queryCreateClient, noData, true, noData, time.DateOnly, 1)
	if err := rowCreateClient.Scan(&idClient); err != nil {
		return 0, 500
	}

	var idUser int
	queryCreateUser := fmt.Sprintf("INSERT INTO %s (login, password_hash, role, client_id, trainer_id) values ($1,$2,$3,$4,$5) RETURNING id", usersTable)
	rowCreateUser := r.db.QueryRow(queryCreateUser, user.Login, user.Password, roleClient, idClient, 1)
	if err := rowCreateUser.Scan(&idUser); err != nil {
		return 0, 500
	}

	return idUser, 0
}

func (r *AuthPostgres) GetFullInfoByUser(user entity.User) (model.UserAuthResponse, int) {
	//if user.Role == 0 {
	var client entity.Client
	queryGetClient := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", clientsTable)
	err := r.db.Get(&client, queryGetClient, user.ClientId)
	if err != nil {
		return model.UserAuthResponse{}, 500
	}
	if user.Role == roleClient {
		return model.UserAuthResponse{
			Id:           user.Id,
			Login:        user.Login,
			Role:         user.Role,
			SelfClientId: client.Id,
			Name:         client.Name,
			IsMan:        client.IsMan,
			Phone:        client.Phone,
			BirthDate:    client.BirthDate,
			TrainerId:    client.TrainerId,
		}, 0
	} else {
		var trainer entity.Trainer
		queryGetTrainer := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", trainersTable)
		err := r.db.Get(&trainer, queryGetTrainer, user.TrainerId)
		if err != nil {
			return model.UserAuthResponse{}, 500
		}
		return model.UserAuthResponse{
			Id:            user.Id,
			Login:         user.Login,
			Role:          user.Role,
			SelfTrainerId: trainer.Id,
			Name:          trainer.Name,
			Phone:         trainer.Phone,
			PhotoUrl:      trainer.PhotoUrl,
			SelfClientId:  client.Id,
			IsMan:         client.IsMan,
			BirthDate:     client.BirthDate,
		}, 0
	}
}

func (r *AuthPostgres) GetUser(userRequest model.UserAuthRequest) (model.UserAuthResponse, int) {
	var user entity.User
	queryGetUser := fmt.Sprintf("SELECT * FROM %s WHERE login = $1 AND password_hash = $2 ", usersTable)
	err := r.db.Get(&user, queryGetUser, userRequest.Login, userRequest.Password)
	if err != nil {
		return model.UserAuthResponse{}, 404
	}
	userResult, errCode := r.GetFullInfoByUser(user)
	if errCode > 0 {
		return model.UserAuthResponse{}, errCode
	}
	return userResult, 0
}

func (r *AuthPostgres) GetUserById(userId int) (model.UserAuthResponse, int) {
	var user entity.User
	queryGetUser := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", usersTable)
	err := r.db.Get(&user, queryGetUser, userId)
	if err != nil {
		return model.UserAuthResponse{}, 404
	}
	userResult, errCode := r.GetFullInfoByUser(user)
	if errCode > 0 {
		return model.UserAuthResponse{}, errCode
	}
	return userResult, 0
}
