docker build -t khangle/multi-client:latest -t khangle/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t khangle/multi-server:latest -t khangle/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t khangle/multi-worker:latest -t khangle/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push khangle/multi-client:latest
docker push khangle/multi-server:latest
docker push khangle/multi-worker:latest

docker push khangle/multi-client:$SHA
docker push khangle/multi-server:$SHA
docker push khangle/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=khangle/multi-server:$SHA
kubectl set image deployments/client-deployment client=khangle/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=khangle/multi-worker:$SHA