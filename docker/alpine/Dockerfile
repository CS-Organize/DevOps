FROM alpine:3.20.3

# https://stackoverflow.com/questions/31870222/how-can-i-keep-a-container-running-on-kubernetes
CMD ["/bin/sh", "-c", "trap : TERM INT; sleep infinity & wait"]
