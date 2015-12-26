package main
import (
	"github.com/docker/machine/libmachine/drivers/plugin"

	"github.com/uniseraph/docker-machine-driver-aliyunecs/aliyunecs"
)




func main() {
	plugin.RegisterDriver(aliyunecs.NewDriver("", ""))
}


