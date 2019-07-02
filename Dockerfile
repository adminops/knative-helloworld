# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM layershop.dangdang.com/cnlab/knative-build/golang AS builder

# Copy the local package files to the container's workspace.
ADD . /knative-build-demo

# Move into the directory with our code and build it
WORKDIR /knative-build-demo

RUN CGO_ENABLED=0 GOOS=linux go build

FROM layershop.dangdang.com/cnlab/knative/alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /knative-build-demo

COPY --from=builder /knative-build-demo/knative-build-demo .

# Run our application by default when the container starts.
ENTRYPOINT ./knative-build-demo

# Document that the service listens on port 8080.
EXPOSE 8080
