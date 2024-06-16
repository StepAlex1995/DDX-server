package repository

import (
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/jmoiron/sqlx"
	"github.com/sirupsen/logrus"
	"time"
)

type ClientPostgres struct {
	db *sqlx.DB
}

func (r *ClientPostgres) GetClientById(clientId int) (model.ClientResponse, int) {
	var result model.ClientResponse
	queryGet := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", clientsTable)
	err := r.db.Get(&result, queryGet, clientId)
	if err != nil {
		logrus.Errorf(err.Error())
		return model.ClientResponse{}, 500
	}
	return result, 0
}

func NewClientPostgres(db *sqlx.DB) *ClientPostgres {
	return &ClientPostgres{db: db}
}

func (r *ClientPostgres) GetAllClients(trainerId int) ([]model.ClientItemResponse, int) {
	var result []model.ClientItemResponse
	queryList := fmt.Sprintf("SELECT cl.id, cl.name, cl.is_man, cl.phone, birthdate FROM %s cl INNER JOIN %s us on cl.id = us.client_id WHERE cl.trainer_id = $1 AND us.role = $2", clientsTable, usersTable)
	err := r.db.Select(&result, queryList, trainerId, 0)
	if err != nil {
		logrus.Errorf(err.Error())
		return nil, 500
	}
	return result, 0
}

func (r *ClientPostgres) UpdateClient(id int, data model.ClientUpdateRequest) error {
	query := fmt.Sprintf("UPDATE %s SET name = $2, is_man = $3, phone = $4, birthdate = $5 WHERE id = $1", clientsTable)
	_, err := r.db.Exec(query, id, data.Name, data.IsMan, data.Phone, data.BirthDate)
	return err
}

func (r *ClientPostgres) GetAllStatuses(clientId int, param model.ClientStatusRequest) ([]model.ClientStatusResponse, int) {
	var result []model.ClientStatusResponse
	startDate := time.Unix(param.DateStart, 0)
	endDate := time.Unix(param.DateEnd, 0)

	queryList := fmt.Sprintf("SELECT * FROM %s WHERE client_id = $1 AND date_create >= $2 AND date_create <= $3", clientStatusesTable)
	err := r.db.Select(&result, queryList, clientId, startDate, endDate)
	if err != nil {
		logrus.Errorf(err.Error())
		return nil, 500
	}
	return result, 0
}

func (r *ClientPostgres) GetStatusesById(id int) (model.ClientStatusResponse, int) {
	var result model.ClientStatusResponse
	queryList := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", clientStatusesTable)
	err := r.db.Get(&result, queryList, id)
	if err != nil {
		logrus.Errorf(err.Error())
		return model.ClientStatusResponse{}, 500
	}
	return result, 0
}

func (r *ClientPostgres) AddStatus(clientId int, data model.AddClientStatusRequest) int {
	date := time.Unix(data.Date, 0)
	var result []model.ClientStatusResponse
	queryList := fmt.Sprintf("SELECT * FROM %s WHERE client_id = $1 AND date_create = $2", clientStatusesTable)
	err := r.db.Select(&result, queryList, clientId, date)
	if err != nil {
		logrus.Errorf(err.Error())
		return 500
	}
	if result != nil {
		queryUpdateClientStatus := fmt.Sprintf("UPDATE %s SET date_create = $2, weight = $3, height = $4, fat_percent = $5, breast = $6, waist = $7, neck = $8, left_biceps = $9, right_biceps = $10 WHERE id = $1", clientStatusesTable)
		_, err := r.db.Exec(queryUpdateClientStatus, result[0].Id, date, data.Weight, data.Height, data.FatPercent, data.Breast, data.Weight, data.Neck, data.LeftBiceps, data.RightBiceps)
		if err != nil {
			logrus.Errorf(err.Error())
			return 500
		}
		return 0
	} else {
		queryCreateClientStatus := fmt.Sprintf("INSERT INTO %s (client_id, date_create, weight, height, fat_percent, breast, waist, neck, left_biceps, right_biceps) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING id", clientStatusesTable)
		rowCreateClientStatus := r.db.QueryRow(queryCreateClientStatus, clientId, date, data.Weight, data.Height, data.FatPercent, data.Breast, data.Weight, data.Neck, data.LeftBiceps, data.RightBiceps)
		if err := rowCreateClientStatus.Scan(&clientId); err != nil {
			logrus.Errorf(err.Error())
			return 500
		}
		return 0
	}
}
