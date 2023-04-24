# web search
export ZSH_WEB_SEARCH_ENGINES=(gith "https://github.com/")
# pyenv
if [  -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# zsh cache
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
# encrypt zsh
source "$HOME/.encrypt.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export ZDOTDIR="$HOME/.config/zsh"
# export ZIM_CONFIG_FILE="$HOME/.config/zsh/zimrc"
# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#


# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    if (( ${+commands[curl]} )); then
        curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    else
        mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
zstyle ':zim:zmodule' use 'degit'
# }}} End configuration added by Zim install

# Set editor default keymap to emacs (`-e`) or vi (`-v`)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:$HOME/rclone"

# statship configure
# eval "$(starship init zsh)"
# export STARSHIP_CONFIG="$HOME/.config/starship.toml"

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'


    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias top=htop
alias v=nvim
alias vi=nvim
alias vim=nvim

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"

bindkey -M vicmd "H" vi-beginning-of-line
bindkey -M vicmd "L" vi-end-of-line

# 判断当前系统是不是wsl
function is_wsl() {
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
        return 0
    else
        return 1
    fi
}

if is_wsl ; then
    function clash() {
        powershell.exe Get-Process -Name "'Clash for Windows'" &>/dev/null
        if [ $? -eq 0 ]; then
            export https_proxy="http://172.20.160.1:7893"
            export http_proxy="http://172.20.160.1:7893"
        else
            export https_proxy=""
            export http_proxy=""
        fi
    }
    alias poweroff="powershell.exe Stop-Computer"
    alias reboot="powershell.exe Restart-Computer"
    alias cleardns="powershell.exe clear-DnsClientCache"
    alias code="/mnt/c/Portable\ Software/VSCode/bin/code"
    export Soft="/mnt/c/Portable Software"
    export Downloads="/mnt/d/zibo/Downloads"
    export Onedrive="/mnt/d/onedrive"
    export Documents="/mnt/d/zibo/Documents"
    export C="/mnt/c"
    export D="/mnt/d"
    clash
    vscode(){
        /mnt/c/Portable\ Software/VSCode/Code.exe $*   &>/dev/null &
    }
fi

alias nvim-lazy="NVIM_APPNAME=LazyVim /usr/bin/nvim"
alias nvim-kick="NVIM_APPNAME=kickstart /usr/bin/nvim"
alias nvim-chad="NVIM_APPNAME=NvChad /user/bin/nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim /usr/bin/nvim"
export NVIM_DEFAULT_CONFIG="AstroNvim"
function nvims() {
    items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim" "LunarVim")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height ~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "LunarVim" ]]; then
        lvim $@
        return 0
    elif [[ $config == "default" ]]; then
        # 判断NVIM_DEFAULT_CONFIG是否存在
        if [[ -z $NVIM_DEFAULT_CONFIG ]]; then
            config = ''
        else
            config=$NVIM_DEFAULT_CONFIG
        fi
    fi
    NVIM_APPNAME=$config /usr/bin/nvim $@
}
# alias nvim=nvim-astro
alias lg="lazygit --git-dir $HOME/.local/share/yadm/repo.git/ -w $HOME"
export FZF_DEFAULT_OPTS="--bind=tab:down --bind='shift-tab:up' --bind='ctrl-a:toggle-all' --cycle"
bindkey -s '^a' "nvims\n"
(( ! ${+functions[p10k]} )) || p10k finalize
