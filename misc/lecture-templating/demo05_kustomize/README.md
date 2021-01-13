# Kustomize

kustomize build overlays/dev

kubectl kustomize overlays/dev

kustomize build overlays/prod

kubectl kustomize overlays/prod

kubectl create ns dev
kubectl apply -k overlays/dev

kubectl get svc -n dev