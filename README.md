# Shipyarr

Requirements:

- [Docker](https://www.docker.com/products/docker-desktop/)
- [DirEnv](https://direnv.net/)
- [GVM](https://github.com/moovweb/gvm#installing)
- [Kubernetes](https://kubernetes.io/releases/download/)
- [mkcert](https://github.com/FiloSottile/mkcert#installation)
- [PyEnv](https://github.com/pyenv/pyenv#readme)

## Create Virtual Host

```sh
kubectl create namespace $(NAMESPACE)

mkcert -cert-file $(HOME)/home.arpa.pem -key-file $(HOME)/home.arpa-key.pem home.arpa "*.home.arpa" localhost 127.0.0.1 ::1;\
kubectl create secret tls tls-cert --cert=$(HOME)/home.arpa.pem --key=$(HOME)/home.arpa-key.pem -n $(NAMESPACE)

kubectl apply -f kubernetes.yaml -n $(NAMESPACE)
```
