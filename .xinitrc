setxkbmap -layout us,bg -variant ",phonetic" -option 'grp:lalt_lshift_toggle'

xrdb ~/.Xresources 

bash ~/.screenlayout/dual-s-conf.sh & 

nitrogen --restore &

nvidia-settings --assign CurrentMetaMode="HDMI-0: nvidia-auto-select +1080+420 {ForceCompositionPipeline=On}, DP-0: nvidia-auto-select +0+0 {ForceCompositionPipeline=On, Rotation=270}" &

flameshot &

dunst &

udiskie &

exec i3
