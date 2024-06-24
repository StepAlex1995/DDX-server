package repository

import (
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/entity"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/jmoiron/sqlx"
	"github.com/sirupsen/logrus"
	"time"
)

type MsgPostgres struct {
	db *sqlx.DB
}

func NewMsgPostgres(db *sqlx.DB) *MsgPostgres {
	return &MsgPostgres{db: db}
}

func (r *MsgPostgres) GetAllMsgByTaskId(taskId int) ([]model.MsgResponse, int) {
	var resultMsgs []model.MsgResponse
	queryMsg := fmt.Sprintf("SELECT * FROM %s WHERE task_id = $1", msgTable)
	err := r.db.Select(&resultMsgs, queryMsg, taskId)
	if err != nil {
		logrus.Errorf(err.Error())
		return nil, 500
	}
	return resultMsgs, 0
}

func (r *MsgPostgres) SendMsg(request model.AddMsgRequest) int {
	var id int
	date := time.Unix(request.Date, 0)
	queryAddMsg := fmt.Sprintf("INSERT INTO %s ( task_id, trainer_id, client_id, text, is_send_client, date) values ($1,$2,$3,$4,$5,$6) RETURNING id", msgTable)
	rowCreateClientStatus := r.db.QueryRow(queryAddMsg, request.TaskId, request.TrainerId, request.ClientId, request.Text, request.IsSendClient, date)
	if err := rowCreateClientStatus.Scan(&id); err != nil {
		logrus.Errorf(err.Error())
		return 500
	}
	return 0
}

func (r *MsgPostgres) GetAllDiscussionByTrainerId(clientId int) ([]model.Discussion, int) {
	return r.GetAllDiscussionById(clientId, false)
}

func (r *MsgPostgres) GetAllDiscussionByClientId(clientId int) ([]model.Discussion, int) {
	return r.GetAllDiscussionById(clientId, true)
}

func (r *MsgPostgres) GetAllDiscussionById(id int, isClient bool) ([]model.Discussion, int) {
	var resultMsgs []model.Discussion

	var resultTask []entity.Task

	var queryListTask string

	if isClient {
		queryListTask = fmt.Sprintf("SELECT * FROM %s WHERE client_id = $1", taskTable)
	} else {
		queryListTask = fmt.Sprintf("SELECT * FROM %s WHERE trainer_id = $1", taskTable)
	}
	errListTask := r.db.Select(&resultTask, queryListTask, id)
	if errListTask != nil {
		logrus.Errorf(errListTask.Error())
		return nil, 500
	}

	for _, task := range resultTask {
		msg, errCode := r.GetAllMsgByTaskId(task.Id)
		if errCode > 0 {
			logrus.Errorf(errListTask.Error())
			return nil, 500
		}

		var taskDb entity.Task
		queryGetTask := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", taskTable)
		errGetTask := r.db.Get(&taskDb, queryGetTask, task.Id)
		if errGetTask != nil {
			logrus.Errorf(errGetTask.Error())
			return nil, 500
		}

		var resultParam []model.TaskParam
		queryListParam := fmt.Sprintf("SELECT * FROM %s WHERE task_id = $1", taskParamTable)
		errListParam := r.db.Select(&resultParam, queryListParam, task.Id)
		if errListParam != nil {
			logrus.Errorf(errListParam.Error())
			return nil, 500
		}
		var exerciseDb entity.Exercise
		queryEx := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", exerciseTable)
		errExercise := r.db.Get(&exerciseDb, queryEx, task.ExerciseId)
		if errExercise != nil {
			logrus.Errorf(errExercise.Error())
			return nil, 500
		}
		var resultPhoto []entity.PhotoExercise
		queryPhoto := fmt.Sprintf("SELECT * FROM %s WHERE exercise_id = $1", photoExerciseTable)
		errPhoto := r.db.Select(&resultPhoto, queryPhoto, exerciseDb.Id)
		if errPhoto != nil {
			logrus.Errorf(errPhoto.Error())
			return nil, 500
		}
		resultsExercise := model.ExerciseResponse{
			Id:           exerciseDb.Id,
			Title:        exerciseDb.Title,
			Muscle:       exerciseDb.Muscle,
			TypeExercise: exerciseDb.TypeExercise,
			Equipment:    exerciseDb.Equipment,
			Difficulty:   exerciseDb.Difficulty,
			IsPublic:     exerciseDb.IsPublic,
			Description:  exerciseDb.Description,
			TrainerId:    exerciseDb.TrainerId,
			State:        exerciseDb.State,
			Photo:        resultPhoto,
		}
		resultTask := model.TaskResponse{
			Id:              task.Id,
			Date:            task.Date,
			TrainerId:       task.TrainerId,
			ClientId:        task.ClientId,
			Exercise:        resultsExercise,
			FileFeedbackUrl: task.FileFeedbackUrl,
			FeedbackClient:  task.FeedbackClient,
			FeedbackTrainer: task.FeedbackTrainer,
			Description:     task.Description,
			State:           task.State,
			TaskParam:       resultParam,
		}

		var clientResult model.ClientResponse
		queryGet := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", clientsTable)
		err := r.db.Get(&clientResult, queryGet, task.ClientId)
		if err != nil {
			logrus.Errorf(err.Error())
			return nil, 500
		}

		if len(msg) > 0 {
			var date = msg[0].Date

			for _, m := range msg {
				d1, errD1 := time.Parse("2006-01-02T15:04:05Z", date)
				d2, errD2 := time.Parse("2006-01-02T15:04:05Z", m.Date)
				if errD1 == nil && errD2 == nil && d1.UnixMilli() < d2.UnixMilli() {
					date = m.Date
				}
			}
			resultMsgs = append(resultMsgs, model.Discussion{
				TaskId:   task.Id,
				Task:     resultTask,
				Client:   clientResult,
				TaskDate: date,
			})
		}
	}
	return resultMsgs, 0
}
