source /usr/share/cachyos-fish-config/cachyos-config.fish

# ── Editor ────────────────────────────────────────────────────
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR nvim

# ── Greeting — custom fastfetch with random image ────────────
function fish_greeting
    # Pick a random image from ~/Pictures/fetch/
    # Supports jpg, jpeg, png, webp
    set images ~/Pictures/fetch/*.{jpg,jpeg,png,webp}
    set image $images[(random 1 (count $images))]
    fastfetch --config ~/.config/fastfetch/config.jsonc --logo $image --logo-type kitty
end

# ── Gruvbox shell colors ──────────────────────────────────────
# Syntax highlighting in the prompt — all gruvbox neutral tier
# Photosensitive safe: no harsh whites or saturated hues

# Command — amber, primary action color matching active border
set -g fish_color_command d79921

# Keywords (if, for, while) — steel blue, matches waybar #cpu
set -g fish_color_keyword 458588

# String literals — soft green, matches waybar #network
set -g fish_color_quote 8ec07c

# Parameters / arguments — warm fg0
set -g fish_color_param d5c4a1

# Operators (|, &, ;) — dusty mauve, matches waybar #memory
set -g fish_color_operator b16286

# Comments — dim warm gray, low visual weight
set -g fish_color_comment 665c54

# Errors — muted brick red, not alarming
set -g fish_color_error cc241d

# Valid path underline — aqua teal
set -g fish_color_valid_path --underline 689d6a

# Autosuggestions — dark3, barely visible until accepted
set -g fish_color_autosuggestion 665c54

# Selection highlight — dark2 bg
set -g fish_color_selection --background=504945

# Search match (ctrl+r) — amber on dark1
set -g fish_color_search_match --background=3c3836 d79921

# ── Tab completion pager ──────────────────────────────────────
set -g fish_pager_color_prefix d79921 --bold
set -g fish_pager_color_completion d5c4a1
set -g fish_pager_color_description 928374 --italics
set -g fish_pager_color_progress 665c54 --background=3c3836
set -g fish_pager_color_selected_background --background=504945

# ── Aliases ───────────────────────────────────────────────────

# eza — better ls with icons and git support
if command -q eza
    alias ls='eza --icons --group-directories-first --color=always'
    alias ll='eza -lah --icons --group-directories-first --color=always --git'
    alias tree='eza --tree --icons --color=always'
else
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto'
end

# bat — cat replacement with gruvbox syntax highlighting
if command -q bat
    alias cat='bat --theme=gruvbox-dark --style=plain'
end

# yazi — file manager shortcut
if command -q yazi
    alias y='yazi'
end

# Safety nets
alias cp='cp -i'
alias mv='mv -i'

# Quick config edits
alias fishconf='$EDITOR ~/.config/fish/config.fish'
alias fetchconf='$EDITOR ~/.config/fastfetch/config.jsonc'
