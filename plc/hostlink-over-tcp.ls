require! 'dcs': {Actor, TCPProxyClient}
require! 'dcs/protocols/omron/hostlink': {HostlinkTcpServer}
require! '../config': {dcs-port}

new HostlinkTcpServer!
new TCPProxyClient port: dcs-port .login {user: "monitor", password: "test"}