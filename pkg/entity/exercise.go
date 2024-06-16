package entity

type Exercise struct {
	Id           int    `json:"-" db:"id"`
	Title        string `json:"title" db:"title"`
	Muscle       string `json:"muscle" db:"muscle"`
	TypeExercise string `json:"type" db:"type"`
	Equipment    string `json:"equipment" db:"equipment"`
	Difficulty   int    `json:"difficulty" db:"difficulty"`
	IsPublic     bool   `json:"is_public" db:"is_public"`
	Description  string `json:"description" db:"description"`
	TrainerId    int    `json:"trainer_id" db:"trainer_id"`
	State        int    `json:"state" db:"state"`
}

type PhotoExercise struct {
	Id         int    `json:"-" db:"id"`
	ExerciseId int    `json:"exercise_id" db:"exercise_id"`
	Url        string `json:"url" db:"url"`
	Number     int    `json:"number" db:"number"`
}
