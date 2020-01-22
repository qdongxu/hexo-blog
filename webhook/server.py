from http.server import HTTPServer, BaseHTTPRequestHandler
import os

from io import BytesIO


class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        """
        handle the githup webhook notifications. this method does not care the concrete
        event. just pull and update simply.
        """
        content_length = int(self.headers['Content-Length'])
        body = self.rfile.read(content_length)
        self.send_response(200)
        self.end_headers()
        print(body)
        os.system("./update_blog.sh")


httpd = HTTPServer(('localhost', 8000), SimpleHTTPRequestHandler)
httpd.serve_forever()
