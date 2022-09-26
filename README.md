```
 _____             _       _ 
|     |___ _ _ ___| |_ ___| |
|   --|  _| | |_ -|  _| .'| |
|_____|_| |_  |___|_| |__,|_|
          |___|              
```

This repo is a very simple router module written using crystal and here is how you use it. Basically when you call the new method it will start a new server on whatever port you use. The application will start and it is up to you to choose the route you want to create. Here is how you use it in the following example. 

The example below is of a file tree of a directory which will be our project / server 

```
├── router.cr
└── src
    └── Class.cr
```

in you're `router.cr` file require the following 

```crystal
require "./src/Class"
```

and in the src/Class.cr file paste the following or download the Class.cr file from this repo.

```crystal
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
```

now go back to the `router.cr` file and put the following 

```crystal
require "./src/Class"

puts "Application running"

application = Server::Base.new 

application.process "/" do 
    "hello there!"
end

application.process "/app" do
    a = "hello there"
    "#{a}"
end

application.run(8080)
```

When we call the variable `application` we start the base, then we define our router telling the variable application to process the route or filepath on the server `/` and if it is a path to then start a do loop which in a string form will output the text "hello there!" to the HTTP response writer. This is  very simple example and the router can not server static HTTP files right now but its rather an example. We tell the application or module to run and start the web application with an argument of type integer, this integer will be the port number. If your port number is 8080 it will run on `localhost:8080`
