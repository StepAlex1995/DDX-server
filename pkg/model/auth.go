package model

type UserAuthRequest struct {
	Login    string `json:"login" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type UserAuthResponse struct {
	Id            int    `json:"-"`
	Login         string `json:"login"`
	Role          int    `json:"role"`
	SelfClientId  int    `json:"client_id"`
	SelfTrainerId int    `json:"self_trainer_id"`
	Name          string `json:"name"`
	IsMan         bool   `json:"is_man"`
	Phone         string `json:"phone"`
	BirthDate     string `json:"birth_date"`
	TrainerId     int    `json:"trainer_id"`
	PhotoUrl      string `json:"photo_url"`
	Token         string `json:"token"`
}
