.PHONY: image
image-build:
	podman build -t quay.io/jmckind/hydroxide .

.PHONY: image
image-push:
	podman push quay.io/jmckind/hydroxide
