#!/bin/bash
Y_NEW=$(find ~/.mail/yahoo/INBOX/new 2>/dev/null | wc -l)
S_NEW=$(find ~/.mail/studio/INBOX/new 2>/dev/null | wc -l)

if [ "$((Y_NEW + S_NEW))" -eq 0 ]; then
    echo " 0"
else
    # This shows "Y:2 | S:1" if both have mail
    echo " Y:$Y_NEW | S:$S_NEW"
fi
