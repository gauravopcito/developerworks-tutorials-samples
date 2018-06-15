variable "host" {
  default     = ""
  description = "Host IP"
}

variable "root_password" {
  description = "ssh root password"
  default     = "passw0rd"
}

variable "qmgr" {
  default     = "qm1"
  description = "queue manager"
}

variable "qlocal" {
  default     = "NotificationQ"
  description = "local queue"
}

resource "null_resource" "MQ_Config" {
  provisioner "remote-exec" {
    inline = [
      "MQ_CONT=`kubectl get pods|grep ibm-mq |awk '{print $1}'`",
      "chmod +x /tmp/MQ_Config.txt",
      "kubectl exec -it $MQ_CONT -- runmqsc </tmp/MQ_Config.txt >/tmp/MQ_Config.log",
    ]
  }

  connection {
    host     = "${var.host}"
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
  }
}
