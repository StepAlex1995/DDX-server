package service

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/StepAlex1995/ddx-server/pkg/repository"
)

type Authorization interface {
	CreateUser(user model.UserAuthRequest) (int, int)
	LogIn(user model.UserAuthRequest) (model.UserAuthResponse, int)
	ParseToken(token string) (model.UserAuthResponse, int)
}

type Client interface {
	GetAllClients(trainerId int) ([]model.ClientItemResponse, int)
	GetClientById(id int, trainerId int) (model.ClientResponse, int)
	UpdateClient(id int, request model.ClientUpdateRequest) (model.ClientResponse, int)
	GetAllStatuses(clientId int, request model.ClientStatusRequest) ([]model.ClientStatusResponse, int)
	GetStatusesById(clientId int) (model.ClientStatusResponse, int)
	AddStatus(clientId int, request model.AddClientStatusRequest) int
}

type Trainer interface {
	GetTrainerByClientId(id int) (model.TrainerResponse, int)
}

type Exercise interface {
	GetAllPublicExercises() ([]model.ExerciseResponse, int)
	GetAllPrivateExercises(trainerId int) ([]model.ExerciseResponse, int)
	AddExercise(trainerId int, request model.AddExerciseRequest) (int, int)
	CopyExercise(trainerId int, exerciseId int, request model.AddExerciseRequest) (int, int)
}

type File interface {
	SavePhotoExercise(name string, request model.LoadFileExerciseRequest) int
	LoadFeedbackTask(name string, request model.LoadFileTaskRequest) int
}

type Task interface {
	GetAllTasksByDay(request model.GetAllTaskByDateRequest) ([]model.TaskResponse, int)
	GetTaskById(taskId int) (model.TaskResponse, int)
	CreateTask(trainerId int, data model.AddTaskRequest) int
	UpdateTask(id int, data model.UpdateTaskRequest) int
}

type Msg interface {
	GetAllMsgByTaskId(taskId int) ([]model.MsgResponse, int)
	SendMsg(data model.AddMsgRequest) int
	GetAllDiscussionByClientId(client int) ([]model.Discussion, int)
	GetAllDiscussionByTrainerId(client int) ([]model.Discussion, int)
}

type Service struct {
	Authorization
	Client
	Trainer
	Exercise
	File
	Task
	Msg
}

func NewService(repos *repository.Repository) *Service {
	return &Service{
		Authorization: NewAuthService(repos.Authorization),
		Client:        NewClientService(repos.Client),
		Trainer:       NewTrainerService(repos.Trainer),
		Exercise:      NewExerciseService(repos.Exercise),
		File:          NewFileService(repos.File),
		Task:          NewTaskService(repos.Task),
		Msg:           NewMsgService(repos.Msg),
	}
}
