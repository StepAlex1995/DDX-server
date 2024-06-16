package model

import "mime/multipart"

type LoadFileExerciseRequest struct {
	ExerciseId int `form:"exercise_id" db:"exercise_id"`
	//Url        string `json:"url" db:"url"`
	File   *multipart.FileHeader `form:"file" `
	Number int                   `form:"number"`
}

type LoadFileTaskRequest struct {
	TaskId int                   `form:"task_id" db:"task_id"`
	File   *multipart.FileHeader `form:"file" `
}
