package handler

import (
	"github.com/StepAlex1995/ddx-server/pkg/service"
	"github.com/gin-gonic/gin"
)

type Handler struct {
	services *service.Service
}

func NewHandler(services *service.Service) *Handler {
	return &Handler{services: services}
}

func (h *Handler) InitRoutes() *gin.Engine {
	router := gin.New()

	auth := router.Group("/auth")
	{
		auth.POST("/sign-up", h.signUp) //t c
		auth.POST("/sign-in", h.signIn) //t c
	}
	api := router.Group("/api", h.userIdentity)
	{
		clients := api.Group("/clients")
		{
			clients.GET("/", h.getAllClients)    //t
			clients.GET("/:id", h.getClientById) //t
			clients.PUT("/:id", h.updateClient)  //c
		}
		clientStatus := api.Group("/client-status")
		{
			clientStatus.GET("/", h.getAllClientStatusesForClient)         //c
			clientStatus.GET("/all/:id", h.getAllClientStatusesForTrainer) //t
			clientStatus.GET("/:id", h.getClientStatus)                    //t c
			clientStatus.POST("/", h.addClientStatus)                      //c
		}
		trainers := api.Group("/trainer")
		{
			trainers.GET("/", h.getTrainer)
			//trainers.PUT(":id", h.updateTrainer)
		}
		exercise := api.Group("/exercise")
		{
			exercise.GET("/", h.getPublicExercises)          //t c
			exercise.GET("/private/", h.getPrivateExercises) //t
			exercise.GET("/:id", h.getPublicExercises)       //t
			exercise.POST("/", h.addExercise)                //t
			exercise.POST("/:id", h.copyExercise)            //t
		}
		file := api.Group("/file")
		{
			file.POST("/exercise", h.loadPhotoExercise)           //t
			file.POST("/task", h.loadFeedbackTask)                //c
			file.POST("/task/video/:id", h.loadFeedbackTaskVideo) //c
			file.GET("/download/:id", h.downloadFile)             //c
		}
		task := api.Group("/task")
		{
			task.GET("/", h.getAllTaskByDay) //t c
			task.GET("/:id", h.getTaskById)  //t c
			task.POST("/", h.createTask)     //t
			task.PUT("/:id", h.updateTask)   //t c
		}
		msg := api.Group("/msg")
		{
			msg.GET("/:id", h.getAllMsgForTask)                              //t c
			msg.POST("/", h.sendMsg)                                         //t c
			msg.POST("/voice", h.sendMsgVoice)                               //t c
			msg.GET("/discussion/:id", h.getAllDiscussionForClient)          //t c
			msg.GET("/discussion/trainer/:id", h.getAllDiscussionForTrainer) //t c
		}
	}
	return router
}
