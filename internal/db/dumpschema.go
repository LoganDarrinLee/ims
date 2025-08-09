package db

import (
	"log"
	"os"
	"os/exec"
 
	"github.com/LoganDarrinLee/ims/internal/config"
)


// Export our new schema file for sqlc to run.
func DumpSchema(env *config.EnvConfig, schemafile string) error {
	// Define pg_dump command with args
	cmd := exec.Command(
		"pg_dump",
		"-U", env.DBUser,
		"-h", env.DBHost,
		"-p", env.DBPort,
		"-s", env.DBName,
	)

	// Setup the file to dump the schema into
	outputFile, err := os.Create(schemafile)
	if err != nil {
		log.Println("Erorr with schema file: ", err)
		return err
	}
	defer outputFile.Close()
	cmd.Stdout = outputFile

	// Execute command
	if err := cmd.Run(); err != nil {
		return err
	}
	return nil
}
