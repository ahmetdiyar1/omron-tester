# Description

This is an example project of [ScadaJS](https://github.com/aktos-io/scada.js) to read and write values to/from Omron PLC's, with Hostlink protocol.

# Screenshot 

![image](https://user-images.githubusercontent.com/6639874/30219707-96bc706c-94c5-11e7-9c6f-ad0d74411eb9.png)

# Install

1. Install [Node.js](https://nodejs.org/en/download/)

2. Install global dependencies (as admin/root) (if you didn't already):

       npm install -g gulp yarn livescript@1.4.0

3. Download the project template, install project dependencies:

       git clone https://github.com/aktos-io/omron-tester
       cd omron-tester
       git submodule update --init --recursive
       cd scada.js
       npm install

# Run

If you are on Linux, following commands will start everything needed for development:

1. On first terminal:

       ./uidev.service

2. On second terminal:

       ./server.service

### The Manual Way

1. Start continuous build of webapp:

       cd scada.js
       gulp --webapp main

2. Start webserver/dcsserver:

       cd servers
       ./run-ls webserver.ls

3. Start Hostlink server:

       cd plc
       ./run-ls hostlink-over-tcp.ls

4. Open your web browser and go to [http://localhost:4001](http://localhost:4001).

5. *Optional:* If you want to monitor all messaging traffic, run monitor:

        cd servers
        ./run-ls monitor.ls
