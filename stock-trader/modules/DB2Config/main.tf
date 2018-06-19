variable "host" {
  description = "IP of host to ssh"
}

variable "root_password" {
  description = "ssh root password"
}
variable "db_password" {
  description = "db password"
}
variable "dbname" {
  default = "trader"
  description = "database name"
}
variable "db_user" {
  default = "db2inst1"
  description = "database user"
}
resource "null_resource" "DB_Config1" {
  provisioner "remote-exec" {
      inline = [
        "DB_CONT=`kubectl get pods|grep db2 |awk '{print $1}'`",
        "kubectl cp /tmp/DB2_Script.sh $DB_CONT:/database/config/db2inst1/DB2_Script.sh",
        "kubectl exec -it $DB_CONT -- chmod +x /database/config/db2inst1/DB2_Script.sh",
        "kubectl exec -it $DB_CONT -- su - db2inst1 -c \"sh /database/config/db2inst1/DB2_Script.sh ${var.dbname} ${var.db_user} ${var.db_password} \"",
      ]
  connection {
    host = "${var.host}"
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
  }
 }
}
