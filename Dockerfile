# First Stage: Build the Go application
FROM golang:1.20 AS builder
WORKDIR /app

# Copy Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod tidy

# Copy application source code
COPY . .

# Build the Go application
RUN go build -o main .

# Second Stage: Create a minimal runtime image
FROM alpine:latest
WORKDIR /root/

# Install CA certificates
RUN apk --no-cache add ca-certificates

# Copy the compiled binary from the first stage
COPY --from=builder /app/main .

# Expose port 8080 and run the application
EXPOSE 8080
CMD ["./main"]