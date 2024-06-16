package repository

import (
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/entity"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/jmoiron/sqlx"
	"github.com/sirupsen/logrus"
)

type TrainerPostgres struct {
	db *sqlx.DB
}

func NewTrainerPostgres(db *sqlx.DB) *TrainerPostgres {
	return &TrainerPostgres{db: db}
}

func (r *TrainerPostgres) GetTrainerByClientId(clientId int) (model.TrainerResponse, int) {
	var resultClient entity.Client
	queryGetClient := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", clientsTable)
	errClient := r.db.Get(&resultClient, queryGetClient, clientId)
	if errClient != nil {
		logrus.Errorf(errClient.Error())
		return model.TrainerResponse{}, 500
	}
	var resultTrainer model.TrainerResponse
	queryGetTrainer := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", trainersTable)
	errTrainer := r.db.Get(&resultTrainer, queryGetTrainer, resultClient.TrainerId)
	if errTrainer != nil {
		logrus.Errorf(errTrainer.Error())
		return model.TrainerResponse{}, 500
	}
	return resultTrainer, 0
}
