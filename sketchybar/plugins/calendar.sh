#!/bin/bash

# A/a=Weekday // B/b=Month // E/e=Day H=Hour // M=Minute
#sketchybar --set $NAME label="$(date '+%A'), $(date '+%b')$(date '+%e' | sed 's/1$/1st/;s/2$/2nd/;s/3$/3rd/;s/[04-9]$/&th/'). $(date '+%H:%M')"
#sketchybar --set $NAME label="$(date '+%a'), $(date '+%b')$(date '+%e' | sed 's/1$/1st/;s/2$/2nd/;s/3$/3rd/;s/[04-9]$/&th/')."
#sketchybar --set $NAME label="$(date '+%A') $(date '+%e' | sed 's/1$/1st/;s/2$/2nd/;s/3$/3rd/;s/[04-9]$/&th/')"
sketchybar --set $NAME label="$(date '+%a') $(date '+%e')"
