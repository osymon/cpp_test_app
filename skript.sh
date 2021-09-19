#!/bin/bash

if ! [ -f `which git 2>&1|awk '{print $1$2}'` ]; then  apt-get install git -y || yum install git -y ; fi

if ! [ -f `which docker 2>&1|awk '{print $1$2}'` ]; then  curl -sSL https://get.docker.com/ | sh  ; service docker start ; fi

git clone https://github.com/osymon/cpp_test_app.git

cd /cpp_test_app/

echo "FROM gcc

WORKDIR  /cpp_test_app

COPY . .

RUN awk '{sub(\"Hello World\",\"Hi there\")}1' settings.conf > temp.txt && yes | mv temp.txt ./settings.conf

RUN g++ ./main.cpp

RUN ./a.out"> Dockerfile 

echo "Dockerfile
README.md"> .dockerignore

docker build -t osymon/cpp_app:test ./

#docker login

docker push osymon/cpp_app:test

