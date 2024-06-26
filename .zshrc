addpath() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH=$1:$PATH
    fi
}

# export NVIM_DEFAULT_CONFIG="AstroNvim"
function nvims() {
    items=("default"  "LazyVim" "AstroNvim")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config »" --height ~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        # 判断NVIM_DEFAULT_CONFIG是否存在
        if [[ -z $NVIM_DEFAULT_CONFIG ]]; then
            echo "No default config set. Please set NVIM_DEFAULT_CONFIG in your ~/.zshrc"
            config='nvim'
        else
            config=$NVIM_DEFAULT_CONFIG
        fi
    fi
    NVIM_APPNAME=$config nvim $@
}

function set_proxy() {
        export https_proxy="http://localhost:7890"
        export http_proxy="http://localhost:7890"
}
function unset_proxy() {
        export https_proxy=""
        export http_proxy=""
}

# pyenv
if [  -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    python --version > /dev/null 2>&1
    if [ $? -eq 0 ]; then
    else
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi

fi

# zsh cache
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

fpath+=~/.zfunc

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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias fd=fdfind
alias crash="sudo crash"
alias top=btop
alias v=nvim
alias vi=nvim
alias vim=nvim
alias ag=chatgpt
alias ls=exa
alias ll="exa -l"
alias ...="cd ../.."
alias lg="lazygit --git-dir $HOME/.local/share/yadm/repo.git/ -w $HOME"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
export FZF_DEFAULT_OPTS="--bind=tab:down --bind='shift-tab:up' --bind='ctrl-a:toggle-all' --cycle"

addpath "$HOME/bin"
addpath "/home/$USER/.local/share/bob/nvim-bin"
addpath "$HOME/.local/bin"
addpath "$HOME/rclone"

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
    export WIN_CONFIG="/mnt/d/zibo/Documents/git"
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

export CRASHDIR="/etc/ShellCrash"

# Change to Zsh's default readkey engine
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
export ZVM_VI_EDITOR=nivm
# set_proxy
export GEMINI_API_KEY="AIzaSyB2kW83mQhozH22TeRopdr0g_3EN7O5HcA"
export OPENAI_API_KEY="KLT7tfcIW3pyupc149B25e8aB85a4dCb86C8812fA0E7307f"
export GPG_TTY=$(tty)
