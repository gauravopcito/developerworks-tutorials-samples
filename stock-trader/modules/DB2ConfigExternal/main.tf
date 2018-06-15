variable "host" {
  description = "IP of host to ssh"
}

variable "root_password" {
  default = "passw0rd"
  description = "ssh root password"
}
variable "db_password" {
  default = "passw0rd"
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
         "chmod +x /tmp/DB2_Sript.sh",
         "su - db2inst1 -c \"sh /tmp/DB2_Sript.sh ${var.dbname} ${var.db_user} ${var.db_password}\"",
      ]
  connection {
    host = "${var.host}"
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
  }
 }
}
