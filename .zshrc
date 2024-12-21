###########################################
# 基础函数定义
###########################################

# 添加PATH的函数
addpath() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH=$1:$PATH
    fi
}

# Neovim配置选择器
# export NVIM_DEFAULT_CONFIG="AstroNvim"
function nvims() {
    items=("default"  "LazyVim" "AstroNvim")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config »" --height ~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        # 判断NVIM_DEFAULT_CONFIG是否存在
        if [[ -z $NVIM_DEFAULT_CONFIG ]]; then
            echo "未设置默认配置，请在 ~/.zshrc 中设置 NVIM_DEFAULT_CONFIG"
            config='nvim'
        else
            config=$NVIM_DEFAULT_CONFIG
        fi
    fi
    NVIM_APPNAME=$config nvim $@
}

# 代理设置函数
function set_proxy() {
        export https_proxy="http://localhost:7890"
        export http_proxy="http://localhost:7890"
}
function unset_proxy() {
        export https_proxy=""
        export http_proxy=""
}

###########################################
# 环境配置
###########################################

# pyenv配置
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

# zsh缓存目录
export ZSH_CACHE_DIR="$HOME/.cache/zsh"

# powerlevel10k即时提示符配置
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###########################################
# Zsh基础设置
###########################################

# 历史记录去重
setopt HIST_IGNORE_ALL_DUPS

# 从WORDCHARS中移除路径分隔符
WORDCHARS=${WORDCHARS//[\/]}

# 自动建议手动重绑定
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# 语法高亮设置
ZSH_HIGHLIGHT_HIGHLIGHTERS=(brackets pattern cursor)

# 添加函数路径
fpath+=~/.zfunc

###########################################
# Zim插件管理器配置
###########################################

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# 下载zimfw插件管理器
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    if (( ${+commands[curl]} )); then
        curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    else
        mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi
fi
# 安装缺失模块并更新init.zsh
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    source ${ZIM_HOME}/zimfw.zsh init -q
fi
# 初始化模块
source ${ZIM_HOME}/init.zsh

###########################################
# 开发工具配置
###########################################

# nvm配置
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# powerlevel10k主题配置
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

###########################################
# 别名设置
###########################################

# 常用命令别名
alias fd=fdfind
alias crash="sudo crash"
alias top=btop
alias v=nvim
alias vi=nvim
alias vim=nvim
alias ls=exa
alias ll="exa -l"
alias ...="cd ../.."
alias lg="lazygit --git-dir $HOME/.local/share/yadm/repo.git/ -w $HOME"

# Neovim配置别名
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

# FZF配置
export FZF_DEFAULT_OPTS="--bind=tab:down --bind='shift-tab:up' --bind='ctrl-a:toggle-all' --cycle"

###########################################
# PATH配置
###########################################

addpath "$HOME/bin"
addpath "/home/$USER/.local/share/bob/nvim-bin"
addpath "$HOME/.local/bin"
addpath "$HOME/rclone"

###########################################
# WSL特定配置
###########################################

# WSL检测函数
function is_wsl() {
    if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
        return 0
    else
        return 1
    fi
}

# WSL环境特定配置
if is_wsl ; then
    # Clash代理配置
    function clash() {
        powershell.exe Get-Process -Name "'clash-verge'" &>/dev/null
        if [ $? -eq 0 ]; then
            export https_proxy="http://172.29.16.1:7890"
            export http_proxy="http://172.29.16.1:7890"
        else
            export https_proxy=""
            export http_proxy=""
        fi
    }

    # WSL特定别名
    alias poweroff="powershell.exe Stop-Computer"
    alias reboot="powershell.exe Restart-Computer"
    alias cleardns="powershell.exe clear-DnsClientCache"
    alias code="/mnt/c/Portable\ Software/VSCode/bin/code"

    # Windows路径映射
    export WIN_CONFIG="/mnt/d/sharezhou/Documents/git"
    export Soft="/mnt/d/软件"
    export Downloads="/mnt/d/sharezhou/Downloads"
    export Onedrive="/mnt/d/onedrive" 
    export Documents="/mnt/d/sharezhou/Documents"
    export C="/mnt/c"
    export D="/mnt/d"

    # 启动时检查clash
    clash

    # VSCode启动函数
    vscode(){
        /mnt/d/软件/VSCode/Code.exe $*   &>/dev/null &
    }
fi

###########################################
# 其他配置
###########################################

export CRASHDIR="/etc/ShellCrash"

# Zsh vi模式配置
ZVM_READKEY_ENGINE=$ZVM_READKEY

source ~/encrypt.sh
