docker build -t renators/multi-client:latest -t renators/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t renators/multi-server:latest -t renators/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t renators/multi-worker:latest -t renators/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push renators/multi-client:latest
docker push renators/multi-server:latest
docker push renators/multi-worker:latest

docker push renators/multi-client:$SHA
docker push renators/multi-server:$SHA
docker push renators/multi-worker:$SHA

kublectl apply -f k8s

kublectl apply set image deployments/client-deployment client=renators/multi-client:$SHA
kublectl apply set image deployments/server-deployment server=renators/multi-server:$SHA
kublectl apply set image deployments/worker-deployment worker=renators/multi-worker:$SHA