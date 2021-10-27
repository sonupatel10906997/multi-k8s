docker build -t sonupatel10906997/multi-client:latest -t sonupatel10906997/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sonupatel10906997/multi-server:latest -t sonupatel10906997/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sonupatel10906997/multi-worker:latest -t sonupatel10906997/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sonupatel10906997/multi-client:latest
docker push sonupatel10906997/multi-worker:latest
docker push sonupatel10906997/multi-server:latest

docker push sonupatel10906997/multi-client:$SHA
docker push sonupatel10906997/multi-worker:$SHA
docker push sonupatel10906997/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sonupatel10906997/multi-server:$SHA
kubectl set image deployment/client-deployment client=sonupatel10906997/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=sonupatel10906997/multi-worker:$SHA
