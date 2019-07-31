docker build -t conradpacesa/multi-client:latest -t conradpacesa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t conradpacesa/multi-server:latest -t conradpacesa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t conradpacesa/multi-worker:latest -t conradpacesa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push conradpacesa/multi-client:latest
docker push conradpacesa/multi-server:latest
docker push conradpacesa/multi-worker:latest

docker push conradpacesa/multi-client:$SHA
docker push conradpacesa/multi-server:$SHA
docker push conradpacesa/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=conradpacesa/multi-server:$SHA
kubectl set image deployments/client-deployment client=conradpacesa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=conradpacesa/multi-worker:$SHA