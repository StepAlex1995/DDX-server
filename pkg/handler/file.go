package handler

import (
	"bytes"
	"fmt"
	"github.com/StepAlex1995/ddx-server/pkg/model"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"io"
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"
)

func (h *Handler) loadPhotoExercise(c *gin.Context) {
	_, okTrainer := c.Get(trainerId)
	if !okTrainer {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var input model.LoadFileExerciseRequest
	if err := c.ShouldBind(&input); err != nil {
		println("error = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	if err := c.ShouldBindUri(&input); err != nil {
		println("error = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	name := "image/" + uuid.New().String() + input.File.Filename
	err := c.SaveUploadedFile(input.File, name)
	if err != nil {
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}

	errCode := h.services.File.SavePhotoExercise(name, input)
	if errCode > 0 {
		newErrorResponse(c, errCode, "error add statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"status": "ok",
	})
}

func (h *Handler) downloadFile(c *gin.Context) {
	_, okUser := c.Get(userId)
	if !okUser {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	fileName := c.Param("id")
	filePath := "image/" + fileName
	c.File(filePath)
}

func (h *Handler) loadFeedbackTask(c *gin.Context) {
	_, okClient := c.Get(clientId)
	if !okClient {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	var input model.LoadFileTaskRequest

	print(c.Request)
	if err := c.ShouldBind(&input); err != nil {
		println("error 1 = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		//	return
	}
	if err := c.ShouldBindUri(&input); err != nil {
		println("error 2 = ", err.Error())
		newErrorResponse(c, http.StatusBadRequest, err.Error())
		return
	}
	name := "image/" + uuid.New().String() + input.File.Filename
	err := c.SaveUploadedFile(input.File, name)

	if err != nil {
		println("13 err =", err.Error())
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}

	errCode := h.services.LoadFeedbackTask(name, input)
	if errCode > 0 {
		println("16 err =", err.Error())
		newErrorResponse(c, errCode, "error add statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"filename": name,
	})
}

func (h *Handler) loadFeedbackTaskVideo(c *gin.Context) {
	_, okClient := c.Get(clientId)
	if !okClient {
		newErrorResponse(c, http.StatusUnauthorized, "user id not found")
		return
	}

	taskId, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		newErrorResponse(c, http.StatusBadRequest, "invalid taskId param")
		return
	}

	var content_length int64
	content_length = c.Request.ContentLength
	if content_length <= 0 || content_length > 1024*1024*1024*2 {
		log.Printf("content_length error\n")
		return
	}
	content_type_, has_key := c.Request.Header["Content-Type"]
	if !has_key {
		log.Printf("Content-Type error\n")
		return
	}
	if len(content_type_) != 1 {
		log.Printf("Content-Type count error\n")
		return
	}
	content_type := content_type_[0]
	const BOUNDARY string = "; boundary="
	loc := strings.Index(content_type, BOUNDARY)
	if -1 == loc {
		log.Printf("Content-Type error, no boundary\n")
		return
	}
	boundary := []byte(content_type[(loc + len(BOUNDARY)):])
	log.Printf("[%s]\n\n", boundary)
	//
	read_data := make([]byte, 1024*12)
	var read_total int = 0

	file_name := "image/" + uuid.New().String() + "0.mp4"
	for {
		/*file_header,*/ file_data, err := parseFromHead(read_data, read_total, append(boundary, []byte("\r\n")...), c.Request.Body)
		if err != nil {
			log.Printf("%v", err)
			return
		}
		/*
			//print("header = "+parseFromHead())
			log.Printf("FileName :%s\n", file_header.FileName)
			log.Printf("ContentType :%s\n", file_header.ContentType)
			log.Printf("Name :%s\n", file_header.Name)
			log.Printf("ContentDisposition :%s\n", file_header.ContentDisposition)
			log.Printf("ContentLength :%d\n", file_header.ContentLength)
			//
		*/

		f, err := os.Create(file_name)
		if err != nil {
			log.Printf("create file fail:%v\n", err)
			return
		}
		f.Write(file_data)
		file_data = nil

		// Need to search for Boundary
		temp_data, reach_end, err := ReadToBoundary(boundary, c.Request.Body, f)
		f.Close()
		if err != nil {
			log.Printf("%v\n", err)
			return
		}
		if reach_end {
			break
		} else {
			copy(read_data[0:], temp_data)
			read_total = len(temp_data)
			continue
		}
	}
	//

	errCode := h.services.LoadFeedbackTask(file_name, model.LoadFileTaskRequest{TaskId: taskId, File: nil})
	if errCode > 0 {
		println("16 err =", err.Error())
		newErrorResponse(c, errCode, "error add statuses")
		return
	}
	c.JSON(http.StatusOK, map[string]interface{}{
		"filename": file_name,
	})

	/*c.JSON(200, gin.H{
		"message": fmt.Sprintf("%s", "ok"),
	})*/

}

func parseFromHead(read_data []byte, read_total int, boundary []byte, stream io.ReadCloser) ( /*FileHeader,*/ []byte, error) {
	buf := make([]byte, 1024*4)
	found_boundary := false
	boundary_loc := -1
	//var file_header FileHeader
	for {
		read_len, err := stream.Read(buf)
		if err != nil {
			if err != io.EOF {
				return /*file_header,*/ nil, err
			}
			break
		}
		if read_total+read_len > cap(read_data) {
			return /*file_header,*/ nil, fmt.Errorf("not found boundary")
		}
		copy(read_data[read_total:], buf[:read_len])
		read_total += read_len
		if !found_boundary {
			boundary_loc = bytes.Index(read_data[:read_total], boundary)
			if -1 == boundary_loc {
				continue
			}
			found_boundary = true
		}
		start_loc := boundary_loc + len(boundary)
		file_head_loc := bytes.Index(read_data[start_loc:read_total], []byte("\r\n\r\n"))
		if -1 == file_head_loc {
			continue
		}
		file_head_loc += start_loc
		//ret := false
		//file_header, ret = parseFileHeader(read_data[start_loc:file_head_loc])
		//if !ret {
		//	return /*file_header,*/ nil, fmt.Errorf("ParseFileHeader fail:%s", string(read_data[start_loc:file_head_loc]))
		//}
		return /*file_header,*/ read_data[file_head_loc+4 : read_total], nil
	}
	return /*file_header,*/ nil, fmt.Errorf("reach to sream EOF")
}

func ReadToBoundary(boundary []byte, stream io.ReadCloser, target io.WriteCloser) ([]byte, bool, error) {
	read_data := make([]byte, 1024*8)
	read_data_len := 0
	buf := make([]byte, 1024*4)
	b_len := len(boundary)
	reach_end := false
	for !reach_end {
		read_len, err := stream.Read(buf)
		if err != nil {
			if err != io.EOF && read_len <= 0 {
				return nil, true, err
			}
			reach_end = true
		}
		// Todo: The following is stupid, worth optimization
		copy(read_data[read_data_len:], buf[:read_len]) // append to another buffer, just to search for convenience
		read_data_len += read_len
		if read_data_len < b_len+4 {
			continue
		}
		loc := bytes.Index(read_data[:read_data_len], boundary)
		if loc >= 0 {
			// Find the end position
			target.Write(read_data[:loc-4])
			return read_data[loc:read_data_len], reach_end, nil
		}

		target.Write(read_data[:read_data_len-b_len-4])
		copy(read_data[0:], read_data[read_data_len-b_len-4:])
		read_data_len = b_len + 4
	}
	target.Write(read_data[:read_data_len])
	return nil, reach_end, nil
}

func parseFileHeader(h []byte) (FileHeader, bool) {
	arr := bytes.Split(h, []byte("\r\n"))
	var out_header FileHeader
	out_header.ContentLength = -1
	const (
		CONTENT_DISPOSITION = "Content-Disposition: "
		NAME                = "name=\""
		FILENAME            = "filename=\""
		CONTENT_TYPE        = "Content-Type: "
		CONTENT_LENGTH      = "Content-Length: "
	)
	for _, item := range arr {
		if bytes.HasPrefix(item, []byte(CONTENT_DISPOSITION)) {
			l := len(CONTENT_DISPOSITION)
			arr1 := bytes.Split(item[l:], []byte("; "))
			out_header.ContentDisposition = string(arr1[0])
			if bytes.HasPrefix(arr1[1], []byte(NAME)) {
				out_header.Name = string(arr1[1][len(NAME) : len(arr1[1])-1])
			}
			l = len(arr1[2])
			if bytes.HasPrefix(arr1[2], []byte(FILENAME)) && arr1[2][l-1] == 0x22 {
				out_header.FileName = string(arr1[2][len(FILENAME) : l-1])
			}
		} else if bytes.HasPrefix(item, []byte(CONTENT_TYPE)) {
			l := len(CONTENT_TYPE)
			out_header.ContentType = string(item[l:])
		} else if bytes.HasPrefix(item, []byte(CONTENT_LENGTH)) {
			l := len(CONTENT_LENGTH)
			s := string(item[l:])
			content_length, err := strconv.ParseInt(s, 10, 64)
			if err != nil {
				log.Printf("content length error:%s", string(item))
				return out_header, false
			} else {
				out_header.ContentLength = content_length
			}
		} else {
			log.Printf("unknown:%s\n", string(item))
		}
	}
	if len(out_header.FileName) == 0 {
		return out_header, false
	}
	return out_header, true
}

type FileHeader struct {
	ContentDisposition string
	Name               string
	FileName           string
	ContentType        string
	ContentLength      int64
}
