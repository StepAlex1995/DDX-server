package repository

import (
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/entity"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/jmoiron/sqlx"
	"github.com/sirupsen/logrus"
)

type ExercisePostgres struct {
	db *sqlx.DB
}

func NewExercisePostgres(db *sqlx.DB) *ExercisePostgres {
	return &ExercisePostgres{db: db}
}

func (r *ExercisePostgres) GetAllPublicExercises() ([]model.ExerciseResponse, int) {
	var resultEx []entity.Exercise
	queryEx := fmt.Sprintf("SELECT * FROM %s WHERE is_public = $1 AND state > 0", exerciseTable)
	err := r.db.Select(&resultEx, queryEx, true)
	if err != nil {
		logrus.Errorf(err.Error())
		return nil, 500
	}
	var results []model.ExerciseResponse
	for _, ex := range resultEx {
		var resultPhoto []entity.PhotoExercise
		queryPhoto := fmt.Sprintf("SELECT * FROM %s WHERE exercise_id = $1", photoExerciseTable)
		err := r.db.Select(&resultPhoto, queryPhoto, ex.Id)
		if err != nil {
			logrus.Errorf(err.Error())
			return nil, 500
		}
		results = append(results, model.ExerciseResponse{
			Id:           ex.Id,
			Title:        ex.Title,
			Muscle:       ex.Muscle,
			TypeExercise: ex.TypeExercise,
			Equipment:    ex.Equipment,
			Difficulty:   ex.Difficulty,
			IsPublic:     ex.IsPublic,
			Description:  ex.Description,
			TrainerId:    ex.TrainerId,
			State:        ex.State,
			Photo:        resultPhoto,
		})

	}
	return results, 0
}

func (r *ExercisePostgres) GetAllPrivateExercises(trainerId int) ([]model.ExerciseResponse, int) {
	var resultEx []entity.Exercise
	queryEx := fmt.Sprintf("SELECT * FROM %s WHERE is_public = $1 AND trainer_id = $2 AND state > 0", exerciseTable)
	err := r.db.Select(&resultEx, queryEx, false, trainerId)
	if err != nil {
		logrus.Errorf(err.Error())
		return nil, 500
	}
	var results []model.ExerciseResponse
	for _, ex := range resultEx {
		var resultPhoto []entity.PhotoExercise
		queryPhoto := fmt.Sprintf("SELECT * FROM %s WHERE exercise_id = $1", photoExerciseTable)
		err := r.db.Select(&resultPhoto, queryPhoto, ex.Id)
		if err != nil {
			logrus.Errorf(err.Error())
			return nil, 500
		}
		results = append(results, model.ExerciseResponse{
			Id:           ex.Id,
			Title:        ex.Title,
			Muscle:       ex.Muscle,
			TypeExercise: ex.TypeExercise,
			Equipment:    ex.Equipment,
			Difficulty:   ex.Difficulty,
			IsPublic:     ex.IsPublic,
			Description:  ex.Description,
			TrainerId:    ex.TrainerId,
			State:        ex.State,
			Photo:        resultPhoto,
		})

	}
	return results, 0
}

func (r *ExercisePostgres) AddExercise(trainerId int, request model.AddExerciseRequest) (int, int) {
	var id int
	queryAddExercise := fmt.Sprintf("INSERT INTO %s ( title, muscle, type, equipment, difficulty, is_public, trainer_id,  description,state) values ($1,$2,$3,$4,$5,$6,$7, $8, $9) RETURNING id", exerciseTable)
	rowCreateClientStatus := r.db.QueryRow(queryAddExercise, request.Title, request.Muscle, request.TypeExercise, request.Equipment, request.Difficulty, request.IsPublic, trainerId, request.Description, 1)
	if err := rowCreateClientStatus.Scan(&id); err != nil {
		logrus.Errorf(err.Error())
		return 0, 500
	}
	return id, 0
}

func (r *ExercisePostgres) CopyExercise(trainerId int, exerciseId int, request model.AddExerciseRequest) (int, int) {
	var id int
	queryAddExercise := fmt.Sprintf("INSERT INTO %s ( title, muscle, type, equipment, difficulty, is_public, trainer_id,  description,state) values ($1,$2,$3,$4,$5,$6,$7, $8, $9) RETURNING id", exerciseTable)
	rowCreateClientStatus := r.db.QueryRow(queryAddExercise, request.Title, request.Muscle, request.TypeExercise, request.Equipment, request.Difficulty, request.IsPublic, trainerId, request.Description, 1)
	if err := rowCreateClientStatus.Scan(&id); err != nil {
		logrus.Errorf(err.Error())
		return 0, 500
	}

	var resultPhoto []entity.PhotoExercise
	queryPhoto := fmt.Sprintf("SELECT * FROM %s WHERE exercise_id = $1", photoExerciseTable)
	err := r.db.Select(&resultPhoto, queryPhoto, exerciseId)
	if err != nil {
		logrus.Errorf(err.Error())
		return -1, 500
	}

	for _, ph := range resultPhoto {
		var idPhoto int
		queryUpdateFileFeedbackTask := fmt.Sprintf("INSERT INTO %s (exercise_id, url, number) values ($1,$2,$3) RETURNING id", photoExerciseTable)
		rowCreateClientStatus := r.db.QueryRow(queryUpdateFileFeedbackTask, id, ph.Url, ph.Number)
		if err := rowCreateClientStatus.Scan(&idPhoto); err != nil {
			logrus.Errorf(err.Error())
			return -1, 500
		}
	}

	return id, 0
}
