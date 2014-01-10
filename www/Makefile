all: build

build: 
	browserify src/app.js -o ./app.js

watch:
	watchify src/app.js -d -o ./app.js

install: 
	npm install -g watchify browserify
	cd src; npm install

