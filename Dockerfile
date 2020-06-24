FROM golang:1.12.4 AS builder

RUN go get -u github.com/gopherjs/gopherjs
# Build Args
ARG gitServer=github.com
ARG gitOrg=Benbentwo
ARG gitRepo=beatsage-extension

ENV GIT_SERVER=$gitServer
ENV GIT_ORG=$gitOrg
ENV GIT_REPO=$gitRepo

# Build the server Binary
WORKDIR /go/src/${GIT_SERVER}/${GIT_ORG}/${GIT_REPO}
ADD . ./
RUN go get -u ./...

#ARG port=80
#ARG root=/
#ENV PORT=$port
#ENV ROOT=$root
#ENV GO111MODULE=on
#
#COPY go.mod .
#COPY go.sum .
#
#RUN go mod download
#
#RUN CGO_ENABLED=0 GOOS=${target_os} GOARCH=${target_arch} go run main.go
RUN gopherjs build main.go -o /tmp/build/app.js
#FROM scratch

# Default to localhost
# Should match the default set in values.yaml

#ENTRYPOINT ["cat", "/dev/null"]
#ENTRYPOINT /app/${binary_name}
#CMD 'go run main.go'
