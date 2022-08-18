build:
	DOCKER_BUILDKIT=1 docker build -t nginx-waf-nginx-waf-1 --no-cache .

run:
	docker-compose up -d 
