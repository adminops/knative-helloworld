FROM layershop.dangdang.com/cnlab/knative-build/golang AS builder
ADD . /knative-build-demo
WORKDIR /knative-build-demo
RUN CGO_ENABLED=0 GOOS=linux go build 

FROM layershop.dangdang.com/cnlab/knative/alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /knative-build-demo
COPY --from=builder /knative-build-demo/knative-build-demo .

ENTRYPOINT ./knative-build-demo
EXPOSE 8080
