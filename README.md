# Description

This is an example project of [ScadaJS](https://github.com/aktos-io/scada.js) to read and write values from/to Omron PLC's, with Hostlink protocol.

# Screenshot 

![image](https://user-images.githubusercontent.com/6639874/30219707-96bc706c-94c5-11e7-9c6f-ad0d74411eb9.png)

# Development

### 1. Clone this repo and install its dependencies

> Windows users: Follow [these instructions](https://github.com/aktos-io/scada.js/blob/1f63386332ea55f911ea687c9e8c7080c0f6c904/doc/on-windows/README.md) first.

1. Open a terminal window (Windows users: right click, click "Open MSYS2 here")
2. `git clone --recursive https://github.com/aktos-io/omron-tester`
3. `cd omron-tester`
4. Create a virtual environment: `make create-virtual-env`
5. `make install-deps`

### 2. Build 

1. `make development` will start necessary services. 
2. Go to http://localhost:4011
3. Use your favourite text editor for editing files. Use `Ctrl+b, n` and `Ctrl+b, p` to navigate between Tmux tabs. 

### 3. Release 

1. `make release`. 
2. Run: `./production.service` (look into the script, it's self documentary)
3. Go to http://localhost:4011

