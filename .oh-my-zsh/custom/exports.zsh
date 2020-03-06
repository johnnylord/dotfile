export TERM="rxvt-256color"
export EDITOR="nvim"

# Virtualbox
export VAGRANT_DEFAULT_PROVIDER='virtualbox'

# pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export CFLAGS="-I/usr/include/openssl-1.0"
export LDFLAGS="-L/usr/lib/openssl-1.0"


# Prometheus
export PROMETHEUS_ROOT="$HOME/.prometheus"
export PATH="$PROMETHEUS_ROOT:$PATH"

# Grafana
export GRAFANA_ROOT="$HOME/.grafana"
export PATH="$GRAFANA_ROOT/bin:$PATH"
