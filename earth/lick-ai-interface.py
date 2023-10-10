import random
from noun import * # make this a pip package some day
import socket
import os, os.path
import subprocess
import json
import sys
import requests

API_ENDPOINT = "http://localhost:3001/v1/chat/completions"

def cue_noun(data):
    x = cue(int.from_bytes(data[5:], 'little'))

    hed_len = (x.head.bit_length()+7)//8
    mark = x.head.to_bytes(hed_len,'little').decode()
    noun = x.tail
    return (mark,noun)

def ask_openai(noun_chat):
    headers = {
        "Content-Type": "application/json",
    }

    data = {
        "max_tokens": 4000,
        "messages": []
    }
    while(deep(noun_chat)):# and noun != 0): # and noun_chat.head != 0):
        #print(noun_chat)
        cur_chat = noun_chat.head
        noun_chat = noun_chat.tail

        role_len = (cur_chat.head.bit_length()+7)//8
        content_len = (cur_chat.tail.bit_length()+7)//8

        chat = dict()
        chat["role"] =  cur_chat.head.to_bytes(role_len,'little').decode()
        chat["content"] =  cur_chat.tail.to_bytes(content_len,'little').decode()
        
        data["messages"].append(chat)

    #print(data)
    

    response = requests.post(API_ENDPOINT, headers=headers, data=json.dumps(data))
    
   
    if response.status_code == 200:
          response= response.json()["choices"][0]["message"]
          role_byte = response['role'].encode('utf-8')
          res_byte = response['content'].encode('utf-8')

          head = int.from_bytes(role_byte, byteorder='little')
          tail = int.from_bytes(res_byte, byteorder='little')
          return Cell(head,tail)
    else:
         raise Exception(f"Error {response.status_code}: {response.text}")


def newt_jam(noun_data):
    jammed_data = jam(noun_data)
    length = (jammed_data.bit_length()+7)//8
    newt_data = bytearray(jammed_data.to_bytes(length,'little'))
    length = length.to_bytes(4, 'little')
    
    newt_data.insert(0,0)
    newt_data.insert(1, length[0])
    newt_data.insert(2, length[1])
    newt_data.insert(3, length[2])
    newt_data.insert(4, length[3])

    return newt_data

sock_name = '/penpai/chat.sock'
pier_path = '/home/mike/piers/zod/'

sock_path = pier_path+'.urb/dev/'+sock_name
print(sock_path)

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
sock.connect(sock_path)

while True:
    try:
        data = sock.recv(1024*64)
        mark,noun = cue_noun(data)

        chat_id = noun.head
        chats = noun.tail
        
        response = ask_openai(chats)
        
        mark_noun = int.from_bytes(mark.encode('utf-8') , byteorder='little')

        soak_noun = Cell(mark_noun, Cell(chat_id, response))
        newt_data = newt_jam(soak_noun)
        sock.send(newt_data)
    except Exception as e: print(e)
