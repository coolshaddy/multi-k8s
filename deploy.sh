docker build -t coolshaddy81/multi-client:latest -t coolshaddy81/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t coolshaddy81/multi-server:latest -t coolshaddy81/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t coolshaddy81/multi-worker:latest -t coolshaddy81/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push coolshaddy81/multi-client:latest
docker push coolshaddy81/multi-server:latest
docker push coolshaddy81/multi-worker:latest

docker push coolshaddy81/multi-client:$SHA
docker push coolshaddy81/multi-server:$SHA
docker push coolshaddy81/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/client-deployment client=coolshaddy81/multi-client:$SHA
kubectl set image deployment/server-deployment server=coolshaddy81/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=coolshaddy81/multi-worker:$SHA