Доступа к gke нет, поэтому делал на minikube.
~~~~
minikube start
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
sudo ip route add 172.17.255.0/24 via 192.168.49.2
kubectl apply -f kubernetes-networks/metallb-config.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
kubectl apply -f kubernetes-networks/nginx-lb.yaml 
~~~~

~~~~
helm create kubernetes-templating/hipster-shop
kubectl create ns hipster-shop
helm upgrade --install hipster-shop kubernetes-templating/hipster-shop --namespace hipster-shop

helm create kubernetes-templating/frontend
helm upgrade --install frontend kubernetes-templating/frontend --namespace hipster-shop
`frontend chart
helm upgrade --install frontend kubernetes-templating/frontend --namespace hipster-shop
helm delete frontend -n hipster-shop

`dependencies
helm dep update kubernetes-templating/hipster-shop
helm upgrade --install hipster-shop kubernetes-templating/hipster-shop --namespace hipster-shop

helm upgrade --install hipster-shop kubernetes-templating/hipster-shop --namespace hipster-shop --set frontend.service.nodePort=31208

`kubecfg
helm delete hipster-shop -n hipster-shop
helm upgrade --install hipster-shop kubernetes-templating/hipster-shop --namespace hipster-shop
~~~~