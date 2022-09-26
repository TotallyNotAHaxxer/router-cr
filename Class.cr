require "http/server"

module Server 
    class Base 
        def initialize
            @router = {

            } of String => ( -> String )
        end

        def run(int port)
            server = HTTP::Server.new do |ctx|
                req = ctx.request
                if @router.has_key?(req.path.to_s)
                    ctx.response.respond_with_status(200, @router[req.path.to_s].call)
                else 
                    ctx.response.respond_with_status(401, " Not found please return to the root path / ")
                end
            end
            server.listen(port)
        end
        def process(router, &block : (-> String))
            @router[router.to_s] = block
        end
    end
end
