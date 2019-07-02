# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM layershop.dangdang.com/cnlab/knative-build/golang

# Copy the local package files to the container's workspace.
ADD . /knative-build-demo

# Move into the directory with our code and build it
WORKDIR /knative-build-demo
RUN go build 

# Run our application by default when the container starts.
ENTRYPOINT ./knative-build-demo

# Document that the service listens on port 8080.
EXPOSE 8080
