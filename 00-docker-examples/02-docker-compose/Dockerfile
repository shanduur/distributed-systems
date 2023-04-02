# NOTE: This is a multi-stage Dockerfile. It uses two images to build and run the application.
#   1. The first image is used to build the application (thus called builder).
#       It is based on the golang:latest image.
#   2. The second image is used to run the application (thus called runtime).
#       It is based on the rockylinux/rockylinux:9-ubi-micro image.

# NOTE:
#   You can build the image using the following command:
#       docker build -t example.com/quickstart:latest .
#   And then run it using the following command:
#       docker run -it --rm example.com/quickstart:latest

# If you want to use a different builder image, you can change it here.
# This one is for building Go applications
# Other popular builder images are:
# - mcr.microsoft.com/dotnet/sdk (for .NET 7 applications)
# - docker.io/library/python(for Python 3 applications)
ARG TOOLCHAIN_VERSION=1.20
FROM docker.io/library/golang:${TOOLCHAIN_VERSION} AS builder

# set the working directory
WORKDIR /app

# copy the source code into the container
COPY . .

# disable CGO for static linking
ENV CGO_ENABLED=0

# build the application
RUN go build -o build/message-processor-service .

# If you want to use a different runtime image, you can change it here.
# This one is for running applications that have no runtime dependencies.
# You can run number of other images like:
# - docker.io/library/ubuntu:22.04 (generic Ubuntu image, not the safest or smallest)
# - gcr.io/distroless/python3-debian11 (great for Python 3 applications)
# - mcr.microsoft.com/dotnet/aspnet (adviced for .NET 7 applications)
FROM docker.io/rockylinux/rockylinux:9-ubi-micro AS runtime

# Copy the binary from the builder image (if any)
COPY --from=builder /app/build/message-processor-service /app/message-processor-service

# Do some runtime configuration here, like copying configuration files, etc.
COPY config.json /app/config.json

# Set the entrypoint to the application
ENTRYPOINT [ "/app/message-processor-service" ]

# Set the default command arguments to the application
CMD [ "-config", "/app/config.json" ]
