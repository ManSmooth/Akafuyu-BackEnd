FROM golang:1.18.1-alpine
RUN apk add git
WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

ENV DBHOST host.docker.internal
ENV DBUSER root
ENV DBPASSWORD 4321
ENV DBPORT 3306
ENV DB akafuyu

COPY ./ ./

RUN go build -o ./build/server.exe ./server.go

EXPOSE 7700
CMD ["./build/server.exe"]