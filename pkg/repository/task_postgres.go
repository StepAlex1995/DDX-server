package repository

import (
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/entity"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/jmoiron/sqlx"
	"github.com/sirupsen/logrus"
	"time"
)

type TaskPostgres struct {
	db *sqlx.DB
}

func NewTaskPostgres(db *sqlx.DB) *TaskPostgres {
	return &TaskPostgres{db: db}
}

func (r *TaskPostgres) GetAllTasksByDay(request model.GetAllTaskByDateRequest) ([]model.TaskResponse, int) {
	var resultTask []entity.Task
	date := time.Unix(request.Date, 0)

	queryListTask := fmt.Sprintf("SELECT * FROM %s WHERE client_id = $1 AND date = $2", taskTable)
	errListTask := r.db.Select(&resultTask, queryListTask, request.ClientId, date)
	if errListTask != nil {
		logrus.Errorf(errListTask.Error())
		return nil, 500
	}

	var results []model.TaskResponse
	for _, task := range resultTask {
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

		results = append(results, model.TaskResponse{
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
		})
	}
	return results, 0
}

/*
func (r *TaskPostgres) GetAllTasksByDay(request model.GetAllTaskByDateRequest) ([]model.TaskResponse, int) {
	var resultTask []model.TaskResponse
	date := time.Unix(request.Date, 0)

	queryListTask := fmt.Sprintf("SELECT * FROM %s WHERE client_id = $1 AND date = $2", taskTable)
	errListTask := r.db.Select(&resultTask, queryListTask, request.ClientId, date)
	if errListTask != nil {
		logrus.Errorf(errListTask.Error())
		return nil, 500
	}

	var results []model.TaskResponse
	for _, task := range resultTask {
		var resultParam []model.TaskParam
		queryListParam := fmt.Sprintf("SELECT * FROM %s WHERE task_id = $1", taskParamTable)
		errListParam := r.db.Select(&resultParam, queryListParam, task.Id)
		if errListParam != nil {
			logrus.Errorf(errListParam.Error())
			return nil, 500
		}
		results = append(results, model.TaskResponse{
			Id:              task.Id,
			Date:            task.Date,
			TrainerId:       task.TrainerId,
			ClientId:        task.ClientId,
			ExerciseId:      task.ExerciseId,
			FileFeedbackUrl: task.FileFeedbackUrl,
			FeedbackClient:  task.FeedbackClient,
			FeedbackTrainer: task.FeedbackTrainer,
			Description:     task.Description,
			State:           task.State,
			TaskParam:       resultParam,
		})
	}
	return results, 0
}*/

func (r *TaskPostgres) GetTaskById(taskId int) (model.TaskResponse, int) {
	var task entity.Task

	queryListTask := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", taskTable)
	errListTask := r.db.Get(&task, queryListTask, taskId)
	if errListTask != nil {
		logrus.Errorf(errListTask.Error())
		return model.TaskResponse{}, 500
	}

	var result model.TaskResponse

	var exerciseDb entity.Exercise
	queryEx := fmt.Sprintf("SELECT * FROM %s WHERE id = $1", exerciseTable)
	errExercise := r.db.Get(&exerciseDb, queryEx, task.ExerciseId)
	if errExercise != nil {
		logrus.Errorf(errExercise.Error())
		return model.TaskResponse{}, 500
	}
	var resultPhoto []entity.PhotoExercise
	queryPhoto := fmt.Sprintf("SELECT * FROM %s WHERE exercise_id = $1", photoExerciseTable)
	errPhoto := r.db.Select(&resultPhoto, queryPhoto, exerciseDb.Id)
	if errPhoto != nil {
		logrus.Errorf(errPhoto.Error())
		return model.TaskResponse{}, 500
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

	var resultParam []model.TaskParam
	queryListParam := fmt.Sprintf("SELECT * FROM %s WHERE task_id = $1", taskParamTable)
	errListParam := r.db.Select(&resultParam, queryListParam, task.Id)
	if errListParam != nil {
		logrus.Errorf(errListParam.Error())
		return model.TaskResponse{}, 500
	}
	result = model.TaskResponse{
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
	return result, 0
}

func (r *TaskPostgres) CreateTask(trainerId int, data model.AddTaskRequest) int {
	var idTask int
	queryAddTask := fmt.Sprintf("INSERT INTO %s (date, trainer_id, client_id, exercise_id, description, state) values ($1,$2,$3,$4,$5,$6) RETURNING id", taskTable)
	rowAddTask := r.db.QueryRow(queryAddTask, time.Unix(data.Date, 0), trainerId, data.ClientId, data.ExerciseId, data.Description, 0)
	if err := rowAddTask.Scan(&idTask); err != nil {
		logrus.Errorf(err.Error())
		return 500
	}
	var idParam int
	for _, param := range data.TaskParam {
		queryAddTaskParam := fmt.Sprintf("INSERT INTO %s (task_id, param_name, target, value) values ($1,$2,$3,$4) RETURNING id", taskParamTable)
		rowAddTaskParam := r.db.QueryRow(queryAddTaskParam, idTask, param.Name, param.Target, param.Value)
		if err := rowAddTaskParam.Scan(&idParam); err != nil {
			logrus.Errorf(err.Error())
			return 500
		}
	}
	return 0
}

func (r *TaskPostgres) UpdateTask(id int, data model.UpdateTaskRequest) int {
	queryTask := fmt.Sprintf("UPDATE %s SET file_feedback_url = $2, feedback_client = $3, feedback_trainer = $4, state = $5 WHERE id = $1", taskTable)
	_, err := r.db.Exec(queryTask, id, data.FileFeedbackUrl, data.FeedbackClient, data.FeedbackTrainer, data.State)
	if err != nil {
		logrus.Errorf(err.Error())
		return 500
	}
	for _, param := range data.TaskParam {
		queryTaskParam := fmt.Sprintf("UPDATE %s SET value = $2 WHERE id = $1", taskParamTable)
		_, err := r.db.Exec(queryTaskParam, param.Id, param.Value)
		if err != nil {
			logrus.Errorf(err.Error())
			return 500
		}
	}
	return 0
}
