variable "IMAGE" {
	default = "heussd/git"
}

variable "GIT_VERSION" {
}
variable "TAG_VERSION" {	
}

group "default" {
	targets = ["git-all", "git-amd64"]
}

target "git-all" {
	tags = ["${IMAGE}:latest", "${IMAGE}:${TAG_VERSION}", "${IMAGE}:v${GIT_VERSION}"]
    platforms = ["linux/amd64", "linux/arm64"]
}

target "git-amd64" {
	tags = ["${IMAGE}:latest-amd64", "${IMAGE}:${TAG_VERSION}-amd64", "${IMAGE}:v${GIT_VERSION}-amd64"]
    platforms = ["linux/amd64"]
}