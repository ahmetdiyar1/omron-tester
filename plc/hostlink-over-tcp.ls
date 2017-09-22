require! 'dcs': {Actor, sleep, TCPProxyClient}
require! 'dcs/connectors/omron': {OmronProtocolActor, HostlinkProtocol}
require! '../config': {dcs-port}
require! 'net'


server = net.create-server (socket) ->
    transport = socket
    protocol = new HostlinkProtocol transport
    connector = new OmronProtocolActor protocol, do
        subscribe: 'public.**'

    transport.on \end, ~>
        connector.kill!

server.listen 2000, '0.0.0.0', ~>
    console.log "Hostlink Server started listening on port: 2000"

new TCPProxyClient port: dcs-port .login {user: "monitor", password: "test"}
