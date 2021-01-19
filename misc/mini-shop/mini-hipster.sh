minikube delete

# minikube ipvs
minikube start --extra-config=kube-proxy.mode=ipvs
kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
kubectl get pods -n kube-system | grep kube-proxy | cut -d ' ' -f 1 | xargs -n 1 -I {} kubectl delete pods {} -n kube-system

# MetalLB
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
# kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl apply -f metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
sudo ip route add 172.17.255.0/24 via 192.168.49.2
kubectl apply -f metallb-config.yaml

# ingress
#kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
kubectl apply -f nginx-ingress-baremetal.yaml
# kubectl apply -f frontend-lb.yaml 
kubectl apply -f nginx-lb.yaml 

sleep 60
# hipster-shop
kubectl create ns hipster-shop
helm dep update hipster-shop
helm upgrade --install hipster-shop hipster-shop --namespace hipster-shop


