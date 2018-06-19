# stock-trader
# Copyright IBM Corp. 2018, 2018
This repo contains the terraform templates for configurations required by Stock Trader app via CAM. 

Service can be composed using these terraform templates using IBM Cloud Automation Manager instead of manually deploying ICP helm charts and configuraion steps(total 10-15 steps) .
The deployment with both the paths i.e Production and Development is supported .

The terraform templates modules inside stock-trader/modules - createPV ,DB2Config ,DB2ConfigExternal ,MQConfig ,WaitForPod needs the scripts in their respective folder to pe copied inside /tmp of the master node.

Modify the stock-trader/module/Secrets/main.tf file where <> is given like <db_user> to your db2 user to include the information before creation of that template.

The stockTraderServiceSample.json can be used for creating a sample service in CAM.

Also ,trader helm chart attached needs to be loaded in bx pr using command bx pr load-helm-chart --archive trader-0.1.0.tgz