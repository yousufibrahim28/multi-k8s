docker build -t yousufibrahim28/multi-client-k8s:latest -t yousufibrahim28/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t yousufibrahim28/multi-server-k8s:latest -t yousufibrahim28/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t yousufibrahim28/multi-worker-k8s:latest -t yousufibrahim28/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push yousufibrahim28/multi-client-k8s:latest
docker push yousufibrahim28/multi-server-k8s:latest
docker push yousufibrahim28/multi-worker-k8s:latest

docker push yousufibrahim28/multi-client-k8s:$SHA
docker push yousufibrahim28/multi-server-k8s:$SHA
docker push yousufibrahim28/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yousufibrahim28/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=yousufibrahim28/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=yousufibrahim28/multi-worker-k8s:$SHA