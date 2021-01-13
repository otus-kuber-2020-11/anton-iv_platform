# anton-iv_platform
anton-iv Platform repository



## HW1

### 1
Поды объявлены как StaticPods: такими подами управляет локальный kubelet, control-plane не требуется.

~~~~
➜  ~ minikube ssh
docker@minikube:~$ ls -l  /etc/kubernetes/manifests
etcd.yaml
kube-apiserver.yaml
kube-controller-manager.yaml
kube-scheduler.yaml
~~~~

core-dns восстанавливает контроллер ReplicaSet:

~~~~
~ kubectl describe deployments -n kube-system 
Name:                   coredns
Namespace:              kube-system
...
NewReplicaSet:   coredns-f9fd979d6 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  56m   deployment-controller  Scaled up replica set coredns-f9fd979d6 to 1
~~~~

### 2 
Создан dockerfile c nginx
Собран образ из докер-файла, залит в Docker HUB
Создан pod-манифест из init-контейнера и созданного ранее образа с nginx

### 3
Собран и залит в Docker HUB образ hipster-frontend
Создан pod-манифест из созданного ранее образа hipster-frontend

### 3 со *
В манифест добавлены переменные окружения, без которых не стартовало приложение



## HW2

Установлен kind, поднят новый кластер

Созданы replicaset и deployment для сервиса frontend
Создан манифест для сервиса paymentservice, собран и залит в докерхаб образ (2 версии)
Созданы replicaset и deployment для сервиса paymentservice
Для paymentservice созданы деплойменты для раскатки по стратегии blue|green и reverse
Найден и отредактирован манифест DaemonSet для node-exporter так, чтобы стартовал на всех нодах, включая мастер-ноды

## HW3


## HW4

Создали деплоймент веб-пода
Создали Service (ClusterIP) для веб-подов
Включили IPVS в minikube, дропнули правила iptables, поскольку включение ipvs автоматом не чистит мусор (при включении на горячую)
Установили MetalLB:
~~~~
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
~~~~
Добавили на рабочей станции маршрут в ВМ minikube
~~~~
sudo ip route add 172.17.255.0/24 via 192.168.49.2
~~~~
Добавили манифесты сервисов для проброса dns в coredns с шарингом IP


Установили Ingress:
~~~~
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml
~~~~

### 4 со *
Установлен dashboard
~~~~
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.1.0/aio/deploy/recommended.yaml
~~~~
Написано правило для ингресса для пробрасывания запросов снаружи на сервис дашборда


## HW5

Установили Helm3, добавили репозиторий stable:
~~~~
helm repo add stable https://charts.helm.sh/stable
~~~~

Создали namespace и release nginx-ingress:
~~~~
kubectl create ns nginx-ingress
helm upgrade --install nginx-ingress stable/nginx-ingress --wait --namespace=nginx-ingress --version=1.41.3
~~~~
Добавили репозиторий с cert-manager, создали CRD:
~~~~
helm repo add jetstack https://charts.jetstack.io
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.16.1/cert-manager.crds.yaml
~~~~
Установили cert-manager:
~~~~
kubectl create ns cert-manager
helm upgrade --install cert-manager jetstack/cert-manager --wait --namespace=cert-manager --version=0.16.1
~~~~
Добавили манифест для ClusterIssuer по https://cert-manager.io/docs/configuration/acme/
