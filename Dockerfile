# syntax=docker/dockerfile:1

FROM golang:1.19 AS builder
WORKDIR /go/src/github.com/OwO-Network/DeepLX
COPY main.go ./
COPY go.mod ./
COPY go.sum ./
RUN go get -d -v ./
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o deeplx .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /go/src/github.com/OwO-Network/DeepLX/deeplx /app/deeplx
CMD ["/app/deeplx"]
