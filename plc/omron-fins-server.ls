require! 'dcs': {Actor, DcsTcpClient}
require! 'dcs/drivers/omron/fins': {OmronFinsDriver}
require! '../config': {dcs-port}

class OmronFinsActor extends Actor 
    (opts) -> 
        super opts.name 
        driver = new OmronFinsDriver (opts)
        @on-topic "#{@name}.read", (msg) ~>>
            @log.info "Received read:", msg.data
            try 
                res = await driver.exec 'read', msg.data.0, msg.data.1
                @send-response msg, {err: null, res}
            catch 
                @log.error "Error in read:", e 
                @send-response msg, {err: e} 

        @on-topic "#{@name}.write", (msg) ~>>
            @log.info "Received write:", msg.data
            try 
                res = await driver.exec 'write', msg.data.0, msg.data.1
                @send-response msg, {err: null, res}
            catch 
                @log.error "Error in write:", e 
                @send-response msg, {err: e} 


new OmronFinsActor {name: \my1, host: '192.168.250.9'}

new DcsTcpClient port: dcs-port .login {user: "monitor", password: "test"}
