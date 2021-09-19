FROM gcc

WORKDIR  /cpp_test_app

COPY . .

RUN awk '{sub("Hello World","Hi there")}1' settings.conf > temp.txt && yes | mv temp.txt ./settings.conf

RUN g++ ./main.cpp

RUN ./a.out
