package handler

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"strings"
)

const (
	authorizationHeader = "Authorization"
	userId              = "userId"
	userRole            = "userRole"
	clientId            = "clientId"
	trainerId           = "trainerId"
)

func (h *Handler) userIdentity(c *gin.Context) {
	header := c.GetHeader(authorizationHeader)
	if header == "" {
		newErrorResponse(c, http.StatusUnauthorized, "empty authorization header")
		return
	}
	headerParts := strings.Split(header, " ")
	if len(headerParts) != 2 {
		newErrorResponse(c, http.StatusUnauthorized, "invalid authorization header")
		return
	}

	user, errCode := h.services.ParseToken(headerParts[1])
	if errCode != 0 {
		newErrorResponse(c, errCode, "invalid authorization header")
		return
	}
	c.Set(userId, user.Id)
	c.Set(userRole, user.Role)
	c.Set(clientId, user.SelfClientId)
	c.Set(trainerId, user.SelfTrainerId)
}
