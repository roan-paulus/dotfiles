# Install all needed packages for a new system.
# !! Review this list before running; this is just a pacman -Qe export
# TODO: Maybe instead just dump the list and save that?
# TODO: enable services with `sudo systemctl enable` ?
# TODO: Add comments and automaticly install nerd fonts or other needed things. 
pacman -Sy \
    base \
    base-devel \
    bluez \
    bluez-utils \
    brightnessctl \
    docker \
    docker-buildx \
    efibootmgr \
    firefox \
    fzf \ # Fuzzy file searching 
    git \
    github-cli \
    grim \
    gst-plugin-pipewire \
    hypridle \
    hyprland \
    hyprlock \
    hyprpaper \
    hyprpicker \
    hyprpolkitagent \
    intel-ucode \
    jq \
    kitty \
    libnotify \
    libpulse \
    libreoffice-still \
    linux \
    linux-firmware \
    mako \  # Notications for hyprland.
    man-db \
    neovim \
    networkmanager \
    noto-fonts-emoji \
    openssh \
    pass \
    pavucontrol \
    pipewire \
    pipewire-alsa \
    pipewire-jack \
    pipewire-pulse \
    qt5-wayland \
    ripgrep \
    slurp \
    sof-firmware \
    unzip \
    uwsm \
    vi \
    waybar \
    wireplumber \
    wl-clipboard \
    wofi \
    xdg-desktop-portal-gtk \ # Firefox dependency, nice for hyperland too 
    xdg-desktop-portal-hyprland \
    yazi \
    zip
