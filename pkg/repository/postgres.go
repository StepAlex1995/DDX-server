package repository

import (
	"fmt"
	"github.com/jmoiron/sqlx"
)

const (
	usersTable          = "users"
	clientsTable        = "clients"
	trainersTable       = "trainers"
	clientStatusesTable = "client_statuses"
	exerciseTable       = "exercise"
	photoExerciseTable  = "photo_exercise"
	taskTable           = "task"
	taskParamTable      = "task_param"
	msgTable            = "msg"

	noData      = "no_data"
	roleClient  = 0
	roleTrainer = 1
)

type Config struct {
	Host     string
	Port     string
	Username string
	Password string
	DBName   string
	SSLMode  string
}

func NewPostgresDB(cfg Config) (*sqlx.DB, error) {
	db, err := sqlx.Open("postgres", fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=%s",
		cfg.Host, cfg.Port, cfg.Username, cfg.Password, cfg.DBName, cfg.SSLMode))
	if err != nil {
		return nil, err
	}
	err = db.Ping()
	if err != nil {
		return nil, err
	}
	return db, nil
}
