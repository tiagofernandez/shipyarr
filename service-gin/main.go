package main

import (
	"os"
)

func main() {
	r := setupRouter()
	r.Run("127.0.0.1:" + os.Getenv("PORT"))
}
