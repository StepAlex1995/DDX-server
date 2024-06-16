package entity

type Msg struct {
	Id           int    `json:"id" db:"id"`
	TaskId       string `json:"task_id" db:"task_id"`
	TrainerId    string `json:"trainer_id" db:"trainer_id"`
	ClientId     string `json:"client_id" db:"client_id"`
	Text         string `json:"text" db:"text"`
	Date         bool   `json:"date" db:"date"`
	IsSendClient bool   `json:"is_send_client" db:"is_send_client"`
}
