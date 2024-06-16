package entity

type Task struct {
	Id              int    `json:"id" db:"id"`
	Date            string `json:"date" db:"date"`
	TrainerId       int    `json:"trainer_id" db:"trainer_id"`
	ClientId        int    `json:"client_id" db:"client_id"`
	ExerciseId      int    `json:"exercise_id" db:"exercise_id"`
	FileFeedbackUrl string `json:"file_feedback_url" db:"file_feedback_url"`
	FeedbackClient  int    `json:"feedback_client" db:"feedback_client"`
	FeedbackTrainer int    `json:"feedback_trainer" db:"feedback_trainer"`
	Description     string `json:"description" db:"description"`
	State           int    `json:"state" db:"state"`
}

type TaskParam struct {
	Id     int    `json:"id" db:"id"`
	TaskId int    `json:"task_id" db:"task_id"`
	Name   string `json:"param_name" db:"param_name"`
	Target int    `json:"target" db:"target"`
	Value  int    `json:"value" db:"value"`
}
