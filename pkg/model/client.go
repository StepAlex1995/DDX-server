package model

import "time"

type ClientItemResponse struct {
	Id        int       `json:"id" db:"id" binding:"required"`
	Name      string    `json:"name" db:"name" binding:"required"`
	IsMan     bool      `json:"is_man" db:"is_man"`
	Phone     string    `json:"phone" db:"phone"`
	BirthDate time.Time `json:"birth_date" db:"birthdate"`
}

type ClientResponse struct {
	Id        int       `json:"id" db:"id"`
	Name      string    `json:"name" db:"name"`
	IsMan     bool      `json:"is_man" db:"is_man"`
	Phone     string    `json:"phone" db:"phone"`
	BirthDate time.Time `json:"birth_date" db:"birthdate"`
	TrainerId int       `json:"trainer_id" db:"trainer_id"`
}

type ClientUpdateRequest struct {
	Name      string `json:"name" db:"name"`
	IsMan     bool   `json:"is_man" db:"is_man"`
	Phone     string `json:"phone" db:"phone"`
	BirthDate string `json:"birth_date" db:"birthdate"`
}

type ClientStatusResponse struct {
	Id          int       `json:"-" db:"id"`
	ClientId    int       `json:"client_id" db:"client_id"`
	Date        time.Time `json:"date" db:"date_create"`
	Weight      float32   `json:"weight" db:"weight"`
	Height      float32   `json:"height" db:"height"`
	FatPercent  float32   `json:"fat_percent" db:"fat_percent"`
	Breast      float32   `json:"breast" db:"breast"`
	Waist       float32   `json:"waist" db:"waist"`
	Neck        float32   `json:"neck" db:"neck"`
	LeftBiceps  float32   `json:"left_biceps" db:"left_biceps"`
	RightBiceps float32   `json:"right_biceps" db:"right_biceps"`
}

type AddClientStatusRequest struct {
	Date        int64   `json:"date"`
	Weight      float32 `json:"weight"`
	Height      float32 `json:"height"`
	FatPercent  float32 `json:"fat_percent"`
	Breast      float32 `json:"breast"`
	Waist       float32 `json:"waist"`
	Neck        float32 `json:"neck"`
	LeftBiceps  float32 `json:"left_biceps"`
	RightBiceps float32 `json:"right_biceps"`
}

type ClientStatusRequest struct {
	DateStart int64 `json:"date_start"`
	DateEnd   int64 `json:"date_end"`
}
