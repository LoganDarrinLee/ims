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

// dumpschemaCmd represents the dumpschema command
var dumpschemaCmd = &cobra.Command{
	Use:   "dumpschema",
	Short: "Export/dump the current database schema.",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		// All logs will go to logs/migartions.log
		log.Println("Starting schema dump.")

		// New environment configuration
		env := config.NewEnv()
		os.Setenv("PGPASSWORD", env.DBPassword)

		// New context
		ctx := context.Background()

		// Database connection
		dbpool := db.InitDB(env, ctx)
		defer dbpool.Close()

		// Export schema for sqlc
		schemafile := "./internal/db/schema/schema.sql"
		db.DumpSchema(env, schemafile)
	},
}

func init() {
	rootCmd.AddCommand(dumpschemaCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// dumpschemaCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// dumpschemaCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
