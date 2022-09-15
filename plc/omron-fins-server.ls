require! 'dcs': {Actor, DcsTcpClient, sleep}
require! 'dcs/drivers/omron/fins': {OmronFinsDriver}
require! '../config': {dcs-port}

class OmronFinsActor extends Actor 
    (opts) -> 
        @driver = new OmronFinsDriver (opts)
        super opts.name 

        @on-topic "#{@name}.read", (msg) ~>>
            @log.info "Received read:", msg.data
            try 
                res = await @driver.exec 'read', msg.data.0, msg.data.1
                @send-response msg, {err: null, res}
            catch 
                @log.error "Error in read:", e 
                @send-response msg, {err: e} 

        @on-topic "#{@name}.write", (msg) ~>>
            @log.info "Received write:", msg.data
            try 
                res = await @driver.exec 'write', msg.data.0, msg.data.1
                @send-response msg, {err: null, res}
            catch 
                @log.error "Error in write:", e 
                @send-response msg, {err: e} 


    action: ->>
        val0 = 0
        while true
            try 
                res = await @driver.exec 'read', 'CB0:0', 1
                val = res.values.0
                if val0 isnt val 
                    @log.log "Value changed:", val
                    @send 'my1.read.CB0:0', val
                val0 = val
                await sleep 200ms
            catch 
                @log.error "something went interesting:", e 



new OmronFinsActor {name: \my1, host: '192.168.250.9'}

new DcsTcpClient port: dcs-port .login {user: "monitor", password: "test"}
