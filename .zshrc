###########################################
# 基础函数定义
###########################################

# 添加PATH的函数
addpath() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH=$1:$PATH
    fi
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


export NVIM_DEFAULT_CONFIG=""

# 检查并安装配置的函数
function check_and_install_config() {
    local config_name=$1
    local configs=("${@:2}")

    for cfg in "${configs[@]}"; do
        local name=${cfg%|*}
        local repo=${cfg#*|}
        
        if [[ $config_name == $name && ! -d ~/.config/$name ]]; then
            echo "$name config not found. Installing..."
            # 如果 repo 不包含 "://"，则默认为 GitHub 仓库
            if [[ $repo != *"://"* ]]; then
                repo="https://github.com/$repo"
            fi
            git clone $repo ~/.config/$name
            break
        fi
    done
}

function nvims() {
    # 定义配置数组
    readonly configs=(
        "default"
        "LazyVim|LazyVim/starter"
        "AstroNvim|https://github.com/AstroNvim/template"
        "NormalNvim|NormalNvim/NormalNvim"
    )
    
    # 提取配置名称用于fzf选择
    local items=()
    for cfg in "${configs[@]}"; do
        items+=("${cfg%|*}")
    done

    # 选择配置
    local config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config »" --height ~50% --layout=reverse --border --exit-0)
    
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    fi

    # 处理default配置
    if [[ $config == "default" ]]; then
        if [[ -z $NVIM_DEFAULT_CONFIG ]]; then
            config='nvim'
        else
            config=$NVIM_DEFAULT_CONFIG
            # 检查并安装默认配置
            check_and_install_config $config "${configs[@]}"
        fi
    else
        # 检查并安装选择的配置
        check_and_install_config $config "${configs[@]}"
    fi

    NVIM_APPNAME=$config nvim $@
}
###########################################
# 环境配置
###########################################

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm



###########################################
# PATH配置
###########################################

addpath "$HOME/bin"
addpath "/home/$USER/.local/share/bob/nvim-bin"
addpath "$HOME/.local/bin"
addpath "$HOME/rclone"
addpath "$HOME/.cargo/bin"

###########################################
# Zsh基础设置
###########################################

# zsh缓存目录
export ZSH_CACHE_DIR="$HOME/.cache/zsh"

# 历史记录去重
setopt HIST_IGNORE_ALL_DUPS

# 从WORDCHARS中移除路径分隔符
WORDCHARS=${WORDCHARS//[\/]}

# 语法高亮设置
ZSH_HIGHLIGHT_HIGHLIGHTERS=(brackets pattern cursor main)

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

# 启动 starship
eval "$(starship init zsh)"

export _ZO_DATA_DIR=$HOME/z
# 启动 zoxide
eval "$(zoxide init zsh)"

###########################################
# 别名设置
###########################################

# 常用命令别名
alias crash="sudo crash"
alias top=btop
alias v=nvim
alias vi=nvim
alias vim=nvim
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
    export WSL_ROUTER_IP=$(ip route | grep default | awk '{print $3}')
    # Clash代理配置
    function clash() {
        powershell.exe Get-Process -Name "'clash-verge'" &>/dev/null
        if [ $? -eq 0 ]; then
            export https_proxy="http://$WSL_ROUTER_IP:7890"
            export http_proxy="http://$WSL_ROUTER_IP:7890"
        else
            export https_proxy=""
            export http_proxy=""
        fi
    }

    function v2ray() {
        powershell.exe Get-Process -Name "'V2rayN'" &>/dev/null
        if [ $? -eq 0 ]; then
            export https_proxy="http://$WSL_ROUTER_IP:10809"
            export http_proxy="http://$WSL_ROUTER_IP:10809"
        else
            export https_proxy=""
            export http_proxy=""
        fi
    }

    # WSL特定别名
    alias poweroff="powershell.exe Stop-Computer"
    alias reboot="powershell.exe Restart-Computer"
    alias cleardns="powershell.exe clear-DnsClientCache"
    alias code="/mnt/d/软件/VSCode/bin/code"

    # Windows路径映射
    export WIN_CONFIG="/mnt/d/sharezhou/Documents/git"
    export Soft="/mnt/d/软件"
    export Downloads="/mnt/d/sharezhou/Downloads"
    export Onedrive="/mnt/d/onedrive" 
    export Documents="/mnt/d/sharezhou/Documents"
    export C="/mnt/c"
    export D="/mnt/d"
    export EDITOR="nvim"

    # 启动时检查clash
    # v2ray
    clash

   export GIT_SSH=/mnt/c/Windows/System32/OpenSSH/ssh.exe
fi

# 检测是否为 WSL，如果不是则设置环境变量
if ! is_wsl; then
    export RIME_LS_SYNC_DIR="$HOME/rclone/rime_ls"
fi

###########################################
# 其他配置
###########################################

export CRASHDIR="/etc/ShellCrash"

# Zsh vi模式配置
ZVM_READKEY_ENGINE=$ZVM_READKEY

source ~/encrypt.sh
source "$HOME/.rye/env"
alias open="wslview"
export EDITOR="nvim"

# yazi Warp shell
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
