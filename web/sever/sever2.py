# -*- coding: utf-8 -*-
# @Time    : 2018/8/21 下午3:11
# @Author  : FaceBook
# @File    : sever2.py
# @Software: PyCharm

from wsgiref.simple_server import make_server
import time

def current_time(requst):
    f = open("current_time.html","rb")
    data = f.read()
    cur_time = time.ctime(time.time())
    data = str(data,"utf8").replace("!cur_time!",str(cur_time))
    return [data.encode("utf8")]

def f1(requst):
    return [b'<h1> python web  </h1>']


def f2(requst):
    return ['<h1>404</h1>'.encode("utf8")]

def login(requst):
    print(requst["QUERY_STRING"])
    return [b'<h1> login sucessfully </h1>']

def routers():
    urlPatterns = (
        ('/book', f1),
        ('/book1', f1),
        ('/web', f2),
        ('/web1', f2),
        ('/web2', f2),
        ('/web3', f2),
        ('/web4', f2),
        ('/login', login),
        ('/current_time', current_time)
    )
    return urlPatterns


def application(environ, start_response):
    print(environ)
    print("environ", environ["PATH_INFO"])
    path = environ["PATH_INFO"]
    start_response('200 ok', [('Content_Type', 'text/html')])

    urlpatters = routers()
    func = None
    for item in urlpatters:
        if item[0] == path:
            func = item[1]
            break
    if func:
        return func(environ)
    else:
        return f2(environ)


httpd = make_server('', 8081, application)
print('severing http on port 8081')
httpd.serve_forever()

