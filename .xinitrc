setxkbmap -layout us,bg -variant ",phonetic" -option 'grp:lalt_lshift_toggle'

xrdb ~/.Xresources 

bash ~/.screenlayout/dual-s-conf.sh & 

nitrogen --restore &

flameshot &

dunst &

udiskie &

exec i3
