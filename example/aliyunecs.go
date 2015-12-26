package example


import ( "github.com/uniseraph/machine/libmachine"
"github.com/docker/machine/libmachine/log"
	"github.com/uniseraph/docker-machine-driver-aliyunecs/aliyunecs"
	"encoding/json"
	"fmt"
)

func main(){


	log.SetDebug(true)

	client := libmachine.NewClient("/tmp/automatic")

	hostname := "myecs"

	driver := aliyunecs.NewDriver(hostname, "/tmp/automatic")

	driver.AccessKey=""
	driver.SecretKey=""
	driver.ImageID=""
	driver.Region="cn-hangzhou"

	data, err := json.Marshal(driver)
	if err != nil {
		log.Fatal(err)
	}

	pluginDriver, err := client.NewPluginDriver("aliyunecs", data)
	if err != nil {
		log.Fatal(err)
	}

	h, err := client.NewHost(pluginDriver)
	if err != nil {
		log.Fatal(err)
	}

	h.HostOptions.EngineOptions.StorageDriver = "overlay"

	if err := client.Create(h); err != nil {
		log.Fatal(err)
	}

	out, err := h.RunSSHCommand("df -h")
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Results of your disk space query:\n%s\n", out)

	fmt.Println("Powering down machine now...")
	if err := h.Stop(); err != nil {
		log.Fatal(err)
	}

}
