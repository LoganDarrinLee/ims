/* 
File: internal/db/repo/repository.go 
Author: Logan Lee

Database repository layer for interacting with the database.
*/  
package repo 

import (
	"github.com/jackc/pgx/v5/pgxpool"
)

type Repository struct {
	db *Queries
}


func NewRepository(pool *pgxpool.Pool) *Repository { 
	return &Repository{db: New(pool)} 
}
