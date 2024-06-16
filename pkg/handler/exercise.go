package handler

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

func (h *Handler) getPublicExercises(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	exercises, errCode := h.services.Exercise.GetAllPublicExercises()
	if errCode > 0 {
		newErrorResponse(c, errCode, "error getting all public exercises")
		return
	}

	c.JSON(http.StatusOK, map[string]interface{}{
		"exercises": exercises,
	})
}

func (h *Handler) getPrivateExercises(c *gin.Context) {
	trainerId, okTrainer := c.Get(trainerId)
	if !okTrainer {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	exercises, errCode := h.services.Exercise.GetAllPrivateExercises(trainerId.(int))
	if errCode > 0 {
		newErrorResponse(c, errCode, "error getting all public exercises")
		return
	}

	c.JSON(http.StatusOK, map[string]interface{}{
		"exercises": exercises,
	})
}

func (h *Handler) getExerciseById(c *gin.Context) {
	//not used
}

func (h *Handler) addExercise(c *gin.Context) {
	trainerId, okTrainer := c.Get(trainerId)
	if !okTrainer {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var inputData model.AddExerciseRequest
	if err := c.BindJSON(&inputData); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	id, errCode := h.services.Exercise.AddExercise(trainerId.(int), inputData)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error add exercise")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"id": id,
	})
}

func (h *Handler) copyExercise(c *gin.Context) {
	trainerId, okTrainer := c.Get(trainerId)
	if !okTrainer {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	exerciseId, errExerciseId := strconv.Atoi(c.Param("id"))
	if errExerciseId != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}

	var inputData model.AddExerciseRequest
	if err := c.BindJSON(&inputData); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	id, errCode := h.services.Exercise.CopyExercise(trainerId.(int), exerciseId, inputData)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error copy exercise")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"id": id,
	})
}
