FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY go.mod ./

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /app/myapp .

# RUN Stage
FROM scratch

WORKDIR /app

COPY --from=builder /app/myapp /app/myapp

EXPOSE 8080

ENTRYPOINT ["/app/myapp"]

# default entrypoint args, can be replace by docker run
# CMD ["--config=config.toml"]
