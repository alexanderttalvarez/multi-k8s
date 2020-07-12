docker build -t aelxan/multi-client:latest -t aelxan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aelxan/multi-server:latest -t aelxan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aelxan/multi-worker:latest -t aelxan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aelxan/multi-client:latest
docker push aelxan/multi-server:latest
docker push aelxan/multi-worker:latest

docker push aelxan/multi-client:$SHA
docker push aelxan/multi-server:$SHA
docker push aelxan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aelxan/multi-server:$SHA
kubectl set image deployments/client-deployment client=aelxan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aelxan/multi-worker:$SHA
