package handler

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func (h *Handler) getTrainer(c *gin.Context) {
	clientId, okClient := c.Get(clientId)
	if !okClient {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	trainer, errCode := h.services.Trainer.GetTrainerByClientId(clientId.(int))
	if errCode > 0 {
		newErrorResponse(c, errCode, "error getting trainer")
		return
	}

	c.JSON(http.StatusOK, map[string]interface{}{
		"trainer": trainer,
	})
}

func (h *Handler) updateTrainer(c *gin.Context) {

}
