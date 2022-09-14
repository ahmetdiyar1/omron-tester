

require! 'app/tools'
<~ getDep "css/vendor2.css"
<~ getDep "js/vendor2.js"

try
    require! 'aea/defaults'
    require! 'components'

    new Ractive do
        el: \body
        template: require('./app.pug')
        onrender: ->
            @on do
                toggleValue: (ctx) ->>
                    btn = ctx.component 

                    try 
                        btn.state \doing
                        msg = await ctx.actor.send-request {topic: 'my1.write', timeout: 2000ms}
                            , [@get(\address), (if @get \boolstate => 1 else 0)]

                        throw new Error that if msg.data.err
                        @toggle \boolstate
                        btn.state \done...
                    catch
                        btn.error JSON.stringify e 


                write: (ctx) ->>
                    btn = ctx.component 
                    try 
                        btn.state \doing
                        msg = await ctx.actor.send-request {topic: 'my1.write', timeout: 2000ms}
                            , [@get(\address), +(@get \state)]

                        throw new Error that if msg.data.err
                        btn.state \done...
                    catch
                        btn.error JSON.stringify e 

                read: (ctx) ->>
                    btn = ctx.component 
                    try 
                        btn.state \doing
                        msg = await ctx.actor.send-request {topic: 'my1.read', timeout: 2000ms}
                            , [@get(\address), +(@get \size)]

                        throw new Error that if msg.data.err
                        @set \readResponse, JSON.stringify msg.data.res, null, 2
                        btn.state \done...
                    catch
                        btn.error JSON.stringify e 

        data:
            state: 1
            address: 'D0'
            size: 1
            readResponse: ''
            boolstate: 0

