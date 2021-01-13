# Устанавливаем helm

kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller \
  --clusterrole cluster-admin \
  --serviceaccount=kube-system:tiller

helm2 init --service-account tiller

# Устанавливаем публичные чарты

## Nginx ingress

helm2 search stable/nginx-ingress
helm2 upgrade --install nginx-ingress stable/nginx-ingress --namespace nginx-ingress --version 1.41.3
helm2 history nginx-ingress

## Harbor
helm2 search harbor
helm2 repo add harbor https://helm.goharbor.io
helm2 search harbor

### Идем в файл values.yaml, смотрим как настраивается ingress.
### Создаем новый файл harbor.yaml (уже создан) и кастомизируем настройку:

kubectl get svc -n nginx-ingress - вписываем IP отсюда.

### Устанавливаем chart
helm2 upgrade --install harbor harbor/harbor --namespace harbor -f harbor.yaml

### Заходим в web, проверяем что все работает

kubectl get ingress -n harbor

Креды admin/admin

helm2 delete nginx-ingress --purge
helm2 delete harbor --purge
kubectl delete pvc -n harbor database-data-harbor-harbor-database-0
kubectl delete pvc -n harbor data-harbor-harbor-redis-0
kubectl delete pvc -n harbor harbor-harbor-chartmuseum
kubectl delete pvc -n harbor harbor-harbor-jobservice
kubectl delete pvc -n harbor harbor-harbor-registry