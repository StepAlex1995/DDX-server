package model

type TrainerResponse struct {
	Id       int    `json:"-" db:"id"`
	Name     string `json:"name" db:"name"`
	Phone    string `json:"phone" db:"phone"`
	PhotoUrl string `json:"photo" db:"photo"`
}
