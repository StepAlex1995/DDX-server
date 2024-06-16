package service

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/StepAlex1995/ddx-server/pkg/repository"
)

type FileService struct {
	repo repository.File
}

func (s *FileService) LoadFeedbackTask(name string, request model.LoadFileTaskRequest) int {
	return s.repo.LoadFeedbackTask(name, request)
}

func NewFileService(repo repository.File) *FileService {
	return &FileService{repo: repo}
}

func (s *FileService) SavePhotoExercise(name string, request model.LoadFileExerciseRequest) int {
	return s.repo.SavePhotoExercise(name, request)
}
