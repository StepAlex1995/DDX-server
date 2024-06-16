package model

type GetAllTaskByDateRequest struct {
	ClientId int   `json:"client_id" db:"client_id"`
	Date     int64 `json:"date" db:"date_create"`
}

type GetTaskByIdRequest struct {
	Id int `json:"id" db:"id"`
}

type TaskParam struct {
	Id     int    `json:"id" db:"id"`
	TaskId int    `json:"task_id" db:"task_id"`
	Name   string `json:"param_name" db:"param_name"`
	Target int    `json:"target" db:"target"`
	Value  int    `json:"value" db:"value"`
}
type AddTaskParam struct {
	Name   string `json:"param_name" db:"param_name"`
	Target int    `json:"target" db:"target"`
	Value  int    `json:"value" db:"value"`
}

type UpdateTaskParam struct {
	Id    int `json:"id" db:"id"`
	Value int `json:"value" db:"value"`
}

type AddTaskRequest struct {
	Date int64 `json:"date" db:"date"`
	//TrainerId       int            `json:"trainer_id" db:"trainer_id"`
	ClientId    int            `json:"client_id" db:"client_id"`
	ExerciseId  int            `json:"exercise_id" db:"exercise_id"`
	Description string         `json:"description" db:"description"`
	State       int            `json:"state" db:"state"`
	TaskParam   []AddTaskParam `json:"params"`
}
type UpdateTaskRequest struct {
	FileFeedbackUrl string            `json:"file_feedback_url" db:"file_feedback_url"`
	FeedbackClient  int               `json:"feedback_client" db:"feedback_client"`
	FeedbackTrainer int               `json:"feedback_trainer" db:"feedback_trainer"`
	State           int               `json:"state" db:"state"`
	TaskParam       []UpdateTaskParam `json:"params"`
}

type TaskResponse struct {
	Id              int              `json:"id" db:"id"`
	Date            string           `json:"date" db:"date"`
	TrainerId       int              `json:"trainer_id" db:"trainer_id"`
	ClientId        int              `json:"client_id" db:"client_id"`
	Exercise        ExerciseResponse `json:"exercise" db:"exercise"`
	FileFeedbackUrl string           `json:"file_feedback_url" db:"file_feedback_url"`
	FeedbackClient  int              `json:"feedback_client" db:"feedback_client"`
	FeedbackTrainer int              `json:"feedback_trainer" db:"feedback_trainer"`
	Description     string           `json:"description" db:"description"`
	State           int              `json:"state" db:"state"`
	TaskParam       []TaskParam      `json:"params"`
}
