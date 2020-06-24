
deps:
	go get -u github.com/gopherjs/gopherjs

build:
	docker build -t build_beatsage_extension:dev .
	docker rm extract || true
	docker create --name extract build_beatsage_extension:dev
	docker cp extract:/tmp/build/app.js $(PWD)/build/chrome-extension/app.js
	docker rm extract
	cp sample.html $(PWD)/build/chrome-extension/
	cp manifest.json $(PWD)/build/chrome-extension/