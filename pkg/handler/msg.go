package handler

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"net/http"
	"strconv"
)

func (h *Handler) getAllMsgForTask(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	taskId, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}

	msgs, errCode := h.services.Msg.GetAllMsgByTaskId(taskId)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error get statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"msgs": msgs,
	})

}

func (h *Handler) sendMsg(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var input model.AddMsgRequest
	if err := c.BindJSON(&input); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	errCode := h.services.Msg.SendMsg(input)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error send msg")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"status": "ok:",
	})
}

func (h *Handler) sendMsgVoice(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var input model.AddMsgVoiceRequest
	if err := c.ShouldBind(&input); err != nil {
		println("error1 = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	if err := c.ShouldBindUri(&input); err != nil {
		println("error3 = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	name := "image/" + uuid.New().String() + input.File.Filename
	err := c.SaveUploadedFile(input.File, name)

	if err != nil {
		println("7 err = " + err.Error())
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}

	errCode := h.services.Msg.SendMsg(model.AddMsgRequest{
		TaskId:       input.TaskId,
		TrainerId:    input.TrainerId,
		ClientId:     input.ClientId,
		Text:         name,
		Date:         input.Date,
		IsSendClient: input.IsSendClient,
	})

	if errCode > 0 {
		println("10 errCode = ", errCode)
		newErrorResponse(c, errCode, "error send voice")
		return
	}

	c.JSON(http.StatusOK, map[string]interface{}{
		"status": "ok:",
	})
}

func (h *Handler) getAllDiscussionForClient(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	clientId, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}

	discussion, errCode := h.services.Msg.GetAllDiscussionByClientId(clientId)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error get discussion")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"discussion": discussion,
	})

}

func (h *Handler) getAllDiscussionForTrainer(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	clientId, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}

	discussion, errCode := h.services.Msg.GetAllDiscussionByTrainerId(clientId)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error get discussion")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"discussion": discussion,
	})

}
