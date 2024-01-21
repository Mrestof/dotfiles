meta:
  sys configs should be set up by creating links in propper places in the
    system pointing to the appropriate file in '/etc/.dotfiles/sys/'.
  user configs should be set up in the same way, but pointing to appropriate
    files in '~<username>/.dotfiles/user/'.

for sys:
0. the following assumed to be set up by now (all from arch install guide):
  - network
  - disk partitioning, mappings like lvm and/or encryption
  optional:
    - ssd blocksize optimization
1. chroot in the new system
1. install essential packages during setup (from archiso or alike)
1. add dotfiles with personal configs:
  suggested directory: '/etc/dotfiles'
1. add personal edited keymap for linux console, edit following files:
  '/usr/local/share/kbd/keymaps/us-personal.map'
  '/etc/vconsole.conf'
1. pacman:
  - add configs by adding `Include=<custom_conf>` to 'etc/pacman.conf' file
  - update files database with `pacman -Fy`
1. add personal systemd logind conf for correct sleep behaviour:
  '/etc/systemd/logind.conf.d/'
1. change skel (auto):
  - remove bash configs
  - create dir for user-level logs: '.local/log/'
  - create all home dirs and appropriate user-dirs file
1. add personal issue:
  '/etc/issue'
1. config zsh:
  1. get grml-zsh and place it in '/etc/zsh/zshrc'
    url: 'https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc'
1. create all needed users

for users (root, mrestof):
1. all custom binaries are in dotfiles user bin dir, added to PATH with zshrc.
  - personal custom
  - luke smith's statusbar tools and other bins
  - external: wlprop, 0x0, etc...
1. all custom shared files are in dotfiles user share bin dir.
  - luke smith's emoji file
1. config zsh:
  1. source dotfiles from both '~/.zshrc' and '~/.zprofile'
1. config tmux:
  1. source dotfiles from '~/.tmux.conf'
1. config neovim:
  1. get package manager: 'https://github.com/wbthomason/packer.nvim'
  2. add personal configs to '~/.config/nvim/'
1. config git:
  1. add configs by adding include directive to '~/.config/git/config' file
1. config lynx. [u]
1. config audio.
  1. Installation of all relevant packages and a reboot should be enough.
1. config bluetooth: [u]
  1. install bluetooth: 'https://wiki.archlinux.org/title/Bluetooth'
  2. add personal configs to ...
1. config sway: [d]
  1. add personal configs to '~/.config/sway/'
  1. use bins from dotfiles
1. config foot:
  1. add personal configs to '~/.config/foot/'
1. config default monospace font, monocraft: [d]
  1. maybe create a package?
  1. get the nerd patched release
  1. install it system wide
1. config qutebrowser:
  1. add personal configs to '~/.config/qutebrowser/'
  1. add personal userscripts to '~/.local/share/qutebrowser/'
1. config zathura: [u]
  1. add personal configs to '...'
1. config mpd, mpc and other clients: [u]
1. config keepassxc & its integration with Freedesktop.org Secret Service: [d]
  1. add custom service at '~/.local/share/dbus-1/services/'
    more info: 'https://wiki.archlinux.org/title/KeePass'
1. config mpris: [d]
  1. create and enable appropriate service
    filepath: '~/.config/systemd/user/playerctld.service'
    more info: 'https://wiki.archlinux.org/title/MPRIS'
  2. download mpv extension for mpris
1. config dunst (notifications): [d]
  1. add personal configs to '~/.config/dunst/'


TODO:
change:
  keepassxc: use another tool, or fix behaviour of this one
new:
  user:
    btop: configs
    xgd: mimeapps


pkgs I use: {{{
  pkgs I need:
    lvm2
    base linux linux-firmware
    intel-ucode sof-firmware
    grub efibootmgr networkmanager git diff-so-fancy man-db man-pages openssh
    base-devel devtools gdb
    brightnessctl libpulse
    vi vim neovim moreutils entr tmux zsh zsh-completions fzf ripgrep bpython lynx archlinux-contrib pacman-contrib pkgstats reflector xdg-user-dirs progress ncdu tree translate-shell eza htop vifm ranger p7zip xz
    openbsd-netcat openvpn networkmanager-openvpn rsync aria2 yt-dlp nmap speedtest-cli bluez bluez-utils
    asciinema irssi
    pyenv python-pudb
    fatresize
    pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse alsa-utils pulsemixer
    imagemagick ffmpeg
    bat duf btop
    sway swaylock swaybg bemenu foot libnotify dunst jq slurp grim swappy wf-recorder wl-clipboard qutebrowser
    pass keepassxc
    gnome-themes-extra noto-fonts{,-emoji,-cjk}
    vimiv nsxiv swayimg zathura mpv playerctl
    gimp inkscape
    libreoffice-still thunderbird firefox-developer-edition
    telegram-desktop syncplay
    spotify-launcher
    gparted
  pkgs from aur:
    adwaita-qt5-git adwaita-qt6-git
  pkgs direct dependencies:
    required:
      qutebrowser: qt{5,6}-wayland
    optional:
      qutebrowser: python-adblock
      thunderbird: hunspell-en_us
      pinentry: kwayland5
      bpython: python-{urwid,jedi,watchdog}
      mpv: mpv-mpris
      slurp: otf-font-awesome
      translate-shell: rlwrap
      gparted: polkit, lxqt-policykit
      syncplay: pyside2
  pkgs some software often needs:
    wget unzip npm zenity
  pkgs for fun:
    fastfetch
}}}
