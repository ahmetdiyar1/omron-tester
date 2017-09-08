require! 'dcs': {TCPProxyClient}
require! 'dcs/protocols/omron/fins': {OmronFinsClient}
require! '../servers/configuration': {dcs-port}

new OmronFinsClient {name: \my1}
new TCPProxyClient port: dcs-port .login {user: "monitor", password: "test"}
