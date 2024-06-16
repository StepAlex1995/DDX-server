package service

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/StepAlex1995/ddx-server/pkg/repository"
)

type ExerciseService struct {
	repo repository.Exercise
}

func (s *ExerciseService) GetAllPrivateExercises(trainerId int) ([]model.ExerciseResponse, int) {
	return s.repo.GetAllPrivateExercises(trainerId)
}

func NewExerciseService(repo repository.Exercise) *ExerciseService {
	return &ExerciseService{repo: repo}
}

func (s *ExerciseService) GetAllPublicExercises() ([]model.ExerciseResponse, int) {
	return s.repo.GetAllPublicExercises()
}

func (s *ExerciseService) AddExercise(trainerId int, request model.AddExerciseRequest) (int, int) {
	return s.repo.AddExercise(trainerId, request)
}

func (s *ExerciseService) CopyExercise(trainerId int, exerciseId int, request model.AddExerciseRequest) (int, int) {
	return s.repo.CopyExercise(trainerId, exerciseId, request)
}
