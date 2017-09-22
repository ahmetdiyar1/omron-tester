require! components

new Ractive do
    el: \body
    template: RACTIVE_PREPARSE('app.pug')
    onrender: ->
        @on do
            toggleValue: (ctx) ->
                ctx.component.fire \state, \doing

                err, res <~ ctx.actor.send-request {topic: 'public.x', timeout: 2000ms}, do
                    write:
                        addr: @get \address
                        data: if @get \boolstate => 1 else 0 

                unless err
                    @toggle \boolstate
                    ctx.component.fire \state, \done...
                else
                    ctx.component.error "Request timed out."


            write: (ctx) ->
                ctx.component.fire \state, \doing
                ctx.actor.log.log "sending relay request..."
                timeout, msg <~ ctx.actor.send-request {topic: 'public.x', timeout: 2000ms}, do
                    write:
                        addr: @get \address
                        data: [@get \state]

                if timeout
                    ctx.component.error "Request timed out."
                    return

                ctx.component.fire \state, \done...

            read: (ctx) ->
                ctx.component.fire \state, \doing
                ctx.actor.log.log "sending read request..."
                timeout, msg <~ ctx.actor.send-request {topic: 'public.x', timeout: 2000ms}, do
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
        boolstate: 0
