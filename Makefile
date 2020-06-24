
deps:
	go get -u github.com/gopherjs/gopherjs

build:
	docker build -t build_beatsage_extension:dev .
	docker create --name extract build_beatsage_extension:dev
	docker cp extract:/tmp/build/app.js $PWD/build/app.js
	docker rm extract