# entro-elk

https://medium.com/swlh/setting-up-elasticsearch-and-kibana-on-google-kubernetes-engine-with-eck-6823b9842140

# steps

# download operator

kubectl apply -f https://download.elastic.co/downloads/eck/1.0.1/all-in-one.yaml

# check for errors

kubectl -n elastic-system logs -f statefulset.apps/elastic-operator
kubectl get all -n elastic-system

# try a 1 node setup

kubectl apply -f elasticsearch-1-node.yaml

# check for success

kubectl get elasticsearch

# once green check for resources

kubectl get all -n default

# access from localhost with a forward proxy

kubectl port-forward service/quickstart-es-http 9200

# setup a master elastic user with a password and store it in kubernetes secrets

PASSWORD=\$(kubectl get secret quickstart-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)

# test index

curl -u "elastic:\$PASSWORD" -k "https://localhost:9200"

curl -u "elastic:\$PASSWORD" -k "https://localhost:9200/_cat/indices?v"

# simulate real world node loss

kubectl delete pod quickstart-es-default-0

# scale to 2 nodes

kubectl apply -f elasticsearch-2-nodes.yaml

kubectl get elasticsearch

# delete old elastic to setup new one with vol

kubectl delete elasticsearch quickstart

# check PVC

kubectl describe pvc

# checks elastic

kubectl get elasticsearch

# setup kibana

kubectl apply -f kibana.yaml

# access kibana

https://35.188.203.27:5601/

# get password from kube

PW=$(kubectl get secret entro-elastic-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)
echo $PW

# entro-prod

kubectl apply -f entro-elastic.yaml
kubectl apply -f entro-kibana.yaml

# get cert

kubectl get secret | grep es-http

kubectl get secret entro-elastic-es-http-certs-public -o go-template='{{index .data "tls.crt" | base64decode }}'

NAME=entro-elastic

kubectl get secret "$NAME-es-http-certs-public" -o go-template='{{index .data "tls.crt" | base64decode }}' > tls.crt
PW=$(kubectl get secret "\$NAME-es-elastic-user" -o go-template='{{.data.elastic | base64decode }}')

curl --cacert tls.crt -u elastic:$PW https://$NAME-es-http:9200/
