package service

import (
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/StepAlex1995/ddx-server/pkg/repository"
)

type MsgService struct {
	repo repository.Msg
}

func NewMsgService(repo repository.Msg) *MsgService {
	return &MsgService{repo: repo}
}

func (s *MsgService) GetAllMsgByTaskId(taskId int) ([]model.MsgResponse, int) {
	return s.repo.GetAllMsgByTaskId(taskId)
}

func (s *MsgService) SendMsg(data model.AddMsgRequest) int {
	return s.repo.SendMsg(data)
}

func (s *MsgService) GetAllDiscussionByClientId(client int) ([]model.Discussion, int) {
	return s.repo.GetAllDiscussionByClientId(client)
}

func (s *MsgService) GetAllDiscussionByTrainerId(trainer int) ([]model.Discussion, int) {
	return s.repo.GetAllDiscussionByTrainerId(trainer)
}
