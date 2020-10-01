variable "IMAGE" {
	default = "heussd/git"
}

variable "GIT_VERSION" {
}
variable "TAG_VERSION" {	
}

group "default" {
	targets = ["all", "amd64", "arm64", "ppc64le", "s390x", "arm/v7", "arm/v6"]
}

target "all" {
	tags = ["${IMAGE}:latest", "${IMAGE}:${TAG_VERSION}", "${IMAGE}:v${GIT_VERSION}"]
    platforms = ["linux/amd64", "linux/arm64", "linux/ppc64le", "linux/s390x", "linux/arm/v7", "linux/arm/v6"]
}

target "amd64" {
	tags = ["${IMAGE}:latest-amd64", "${IMAGE}:${TAG_VERSION}-amd64", "${IMAGE}:v${GIT_VERSION}-amd64"]
    platforms = ["linux/amd64"]
}

target "arm64" {
	tags = ["${IMAGE}:latest-arm64", "${IMAGE}:${TAG_VERSION}-arm64", "${IMAGE}:v${GIT_VERSION}-arm64"]
    platforms = ["linux/arm64"]
}

target "ppc64le" {
	tags = ["${IMAGE}:latest-ppc64le", "${IMAGE}:${TAG_VERSION}-ppc64le", "${IMAGE}:v${GIT_VERSION}-ppc64le"]
    platforms = ["linux/ppc64le"]
}

target "s390x" {
	tags = ["${IMAGE}:latest-s390x", "${IMAGE}:${TAG_VERSION}-s390x", "${IMAGE}:v${GIT_VERSION}-s390x"]
    platforms = ["linux/s390x"]
}

target "arm/v7" {
	tags = ["${IMAGE}:latest-armv7", "${IMAGE}:${TAG_VERSION}-armv7", "${IMAGE}:v${GIT_VERSION}-armv7"]
    platforms = ["linux/arm/v7"]
}

target "arm/v6" {
	tags = ["${IMAGE}:latest-armv6", "${IMAGE}:${TAG_VERSION}-armv6", "${IMAGE}:v${GIT_VERSION}-armv6"]
    platforms = ["linux/arm/v6"]
}
