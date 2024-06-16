package model

type MsgResponse struct {
	Id           int    `json:"id" db:"id"`
	TaskId       int    `json:"task_id" db:"task_id"`
	TrainerId    int    `json:"trainer_id" db:"trainer_id"`
	ClientId     int    `json:"client_id" db:"client_id"`
	Text         string `json:"text" db:"text"`
	Date         string `json:"date" db:"date"`
	IsSendClient bool   `json:"is_send_client" db:"is_send_client"`
}

type Discussion struct {
	TaskId int            `json:"task_id"`
	Task   TaskResponse   `json:"task"`
	Client ClientResponse `json:"client"`
	//Exercise entity.Exercise `json:"exercise"`
	//TaskName string `json:"task_name"`
	TaskDate string `json:"task_date"`
}

type AddMsgRequest struct {
	TaskId       int    `json:"task_id" db:"task_id"`
	TrainerId    int    `json:"trainer_id" db:"trainer_id"`
	ClientId     int    `json:"client_id" db:"client_id"`
	Text         string `json:"text" db:"text"`
	Date         int64  `json:"date" db:"date"`
	IsSendClient bool   `json:"is_send_client" db:"is_send_client"`
}
