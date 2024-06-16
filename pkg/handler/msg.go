package handler

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/gin-gonic/gin"
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
		newErrorResponse(c, errCode, "error get statuses")
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
