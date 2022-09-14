require! 'dcs/src/auth-helpers': {hash-passwd}
require! 'aea':{sleep}
require! 'prelude-ls': {find}

export users = 
    'public':
        passwd-hash: hash-passwd "public"
        routes:
            \@mydevice.hello.**
            \@hello-server.hi
            "my1.**"
        permissions:
            'something'
            'something-else'

    monitor: 
        passwd-hash: hash-passwd "test"
        routes: "my1.**"
