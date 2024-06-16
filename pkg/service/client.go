package service

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/StepAlex1995/ddx-server/pkg/repository"
)

type ClientService struct {
	repo repository.Client
}

func NewClientService(repo repository.Client) *ClientService {
	return &ClientService{repo: repo}
}

func (s *ClientService) GetAllClients(idTrainer int) ([]model.ClientItemResponse, int) {
	return s.repo.GetAllClients(idTrainer)
}

func (s *ClientService) GetClientById(id int, trainerId int) (model.ClientResponse, int) {

	result, err := s.repo.GetClientById(id)
	if err > 0 {
		return model.ClientResponse{}, 500
	}
	if trainerId == result.TrainerId {
		return result, 0
	}
	return model.ClientResponse{}, 400
}

func (s *ClientService) UpdateClient(id int, request model.ClientUpdateRequest) (model.ClientResponse, int) {
	err := s.repo.UpdateClient(id, request)
	if err != nil {
		return model.ClientResponse{}, 500
	}

	result, errCode := s.repo.GetClientById(id)
	if errCode > 0 {
		return model.ClientResponse{}, errCode
	}
	return result, 0
}

func (s *ClientService) GetAllStatuses(clientId int, request model.ClientStatusRequest) ([]model.ClientStatusResponse, int) {
	result, err := s.repo.GetAllStatuses(clientId, request)
	if err > 0 {
		return nil, 500
	}
	return result, 0
}

func (s *ClientService) GetStatusesById(clientId int) (model.ClientStatusResponse, int) {
	result, err := s.repo.GetStatusesById(clientId)
	if err > 0 {
		return model.ClientStatusResponse{}, 500
	}
	return result, 0
}

func (s *ClientService) AddStatus(clientId int, request model.AddClientStatusRequest) int {
	return s.repo.AddStatus(clientId, request)
}
