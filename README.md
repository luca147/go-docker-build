# Gopher in the box

![Golang docker image variants](gocontainer-transparent.png)

As we know golang is a compiled language, so this benefits is a must know in terms of build a performant image size reducing the deploying time and the associted cost related to the CI/CD pipelines.

A must know technique in terms to have a optimal dockerfile is the multi-stage, without this tool we need to make the struggling to reduce the number of intermediate layers and files.

* Always compress the `RUN` commands together to avoid creating additional layer in the image.

* Add only the necesary packages ands libs

After all this points we need to getting deep in the offered base images.

## Cases of study

### Alpine

Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

### Distroless

This image made by Google team tend to be more slim than alpine, contains a minimal Linux image and can be used with mostly stacically typed languages like Go 😉.

A thing very important about this base image is if we don't need cgo we can use the `gcr.io/distroless/static` image, in other case you can use `gcr.io/distroless/base` with libc/cgo.

In the current example we disable the cgo in the build and use the static image, we keep all the goodness in this base image:

* ca-certificates
* A /etc/passwd entry for a root user
* A /tmp directory
* tzdata

[Official documentation about distroless](https://github.com/GoogleContainerTools/distroless/blob/main/base/README.md)

### Scratch

Not much to say with name scratch, this image is the primordial to every one is a empty layer and we can run our Go app only if we statically build our app.

Keep in mind we don't have an OS running, so for example the ca-certificates and the tzdata is not available and is a must to the user to attach it to the image with another packages needed.

Points to be sure after use this base image:

* Another point about this base image is the build must be statically linked, the default behaviour with `go build` make a dynamically-linked executable so in this case we have a raised error like: `no such file or directory` because our exactuable can't link to shared OS libraries.

* To build a statically-linked executable in Go we must disable the `CGO_ENABLED=0`

* We don't have ca-certificates, so keep in mind we can for example make a https call because we don't have any ca-certificate in our image


## Results

With a HelloWorld example as code

| Base Img | Size |
|----------|------|
|Scratch   |1.2MB |
|Distroless|3.56MB|
|Alpine    |7.35  |


Test yourself running `./analyze-img.sh`
