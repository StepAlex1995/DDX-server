package handler

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"net/http"
)

func (h *Handler) loadPhotoExercise(c *gin.Context) {
	_, okTrainer := c.Get(trainerId)
	if !okTrainer {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var input model.LoadFileExerciseRequest
	if err := c.ShouldBind(&input); err != nil {
		println("error = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	if err := c.ShouldBindUri(&input); err != nil {
		println("error = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	name := "image/" + uuid.New().String() + input.File.Filename
	err := c.SaveUploadedFile(input.File, name)
	if err != nil {
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}

	errCode := h.services.File.SavePhotoExercise(name, input)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error add statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"status": "ok",
	})
}

func (h *Handler) downloadFile(c *gin.Context) {
	_, okUser := c.Get(userId)
	if !okUser {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	fileName := c.Param("id")
	filePath := "image/" + fileName
	c.File(filePath)
}

func (h *Handler) loadFeedbackTask(c *gin.Context) {
	_, okClient := c.Get(clientId)
	if !okClient {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var input model.LoadFileTaskRequest

	print(c.Request)
	if err := c.ShouldBind(&input); err != nil {
		println("error 1 = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		//	return
	}
	if err := c.ShouldBindUri(&input); err != nil {
		println("error 2 = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	name := "image/" + uuid.New().String() + input.File.Filename
	err := c.SaveUploadedFile(input.File, name)

	if err != nil {
		println("13 err =", err.Error())
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}

	errCode := h.services.LoadFeedbackTask(name, input)
	if errCode > 0 {
		println("16 err =", err.Error())
		newErrorResponse(c, errCode, "error add statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"filename": name,
	})
}
