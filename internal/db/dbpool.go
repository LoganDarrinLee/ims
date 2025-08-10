package db

import (
	"context"
	"fmt"
	"log"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	pgxuuid "github.com/jackc/pgx-gofrs-uuid"

  "github.com/LoganDarrinLee/ims/internal/config"
)

// Does not close database pool
func InitDB(env *config.EnvConfig, ctx context.Context) (*pgxpool.Pool) {
	dsn := fmt.Sprintf(
		"host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		env.DBHost, env.DBPort, env.DBUser, env.DBPassword, env.DBName,
	)

	// Register the gofrs UUID type. 
	dbconfig, err := pgxpool.ParseConfig(dsn)
	if err != nil {
		panic(err)
	}
	dbconfig.AfterConnect = func(ctx context.Context, conn *pgx.Conn) error {
		pgxuuid.Register(conn.TypeMap())
		return nil
	}

	dbpool, err := pgxpool.New(ctx, dsn)
	if err != nil {
    panic(err)
	}

	// Test that our Afterims is called 
	conn, err := dbpool.Acquire(ctx)
	if err != nil {
		panic(err)
	}
	log.Println("Successfully acquired connection, now releasing.")
	conn.Release()

	log.Println("Database connected successfully.")
	return dbpool
}
