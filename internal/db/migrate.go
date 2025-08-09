package db

import (
	"log"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/jackc/pgx/v5/stdlib"
	"github.com/pressly/goose/v3"
)

// Migrate with goose. Takes connection pool and converts into *database/sql.DB
func MigrateDB(dbpool *pgxpool.Pool) {
	// Set goose dialect to postgres
	if err := goose.SetDialect("postgres"); err != nil {
		log.Fatal(err)
	}

	// Convert database connection pool to *sql.DB for goose
	db := stdlib.OpenDBFromPool(dbpool)
	if err := goose.Up(db, "./internal/db/migrations"); err != nil {
		log.Fatal(err)
	}

	// Explicitly close db connection, not the pool
	if err := db.Close(); err != nil {
		log.Fatal(err)
	}

	// Successful database migration.
	log.Println("Database successfully migrated.")
}
