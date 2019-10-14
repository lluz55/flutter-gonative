package gonativelib

import (
	"database/sql"
	"os"

	// ...
	_ "github.com/mattn/go-sqlite3"
)

type (
	// DB ...
	DB struct{}
)

// CreateDir ...
func (d *DB) CreateDir() error {

	if _, err := os.Stat("/sdcard/GonativeTest"); os.IsNotExist(err) {
		os.Mkdir("/sdcard/GonativeTest", 0755)
		if err != nil {
			return err
		}
	}
	return nil
}

// ExistsDB ...
func (d *DB) ExistsDB() (bool, error) {

	if _, err := os.Stat("/sdcard/GonativeTest/db.sqlite"); !os.IsNotExist(err) {
		return true, nil
	}
	return false, nil
}

// OpenDB ...
func (d *DB) OpenDB() error {

	db, err := sql.Open("sqlite3", "/sdcard/GonativeTest/db.sqlite")
	if err != nil {
		return err
	}
	defer db.Close()

	sqlStmt := `
	create table foo (id integer not null primary key, name text);
	delete from foo;
	`
	_, err = db.Exec(sqlStmt)
	if err != nil {
		return err
	}

	return nil
}
