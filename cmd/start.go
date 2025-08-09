/*
Copyright © 2025 NAME HERE <EMAIL ADDRESS>

*/
package cmd

import (
	"context"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/spf13/cobra"

	"github.com/LoganDarrinLee/ims/internal/common"
	"github.com/LoganDarrinLee/ims/internal/config"
	"github.com/LoganDarrinLee/ims/internal/db"
)

// startCmd represents the start command
var startCmd = &cobra.Command{
	Use:   "start",
	Short: "Start the local inventory manager.",
	Long: `
		Spin up the local inventory manager. Will handle local updates as well as sending 
		updates to the server on regular intervals or when the core server makes a request on 
		behalf of another inventory instance. 
	`,
	Run: func(cmd *cobra.Command, args []string) {
		env := config.NewEnv()
		ctx := context.Background()
		logger := &common.BasicLogger{}
		pool := db.InitDB(env, ctx)
		r := chi.NewRouter() 

		config.ConfigureServices(
			env,
			logger,
			pool,
			r,
		)

		s := &http.Server{
			Addr: env.ServerPort,
			Handler: r, 
		}

		go common.GracefulShutdown(ctx, s)

		log.Printf("Starting server on port: %s. Press `Ctrl + c` to exit.", s.Addr)
		s.ListenAndServe()
		log.Println("Shutting down.")
	},
}

func init() {
	rootCmd.AddCommand(startCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// startCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// startCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
