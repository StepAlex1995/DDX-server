package service

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/StepAlex1995/ddx-server/pkg/repository"
)

type TrainerService struct {
	repo repository.Trainer
}

func NewTrainerService(repo repository.Trainer) *TrainerService {
	return &TrainerService{repo: repo}
}

func (s *TrainerService) GetTrainerByClientId(id int) (model.TrainerResponse, int) {
	return s.repo.GetTrainerByClientId(id)
}
