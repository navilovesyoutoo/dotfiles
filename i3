# modifier key is the Windows / Super / Meta key, Mod1 is Alt
set $mod Mod4

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:Cousine Nerd Font Mono 12

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
font pango:Cousine Nerd Font Mono 12

# Start XDG autostart .desktop files using dex. See also
# https://wiki.archlinux.org/index.php/XDG_Autostart
exec --no-startup-id dex --autostart --environment i3

# Use pactl to adjust volume in PulseAudio.
set $refresh_i3status killall -SIGUSR1 i3status
# bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
# bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
# bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
# bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

bindsym XF86AudioRaiseVolume exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 1%+
bindsym XF86AudioLowerVolume exec --no-startup-id wpctl set-volume @DEFAULT_SINK@ 1%-
bindsym XF86AudioMute exec --no-startup-id wpctl set-mute @DEFAULT_SINK@ toggle

# let there be light!
bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl -d amdgpu_bl1 set +5%
bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl -d amdgpu_bl1 set 5%-

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# move tiling windows via drag & drop by left-clicking into the title bar,
# or left-clicking anywhere into the window while holding the floating modifier.
tiling_drag modifier titlebar

# start a terminal
bindsym $mod+q exec --no-startup-id i3-sensible-terminal

# start librewolf
bindsym $mod+f exec --no-startup-id librewolf

# lock screen
bindsym $mod+l exec --no-startup-id $HOME/.config/scripts/lock

# start obsidian
bindsym $mod+o exec --no-startup-id obsidian

# screenshot
bindsym $mod+Shift+s exec --no-startup-id maim -s -u | xclip -selection clipboard -t image/png
bindsym Print exec --no-startup-id maim -s -u | xclip -selection clipboard -t image/png

# start rofi and also its specific menus
bindsym $mod+s exec rofi -show drun
bindsym $mod+shift+q exec ~/.config/rofi/power.sh

# kill focused window
bindsym $mod+c kill

# start discord
bindsym $mod+d exec --no-startup-id vesktop

bindsym $mod+Shift+w exec --no-startup-id sh -c 'WALL=$(find ~/pictures/wallpaper -type f | shuf -n1) && wal -i "$WALL" && xrdb -merge ~/.cache/wal/colors.Xresources && killall -q polybar && polybar &'

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# media keys
bindsym XF86AudioPause exec --no-startup-id mpc toggle
bindsym XF86AudioNext exec --no-startup-id sh -c 'mpc pause && mpc next'
bindsym XF86AudioPrev exec --no-startup-id sh -c 'mpc pause && mpc prev'

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"

# switch to workspace
bindsym $mod+1 workspace number $ws1
bindsym $mod+2 workspace number $ws2
bindsym $mod+3 workspace number $ws3
bindsym $mod+4 workspace number $ws4
bindsym $mod+5 workspace number $ws5

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace number $ws1
bindsym $mod+Shift+2 move container to workspace number $ws2
bindsym $mod+Shift+3 move container to workspace number $ws3
bindsym $mod+Shift+4 move container to workspace number $ws4
bindsym $mod+Shift+5 move container to workspace number $ws5

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'wanna exit i3?.' -B 'yes pls :3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
}

bindsym $mod+r mode "resize"

default_border pixel 3
default_floating_border pixel 3

gaps outer 7
gaps inner 12

exec_always --no-startup-id sh -c 'source ~/.cache/wal/colors.sh; \ i3-msg "client.focused $color4 $color0 $color15 $color4 $color4"'

set_from_resource $color0 i3wm.color0 #000000
set_from_resource $color1 i3wm.color1 #ff0000
set_from_resource $color2 i3wm.color2 #00ff00
set_from_resource $color3 i3wm.color3 #0000ff
set_from_resource $fg     i3wm.foreground #ffffff
set_from_resource $bg     i3wm.background #000000

client.focused          $color2 $color2 $fg $color2
client.unfocused        $color2 $color2 $fg $color2
client.focused_inactive $color2 $color2 $fg $color2
client.urgent           $color3 $color3 $fg $color3

exec --no-startup-id clipmenud
