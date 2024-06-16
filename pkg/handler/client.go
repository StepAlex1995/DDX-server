package handler

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

func (h *Handler) getClientById(c *gin.Context) {
	//userId, okId := c.Get(userId)
	//clientId, okClient := c.Get(clientId)
	trainerId, okTrainer := c.Get(trainerId)
	if !okTrainer {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}

	client, errCode := h.services.Client.GetClientById(id, trainerId.(int))
	if errCode > 0 {
		newErrorResponse(c, errCode, "error")
		return
	}

	c.JSON(http.StatusOK, map[string]interface{}{
		"client": client,
	})
}

func (h *Handler) getAllClients(c *gin.Context) {
	//userId, okId := c.Get(userId)
	userRole, okRole := c.Get(userRole)
	trainerIdCtx, okTrainer := c.Get(trainerId)
	if !okRole || !okTrainer || userRole == 0 {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var trainerId = trainerIdCtx.(int)
	clientList, errCode := h.services.GetAllClients(trainerId)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error server")
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"clientList": clientList,
	})
}

func (h *Handler) updateClient(c *gin.Context) {
	clientId, okClient := c.Get(clientId)
	if !okClient {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}
	var input model.ClientUpdateRequest
	if err := c.BindJSON(&input); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	clientUpdated, errCode := h.services.Client.UpdateClient(clientId.(int), input)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error update client info")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"clientUpdated": clientUpdated,
	})
}

func (h *Handler) getAllClientStatusesForClient(c *gin.Context) {
	clientId, okClient := c.Get(clientId)
	if !okClient {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var inputDats model.ClientStatusRequest
	if err := c.BindJSON(&inputDats); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	statuses, errCode := h.services.Client.GetAllStatuses(clientId.(int), inputDats)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error get statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"statuses": statuses,
	})
}

func (h *Handler) getAllClientStatusesForTrainer(c *gin.Context) {
	_, okTrainer := c.Get(trainerId)
	if !okTrainer {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}
	clientId, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}
	var inputDats model.ClientStatusRequest
	if err := c.BindJSON(&inputDats); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	statuses, errCode := h.services.Client.GetAllStatuses(clientId, inputDats)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error get statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"statuses": statuses,
	})
}

func (h *Handler) getClientStatus(c *gin.Context) {
	clientId, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}
	status, errCode := h.services.Client.GetStatusesById(clientId)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error get statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"statuses": status,
	})
}

func (h *Handler) addClientStatus(c *gin.Context) {
	clientId, okClient := c.Get(clientId)
	if !okClient {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var inputData model.AddClientStatusRequest
	if err := c.BindJSON(&inputData); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	errCode := h.services.Client.AddStatus(clientId.(int), inputData)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error add statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"update": "ok",
	})
}
