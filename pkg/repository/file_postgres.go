package repository

import (
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/jmoiron/sqlx"
	"github.com/sirupsen/logrus"
)

type FilePostgres struct {
	db *sqlx.DB
}

func (r *FilePostgres) LoadFeedbackTask(name string, request model.LoadFileTaskRequest) int {
	queryTask := fmt.Sprintf("UPDATE %s SET file_feedback_url = $2 WHERE id = $1", taskTable)
	_, err := r.db.Exec(queryTask, request.TaskId, name)
	if err != nil {
		logrus.Errorf(err.Error())
		return 500
	}
	return 0
}

func NewFilePostgres(db *sqlx.DB) *FilePostgres {
	return &FilePostgres{db: db}
}

func (r *FilePostgres) SavePhotoExercise(name string, request model.LoadFileExerciseRequest) int {
	var id int
	queryUpdateFileFeedbackTask := fmt.Sprintf("INSERT INTO %s (exercise_id, url, number) values ($1,$2,$3) RETURNING id", photoExerciseTable)
	rowCreateClientStatus := r.db.QueryRow(queryUpdateFileFeedbackTask, request.ExerciseId, name, request.Number)
	if err := rowCreateClientStatus.Scan(&id); err != nil {
		logrus.Errorf(err.Error())
		return 500
	}
	return 0
}
