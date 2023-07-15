# Now copy it into our base image.
FROM golang:1.19 as build
WORKDIR /go/src/app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 go build -o /go/bin/loadgen

FROM gcr.io/distroless/static-debian11:nonroot
WORKDIR /
COPY --from=build /go/bin/loadgen /
USER 65532:65532
ENTRYPOINT ["/loadgen"]

