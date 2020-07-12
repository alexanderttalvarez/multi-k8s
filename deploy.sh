docker build -t alexanderttalvarez/multi-client:latest -t alexanderttalvarez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexanderttalvarez/multi-server:latest -t alexanderttalvarez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexanderttalvarez/multi-worker:latest -t alexanderttalvarez/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alexanderttalvarez/multi-client:latest
docker push alexanderttalvarez/multi-server:latest
docker push alexanderttalvarez/multi-worker:latest

docker push alexanderttalvarez/multi-client:$SHA
docker push alexanderttalvarez/multi-server:$SHA
docker push alexanderttalvarez/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexanderttalvarez/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexanderttalvarez/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexanderttalvarez/multi-worker:$SHA
