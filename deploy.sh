docker build -t franciscomcg/multi-client:latest -t franciscomcg/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t franciscomcg/multi-server:latest -t franciscomcg/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t franciscomcg/multi-worker:latest -t franciscomcg/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push franciscomcg/multi-client:latest
docker push franciscomcg/multi-server:latest
docker push franciscomcg/multi-worker:latest
docker push franciscomcg/multi-client:$SHA
docker push franciscomcg/multi-server:$SHA
docker push franciscomcg/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=franciscomcg/multi-server:$SHA
kubectl set image deployments/client-deployment client=franciscomcg/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=franciscomcg/multi-worker:$SHA
