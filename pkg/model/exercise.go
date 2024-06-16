package model

import "github.com/StepAlex1995/ddx-server/pkg/entity"

type ExerciseResponse struct {
	Id           int                    `json:"id" db:"id"`
	Title        string                 `json:"title" db:"title"`
	Muscle       string                 `json:"muscle" db:"muscle"`
	TypeExercise string                 `json:"type" db:"type"`
	Equipment    string                 `json:"equipment" db:"equipment"`
	IsPublic     bool                   `json:"is_public" db:"is_public"`
	Description  string                 `json:"description" db:"description"`
	TrainerId    int                    `json:"trainer_id" db:"trainer_id"`
	State        int                    `json:"state" db:"state"`
	Difficulty   int                    `json:"difficulty" db:"difficulty"`
	Photo        []entity.PhotoExercise `json:"photo"`
}

type AddExerciseRequest struct {
	Title        string `json:"title" db:"title"`
	Muscle       string `json:"muscle" db:"muscle"`
	TypeExercise string `json:"type" db:"type"`
	Equipment    string `json:"equipment" db:"equipment"`
	IsPublic     bool   `json:"is_public" db:"is_public"`
	Difficulty   int    `json:"difficulty" db:"difficulty"`
	Description  string `json:"description" db:"description"`
	State        int    `json:"state" db:"state"`
}
