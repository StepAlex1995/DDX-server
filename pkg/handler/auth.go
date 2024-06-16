package handler

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/gin-gonic/gin"
	"net/http"
)

func (h *Handler) signUp(c *gin.Context) {
	var input model.UserAuthRequest

	if err := c.BindJSON(&input); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	id, errorCode := h.services.CreateUser(input)
	if errorCode != 0 {
		if errorCode == 401 {
			newErrorResponse(c, http.StatusUnauthorized, "already signed up")
		} else {
			newErrorResponse(c, http.StatusInternalServerError, "error creating user")
		}
		return
	}
	//c.JSON(http.StatusOK, gin.H{"id": id})
	c.JSON(http.StatusOK, map[string]interface{}{
		"id": id,
	})
}

func (h *Handler) signIn(c *gin.Context) {
	var input model.UserAuthRequest
	if err := c.BindJSON(&input); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	user, errorCode := h.services.LogIn(input)
	if errorCode != 0 {
		if errorCode == 404 {
			newErrorResponse(c, http.StatusNotFound, "not found")
		} else {
			newErrorResponse(c, errorCode, "error auth user")
		}
		return
	}

	c.JSON(http.StatusOK, map[string]interface{}{
		"user": user,
	})
}
