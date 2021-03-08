.PHONY: container
container:
	docker run --privileged --rm docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64
	docker buildx build --platform linux/arm64/v8 -t exomy image
	docker save exomy > image/exomy.tar
	gzip image/exomy.tar 

.PHONY: image
image:
	docker run --privileged --rm docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64
	docker run \
  --rm \
  --privileged \
  -v ${PWD}/image:/build:ro \
  -v ${PWD}/image/packer_cache:/build/packer_cache \
  -v ${PWD}/image/output-arm-image:/build/output-arm-image \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro \
  quay.io/solo-io/packer-builder-arm-image:v0.1.5 build ExoMyPi.json


.PHONY: image-custom
image-custom:
	docker run --privileged --rm docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64
	docker run \
  --rm \
  --privileged \
  -v ${PWD}/image:/build:ro \
  -v ${PWD}/image/packer_cache:/build/packer_cache \
  -v ${PWD}/image/output-arm-image:/build/output-arm-image \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro \
  quay.io/solo-io/packer-builder-arm-image:v0.1.5 build ExoMyPiCustom.json