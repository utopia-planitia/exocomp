# Exocomp

automated updated for charts in helmfiles and container images in kubernetes yaml definitions.

## development

### build image
`docker build -t exocomp .`

### update helmfile
`docker run -ti -v $PWD:$PWD -w $PWD exocomp update-helmfile`

### update images
`docker run -ti -v $PWD:$PWD -w $PWD exocomp update-k8s-images *.yaml`
