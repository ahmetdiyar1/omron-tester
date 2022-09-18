create-virtual-env:
        pip install nodeenv --user
        [[ -e virtual-env-path.sh ]] || printf "export SCADAJS_VENV_PATH=$(DIR)/scadajs-venv \nexport PATH=\$$PATH:~/.local/bin" > virtual-env-path.sh
        (source virtual-env-path.sh && cd scada.js && make create-venv)


