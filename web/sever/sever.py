# -*- coding: utf-8 -*-
# @Time    : 2018/8/21 上午11:11
# @Author  : FaceBook
# @File    : sever.py
# @Software: PyCharm

import socket

# 当前主机DNS的配置，输入命令cat /private/etc/hosts

def handle_request(client):
    buf = client.recv(1024)

    client.send("HTTP/1.1 200 OK\r\n\r\n".encode("utf8"))
    with open("index.html",'rb') as f:
        date=f.read()
        client.send(date)

def main():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # sock.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
    sock.bind(("localhost", 8001))
    sock.listen(5)

    while True:
        connection, address = sock.accept()
        handle_request(connection)
        connection.close()



if __name__ == '__main__':
    main()


# 解决端口重用的方法
# 1, 终端  sudo lsof -i:XXXX （xxx端口号）
# 2, kill PID (6047)