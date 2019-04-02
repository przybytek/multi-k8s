docker build -t przybytek/multi-client:latest -t przybytek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t przybytek/multi-server:latest -t przybytek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t przybytek/multi-worker:latest -t przybytek/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push przybytek/multi-client:latest
docker push przybytek/multi-server:latest
docker push przybytek/multi-worker:latest

docker push przybytek/multi-client:$SHA
docker push przybytek/multi-server:$SHA
docker push przybytek/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=przybytek/multi-server:$SHA
kubectl set image deployments/client-deployment client=przybytek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=przybytek/multi-worker:$SHA