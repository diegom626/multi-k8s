#!/bin/bash
docker build -t "diegom626/multi-client:latest" -t "diegom626/multi-client:$(TAG)" -f ./client/Dockerfile ./client
docker build -t "diegom626/multi-server:latest" -t "diegom626/multi-server:$(TAG)" -f ./server/Dockerfile ./server
docker build -t "diegom626/multi-worker:latest" -t "diegom626/multi-worker:$(TAG)" -f ./worker/Dockerfile ./worker

docker push diegom626/multi-client:latest
docker push "diegom626/multi-client:$(TAG)"

docker push diegom626/multi-server:latest
docker push "diegom626/multi-server:$(TAG)"

docker push diegom626/multi-worker:latest
docker push "diegom626/multi-worker:$(TAG)"

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=diegom626/multi-client:$(TAG)
kubectl set image deployments/server-deployment server=diegom626/multi-server:$(TAG)
kubectl set image deployments/worker-deployment worker=diegom626/multi-worker:$(TAG)