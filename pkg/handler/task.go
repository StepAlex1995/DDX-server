package handler

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

func (h *Handler) getAllTaskByDay(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var inputDats model.GetAllTaskByDateRequest
	if err := c.BindJSON(&inputDats); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	tasks, errCode := h.services.Task.GetAllTasksByDay(inputDats)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error getting tasks by day")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"tasks": tasks,
	})
}

func (h *Handler) getTaskById(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}

	task, errCode := h.services.Task.GetTaskById(id)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error getting task by id")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"task": task,
	})
}

func (h *Handler) createTask(c *gin.Context) {
	trainerId, okTrainer := c.Get(trainerId)
	if !okTrainer {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var input model.AddTaskRequest
	if err := c.BindJSON(&input); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	err := h.services.Task.CreateTask(trainerId.(int), input)
	if err > 0 {
		newErrorResponse(c, err, "error creating task")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{"status": "ok"})
}

func (h *Handler) updateTask(c *gin.Context) {
	_, okId := c.Get(userId)
	if !okId {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid id param")
		return
	}

	var input model.UpdateTaskRequest
	if err := c.BindJSON(&input); err != nil {
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}

	errCode := h.services.Task.UpdateTask(id, input)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error updating task")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{"status": "ok"})
}
