from tornado.httpserver import HTTPServer
from tornado.options import define,options
from tornado.web import Application
from tornado.ioloop import IOLoop
from app import App


define("port",default=8888,help="port to listen on")

def main():
    """ Construct and serve the tornado application."""

    app = Application([
        ("/",App)
    ])
    http_server = HTTPServer(app)
    http_server.listen(options.port)
    print('Listening on http://localhost:%i' % options.port)
    IOLoop.current().start()


if __name__ == "__main__":
    main()
