#!/bin/bash

SERVERS="hadoop-1 hadoop-2 hadoop-3" 
PASSWORD=kfk 
 
auto_ssh_copy_id() { 
    expect -c "set timeout -1; 
        spawn ssh-copy-id $1; 
        expect { 
            *(yes/no)* {send -- yes\r;exp_continue;} 
            *assword* {send -- $2\r;exp_continue;} 
            eof        {exit 0;} 
        }"; 
} 
 
ssh_copy_id_to_all() { 
    for SERVER in $SERVERS 
    do 
        auto_ssh_copy_id $SERVER $PASSWORD 
    done 
} 
 
ssh-keygen -t rsa -f /home/kfk/.ssh/id_rsa -P "" 
ssh_copy_id_to_all
