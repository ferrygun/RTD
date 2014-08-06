#!/usr/bin/python
import sys
from websocket import create_connection
ws = create_connection("wss://rtdp057134trial.hanatrial.ondemand.com/rtd/rtd")
#ws = create_connection("ws://localhost:8080/rtd/rtd")

arg1 = str(sys.argv[1])
print (arg1)

ws.send(arg1)
result =  ws.recv()

ws.close()
