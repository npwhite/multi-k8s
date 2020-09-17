docker build -t npwhite/multi-client:latest -t npwhite/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t npwhite/multi-server:latest -t npwhite/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t npwhite/multi-worker:latest -t npwhite/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push npwhite/multi-client:latest
docker push npwhite/multi-server:latest
docker push npwhite/multi-worker:latest

docker push npwhite/multi-client:$SHA
docker push npwhite/multi-server:$SHA
docker push npwhite/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=npwhite/multi-server:$SHA
kubectl set image deployments/client-deployment client=npwhite/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=npwhite/multi-worker:$SHA
