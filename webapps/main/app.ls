require! components
require! 'actors': {RactiveActor}

new Ractive do
    el: \body
    template: RACTIVE_PREPARSE('app.pug')
    onrender: ->
        actor = new RactiveActor this, 'main'
        @on do
            toggleRelay: (ctx) ->
                ctx.component.fire \state, \doing
                actor.log.log "sending relay request..."
                timeout, msg <~ actor.send-request {topic: 'public.x', timeout: 2000ms}, do
                    write:
                        addr: @get \address
                        data: [@get \state]

                if timeout
                    ctx.component.error "Request timed out."
                    return

                ctx.component.fire \state, \done...

            read: (ctx) ->
                ctx.component.fire \state, \doing
                actor.log.log "sending read request..."
                timeout, msg <~ actor.send-request {topic: 'public.x', timeout: 2000ms}, do
                    read:
                        addr: @get \address
                        size: [@get \size]

                if timeout
                    ctx.component.error "Request timed out."
                    return

                @set \readResponse, JSON.stringify msg.payload.res, null, 2

                ctx.component.fire \state, \done...


    data:
        state: 1
        address: 'R92'
        size: 1
        readResponse: ''
