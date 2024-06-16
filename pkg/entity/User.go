package entity

type User struct {
	Id           int    `json:"-" db:"id"`
	Login        string `json:"login" db:"login"`
	PasswordHash string `json:"password_hash" db:"password_hash"`
	Role         int    `json:"role" db:"role"`
	ClientId     int    `json:"client_id" db:"client_id"`
	TrainerId    int    `json:"trainer_id" db:"trainer_id"`
}

type Client struct {
	Id        int    `json:"-" db:"id"`
	Name      string `json:"name" db:"name"`
	IsMan     bool   `json:"is_man" db:"is_man"`
	Phone     string `json:"phone" db:"phone"`
	BirthDate string `json:"birth_date" db:"birthdate"`
	TrainerId int    `json:"trainer_id" db:"trainer_id"`
}

type Trainer struct {
	Id       int    `json:"-" db:"id"`
	Name     string `json:"name" db:"name"`
	Phone    string `json:"phone" db:"phone"`
	PhotoUrl string `json:"photo" db:"photo"`
}

type ClientStatus struct {
	Id          int     `json:"-" db:"id"`
	ClientId    int     `json:"client_id" db:"client_id"`
	Date        int64   `json:"date" db:"date_create"`
	Weight      float32 `json:"weight" db:"weight"`
	Height      float32 `json:"height" db:"height"`
	FatPercent  float32 `json:"fat_percent" db:"fat_percent"`
	Breast      float32 `json:"breast" db:"breast"`
	Waist       float32 `json:"waist" db:"waist"`
	Neck        float32 `json:"neck" db:"neck"`
	LeftBiceps  float32 `json:"left_biceps" db:"left_biceps"`
	RightBiceps float32 `json:"right_biceps" db:"right_biceps"`
}
