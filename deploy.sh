docker build -t nuridavid/multi-client:latest -t nuridavid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nuridavid/multi-server:latest -t nuridavid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nuridavid/multi-worker:latest -t nuridavid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nuridavid/multi-client:latest
docker push nuridavid/multi-server:latest
docker push nuridavid/multi-worker:latest

docker push nuridavid/multi-client:$SHA
docker push nuridavid/multi-server:$SHA
docker push nuridavid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nuridavid/multi-server:$SHA  
kubectl set image deployments/client-deployment client=nuridavid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nuridavid/multi-worker:$SHA    