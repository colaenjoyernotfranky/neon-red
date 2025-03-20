# neon-red 

This is my first i3 configuration which I use on a daily basis and it works both for a laptop system aswell as a desktop. It's pretty basic but manages to include a variety of daily use features.

### Preview

![preview](https://github.com/user-attachments/assets/c6a684d1-b7d7-4808-a554-23b6cd1bf541)

> [!NOTE]
> This config is constantly WIP and things are getting added as I go through daily use. Some features might be missing, some might not match the them etc.

> [!IMPORTANT]
> I use an NVIDIA GPU. Check the `.config/i3/pc/autostart` file after installation in case the settings are not fit for your system.

### Installation 

* Before pulling, install the required packages:  
  ```
  yay -Sy nm-applet dunst pasystray flameshot picom-pijulius-next-git blueman-applet i3blocks pipewire feh kitty pactl rofi xcolor nemo
  ```
  (If you have an NVIDIA GPU in your system, follow a guide on how to set up your drivers correctly and install the necessary drivers aswell as nvidia-settings)

* Then pull the repository into your `.config` folder:
  ```
  git clone https://github.com/colaenjoyernotfranky/neon-red ~/.config/i3
  ```

* Copy `.xinitrc` to your `HOME` directory and make it executable.

* Depending on the system, set `MY_HOSTNAME` inside of `.xinitrc` to either `"laptop"` or `"pc"`  
  (When `startx` gets executed, this wilL set the `MY_HOSTNAME` environmental variable and automaticaly use the configs for the specified system.)

* Install `JetBrainsMono Nerd Font`

* Reload i3 with `Super + Shift + R`

### Keybindings

* Shared

  | Keybind | Command |
  | --- | --- |
  | Super + Return | Kitty |
  | Super + Q | Close window |
  | Super + F | Toggle fullscreen |
  | Super + Arrow keys | Change window focus |
  | Super + Shift + Arrow keys | Move focused window |
  | Super + D | Rofi |
  | Super + C | Colorpicker |
  | Super + Shift + S | Take a Screenshot |
  | Super + L | Powermenu |
  | Super + N | Nemo file manager |
  | F1 - F10 | Workspace 1-10 |
  | Super + F1 - F10 | Move window to Workspace 1-10 |
  | Super + Tab | Next Workspace |
  | Super + R | Resize mode |
  | **Media keys** | Media key things |
  

* PC only

  | Keybind | Command |
  | --- | --- |
  | Super + Shift + Home | Gaming mode - Disables all binds |
  | Super + Home | Exit Gaming mode |

* Laptop only

  | Keybind | Command |
  | --- | --- |
  | **Brightness keys** | Change brightness |

### Future plans

- [ ] Installation script to automate the process.
