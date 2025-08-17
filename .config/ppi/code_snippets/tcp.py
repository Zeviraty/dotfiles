import socket,os

def main(port: int):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.bind(('127.0.0.1', port))
    sock.listen(5)

    while True:
        connection,address = sock.accept()
        buffer = connection.recv(1024)
        print(buffer)
        connection.send(buffer)
        connection.close()

if __name__ == "__main__":
    main(12345)
