ariable "host" {
  description = "IP of host to ssh"
  default =""
}

variable "root_password" {
  description = "ssh root password"

}

resource "null_resource" "Secrets" {
  provisioner "remote-exec" {
      inline = [
        "DB_SVC=$(kubectl get svc | grep db2|grep NodePort | awk '{print $1}')",
        "MQ_SVC=$(kubectl get svc |grep mq|grep NodePort|awk '{print $1}')",
        "REDIS_SVC=$(kubectl get svc | grep redis | grep master | awk '{print $1}')",
        "kubectl create secret generic mq --from-literal=id=app --from-literal=pwd= --from-literal=host=$MQ_SVC --from-literal=port=1414 --from-literal=channel=DEV.APP.SVRCONN --from-literal=queue-manager=qm1 --from-literal=queue=NotificationQ",
        "kubectl create secret generic db2 --from-literal=id=db2inst1 --from-literal=pwd=db2inst1 --from-literal=host=$DB_SVC --from-literal=port=50000 --from-literal=db=trader",
        "REDIS_SECRET=$(kubectl get secret | grep redis | grep token | awk '{print $1}')",
        "REDIS_PASSWORD=$(kubectl get secret --namespace default $REDIS_SECRET -o jsonpath=\"{.data.redis-password}\" | base64 --decode)",
        "kubectl create secret generic redis --from-literal=url=redis://x:$REDIS_PASSWORD@$REDIS_SVC:6379 --from-literal=quandl-key=<your_quandl_key>",
        "kubectl create secret generic oidc --from-literal=name=stock-trader --from-literal=issuer=https://prepiam.toronto.ca.ibm.com --from-literal=auth=https://prepiam.toronto.ca.ibm.com/idaas/oidc/endpoint/default/authorize --from-literal=token=https://prepiam.toronto.ca.ibm.com/idaas/oidc/endpoint/default/token --from-literal=id=<id> --from-literal=secret=<secret_created> --from-literal=key=idaaskey --from-literal=nodeport=https://${var.host}:32389",
        "kubectl create secret generic openwhisk --from-literal=url=<openWhishk_url> --from-literal=id=<userid_of_openwhishk_app> --from-literal=pwd=<openwhisk_app_pasword>",
        "kubectl create secret generic twitter --from-literal=consumerKey=<twitter_consumer_key> --from-literal=consumerSecret=<consumer_secret> --from-literal=accessToken=<twitter_access_token> --from-literal=accessTokenSecret=<access_token_secret>",
        "kubectl create secret generic jwt  --from-literal=audience=stock-trader --from-literal=issuer=http://stock-trader.ibm.com",
        "kubectl create secret generic ingress-host --from-literal=host=10.0.0.1:31007",
      ]
  connection {
    host = "${var.host}"
    type     = "ssh"
    user     = "root"
    password = "${var.root_password}"
  }
 }
}
