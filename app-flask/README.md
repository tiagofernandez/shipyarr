# Quickstart

```sh
export PYTHON_VERSION=$(cat .python-version)

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION  # Optional

make venv
source venv/bin/activate

make install
make run-dev
```
