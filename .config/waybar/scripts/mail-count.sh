#!/bin/bash

# Count new mail
STUDIO_NEW=$(find ~/.mail/studio/INBOX/new 2>/dev/null | wc -l)
INKORG_NEW=$(find ~/.mail/Inkorg/INBOX/new 2>/dev/null | wc -l)
COMBI_NEW=$(find ~/.mail/mail_combi/INBOX/new 2>/dev/null | wc -l)
YAHOO_NEW=$(find ~/.mail/yahoo/INBOX/new 2>/dev/null | wc -l)
TOTAL=$((STUDIO_NEW + INKORG_NEW + COMBI_NEW + YAHOO_NEW))

# Assigning Pango colors
S_PART="<span color='#2aa198'>S:$STUDIO_NEW</span>"
I_PART="<span color='#b58900'>I:$INKORG_NEW</span>"
C_PART="<span color='#d33682'>C:$COMBI_NEW</span>"
Y_PART="<span color='#AC70DA'>Y:$YAHOO_NEW</span>"

TEXT="$S_PART | $I_PART | $C_PART | $Y_PART"
TOOLTIP="New Mail: Studio($STUDIO_NEW) Inkorg($INKORG_NEW) Combi($COMBI_NEW) Yahoo($YAHOO_NEW)"

# Assign a class based on whether there is mail or not
if [ "$TOTAL" -eq 0 ]; then
    CLASS="empty"
else
    CLASS="unread"
fi

printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$TEXT" "$TOOLTIP" "$CLASS"
