FROM golang:1.17-alpine AS build

WORKDIR /app
COPY . .

# Go modül bilgilerini oluştur
RUN go mod init myapp

# Bağımlılıkları indir
RUN go mod tidy

# Uygulamayı derle
RUN go build -o main .

FROM alpine:latest

WORKDIR /root/

COPY --from=build /app/main .

CMD ["./main"]
