import time
import BaseHTTPServer
import argparse
from urlparse import urlparse, parse_qs

# to test
# http://fox:8081/?a=1&b=2


HOST_NAME = '0.0.0.0'


class MyHandler(BaseHTTPServer.BaseHTTPRequestHandler):

    def do_HEAD(s):
        s.send_response(200)
        s.send_header("Content-type", "text/html")
        s.end_headers()

    def do_GET(s):
        print "url_param="+s.path
        """Respond to a GET request."""
        s.send_response(200)
        s.send_header("Content-type", "text/html")
        s.end_headers()
        s.wfile.write("<html><head><title>Running on port %s</title></head>" % PORT_NUMBER)
        s.wfile.write("<body><p>body</p>")
        # If someone went to "http://something.somewhere.net/foo/bar/",
        # then s.path equals "/foo/bar/".
        s.wfile.write("<p>You accessed path: %s</p>" % s.path)

        query_components = parse_qs(urlparse(s.path).query)
        for k, v in query_components.iteritems():
            s.wfile.write("<p>You passed in k: %s; v: %s</p>" % (k, v))

        s.wfile.write("</body></html>")

if __name__ == '__main__':

  parser = argparse.ArgumentParser(description='Arguments.')
  parser.add_argument('--port', type=int, dest='port', default=8081,
          help='port number')

  args = parser.parse_args()
  PORT_NUMBER=args.port
  print 'Port %s' % args.port

  server_class = BaseHTTPServer.HTTPServer
  httpd = server_class((HOST_NAME, args.port), MyHandler)
  try:
           httpd.serve_forever()
  except KeyboardInterrupt:
           pass
  httpd.server_close()
