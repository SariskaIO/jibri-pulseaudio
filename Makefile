.PHONY: help

AWS_ACCOUNT_ID = 718762496685
APP_NAME = jibri
REGION = ap-south-1
NAMESPACE = sariska


build-release:
			docker build -t ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${NAMESPACE}/$(APP_NAME):latest .


push-release:
			docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${NAMESPACE}/$(APP_NAME):latest


deploy-release:
			kubectl kustomize ./k8s | kubectl apply -k ./k8s

dev-server:
		   docker run --env-file config/docker.env \
		        --expose 5000 -p 5000:5000 \
		        --rm -it  $(AWS_ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com/$(NAMESPACE)/$(APP_NAME):latest

deploy: build-release push-release deploy-release
