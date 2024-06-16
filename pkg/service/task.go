package service

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/StepAlex1995/ddx-server/pkg/repository"
)

type TaskService struct {
	repo repository.Task
}

func NewTaskService(repo repository.Task) *TaskService {
	return &TaskService{repo: repo}
}

func (s *TaskService) GetAllTasksByDay(request model.GetAllTaskByDateRequest) ([]model.TaskResponse, int) {
	return s.repo.GetAllTasksByDay(request)
}

func (s *TaskService) GetTaskById(taskId int) (model.TaskResponse, int) {
	return s.repo.GetTaskById(taskId)
}

func (s *TaskService) CreateTask(trainerId int, data model.AddTaskRequest) int {
	return s.repo.CreateTask(trainerId, data)
}

func (s *TaskService) UpdateTask(id int, data model.UpdateTaskRequest) int {
	return s.repo.UpdateTask(id, data)
}
