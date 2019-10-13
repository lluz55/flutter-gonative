package gonativelib

import (
	"encoding/json"
	"errors"
	"io/ioutil"
	"os"
	"path/filepath"
)

type (
	// StorageTest ...
	StorageTest struct{}
)

// Write ...
func (s *StorageTest) Write(msg string) error {
	f, err := os.Create("/sdcard/test.txt")
	if err != nil {
		return errors.New(err.Error())
	}

	defer f.Close()

	_, err = f.WriteString(msg)
	if err != nil {
		return errors.New(err.Error())
	}
	return nil
}

func (s *StorageTest) Read() (string, error) {
	d, err := ioutil.ReadFile("/sdcard/test.txt")
	if err != nil {
		return "", errors.New(err.Error())
	}

	return string(d), nil
}

// GetCwd ...
func (s *StorageTest) GetCwd() (string, error) {
	dir, err := os.Getwd()
	if err != nil {
		return "", errors.New(err.Error())
	}

	return dir, nil
}

// DirsResponse ...
type DirsResponse struct {
	Files []File `json:"files"`
}

// File ...
type File struct {
	FileName string `json:"filename"`
}

// ListFiles ...
func (s *StorageTest) ListFiles() (string, error) {

	var filesObj File
	var files []string
	var result string
	var Dirs DirsResponse

	root := "/sdcard/"
	err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		files = append(files, path)
		return nil
	})
	if err != nil {
		return "", errors.New(err.Error())
	}
	for _, file := range files {
		filesObj.FileName = file
		Dirs.Files = append(Dirs.Files, filesObj)
	}

	b, _ := json.Marshal(Dirs)

	result = string(b)
	return result, nil

}
