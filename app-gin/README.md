# Quickstart

```sh
export GOVERSION=$(awk '/^go / {print $1$2}' go.mod)

gvm install $GOVERSION
gvm use $GOVERSION --default  # Optional

make install
make run-dev
```
