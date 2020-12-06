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
