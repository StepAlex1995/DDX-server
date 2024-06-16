package repository

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/jmoiron/sqlx"
)

type Authorization interface {
	CreateUser(user model.UserAuthRequest) (int, int)
	GetUser(user model.UserAuthRequest) (model.UserAuthResponse, int)
	GetUserById(userId int) (model.UserAuthResponse, int)
}

type Client interface {
	GetAllClients(trainerId int) ([]model.ClientItemResponse, int)
	GetClientById(clientId int) (model.ClientResponse, int)
	UpdateClient(id int, data model.ClientUpdateRequest) error
	GetAllStatuses(clientId int, param model.ClientStatusRequest) ([]model.ClientStatusResponse, int)
	GetStatusesById(clientId int) (model.ClientStatusResponse, int)
	AddStatus(clientId int, data model.AddClientStatusRequest) int
}

type Trainer interface {
	GetTrainerByClientId(clientId int) (model.TrainerResponse, int)
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
	GetAllDiscussionByTrainerId(trainer int) ([]model.Discussion, int)
}

type Repository struct {
	Authorization
	Client
	Trainer
	Exercise
	File
	Task
	Msg
}

func NewRepository(db *sqlx.DB) *Repository {
	return &Repository{
		Authorization: NewAuthPostgres(db),
		Client:        NewClientPostgres(db),
		Trainer:       NewTrainerPostgres(db),
		Exercise:      NewExercisePostgres(db),
		File:          NewFilePostgres(db),
		Task:          NewTaskPostgres(db),
		Msg:           NewMsgPostgres(db),
	}
}
