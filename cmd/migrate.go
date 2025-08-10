/*
Copyright © 2025 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (
	"context"
	"log"
	"os"

	"github.com/spf13/cobra"

	"github.com/LoganDarrinLee/ims/internal/db"
	"github.com/LoganDarrinLee/ims/internal/config"
)

// migrateCmd represents the migrate command
var migrateCmd = &cobra.Command{
	Use:   "migrate",
	Short: "Initiate a database migration.",
	Long: `
		This command is only responsible for running migrations on the database.

		To create a new migration file, check out scripts/new_migration.sh. 
		Migration history can be found in the logs directory.
	`,
	Run: func(cmd *cobra.Command, args []string) {
		// All migration logs will go to logs/migartions.log
		log.Println("Starting database migration.")

		// New environment configuration
		env := config.NewEnv()
		os.Setenv("PGPASSWORD", env.DBPassword)

		// New context
		ctx := context.Background()

		// Database connection
		dbpool := db.InitDB(env, ctx)
		defer dbpool.Close()

		// Migrate database
		db.MigrateDB(dbpool)
	},
}

func init() {
	rootCmd.AddCommand(migrateCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// migrateCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// migrateCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
