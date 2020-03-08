docker build -t patrangada/multi-client:latest -t patrangada/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t patrangada/multi-server:latest -t patrangada/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t patrangada/multi-worker:latest -t patrangada/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push patrangada/multi-client:latest
docker push patrangada/multi-server:latest
docker push patrangada/multi-worker:latest

docker push patrangada/multi-client:$SHA
docker push patrangada/multi-server:$SHA
docker push patrangada/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=patrangada/multi-server:$SHA
kubectl set image deployments/client-deployment client=patrangada/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=patrangada/worker-client:$SHA
