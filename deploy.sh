export GIT_SHA=$(git rev-parse HEAD )
docker build -t eslamfakhry/multi-client:latest -t eslamfakhry/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t eslamfakhry/multi-server:latest -t eslamfakhry/multi-server:$GIT_SHA-f ./server/Dockerfile ./server
docker build -t eslamfakhry/multi-worker:latest -t eslamfakhry/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push eslamfakhry/multi-client:latest
docker push eslamfakhry/multi-client:$GIT_SHA
docker push eslamfakhry/multi-server:latest
docker push eslamfakhry/multi-server:$GIT_SHA
docker push eslamfakhry/multi-worker:latest
docker push eslamfakhry/multi-worker:$GIT_SHA

kubectl apply -f ./k8s

kubectl set image deployment/server-deployment server=eslamfakhry/multi-server:$GIT_SHA 
kubectl set image deployment/client-deployment client=eslamfakhry/multi-client:$GIT_SHA
kubectl set image deployment/worker-deployment worker=eslamfakhry/multi-worker:$GIT_SHA 