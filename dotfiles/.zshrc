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

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

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
# export FZF_GIT_KEY='^x'
autoload -Uz compinit; compinit
source ~/.config/fzftab/fzf-tab.plugin.zsh
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

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
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
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
# }}} End configuration added by Zim install

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh/"

# ZSH_THEME="ys"
# plugins=(git zsh-autosuggestions extract)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# bindkey '^v' edit-command-line
bindkey -v
# bindkey -M vicmd "u" vi-insert
# bindkey -M vicmd "U" vi-insert-bol
# bindkey -M vicmd "h" vi-backward-char
# bindkey -M vicmd "l" vi-forward-char
bindkey -M vicmd "l" vi-forward-char
# bindkey -M vicmd "I" vi-beginning-of-line
#
# bindkey -M vicmd "A" end-of-line-insert
# bindkey -M vicmd "I" begin-of-line-insert

bindkey -M vicmd "j" down-line-or-history
bindkey -M vicmd "k" up-line-or-history
bindkey -M vicmd "u" undo
# bindkey -M vicmd "-" vi-rev-repeat-search
# bindkey -M vicmd "=" vi-repeat-search
bindkey -M vicmd "e" vi-forward-word-end
bindkey -M vicmd "L" vi-forward-word-end
bindkey -M vicmd "H" vi-backward-word-end
# bindkey -M vicmd "B" vi-backward-word-end

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
	echo -ne '\e[5 q'
}

_fix_cursor() {
	echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

KEYTIMEOUT=1

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# 
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
setopt no_nomatch
alias k="tsh kubectl"
alias gc="goctl"
alias gt="git status"
alias gt="git status"
alias ga="git add -A"
alias gs="git switch"
alias vim="nvim"
alias yz="yazi"
alias neovim="nvim"
# alias cd="j"
# alias z="j"
# alias k="j"
alias ls="lsd"
alias l="ls -al"
alias lt="ls --tree"
alias lt2="ls --tree --depth=2"
alias gt="git status"
alias op="python3 ~/zest/zest-all-in-one/publish.py /Users/mi_kaixuan.wang/k/localization op"
alias pip="pip3"
alias c="clear"
# alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias dk="docker"
alias dc="docker-compose"
alias dp='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias de="docker exec -it"
alias di="docker inspect"
alias kc="kubectl"
alias ks="kubectl -n kube-system"
alias proxy="export all_proxy=http://127.0.0.1:1087"
alias unproxy="unset all_proxy"
alias jd="$HOME/GolandProjects/doraemon.worktree"
alias jp="$HOME/GolandProjects/g123-talent.worktree"
# 设置 Whistle 代理
alias w2proxy="export http_proxy=http://127.0.0.1:8899 https_proxy=http://127.0.0.1:8899"
# 取消代理
alias w2unproxy="unset http_proxy https_proxy"
alias gl="Lazygit"
alias ld="lazydocker"
alias z="fzf"
alias Z="ji"
alias f="python3 /Users/apple/Library/Mobile\ Documents/iCloud~com~coderforart~iOS~MWeb/Documents/mweb_documents_library/vim/learn-python/tools/websp/f.py"
alias p="python3 /Users/apple/Library/Mobile\ Documents/iCloud~com~coderforart~iOS~MWeb/Documents/mweb_documents_library/vim/learn-python/tools/aioweb/aioweb.py"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export NODE_PATH="/usr/local/lib/node_modules"
# export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export WORKON_HOME=$HOME/.venv
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# source /usr/local/bin/virtualenvwrapper.sh
# source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH=$PATH:${GOROOT}/bin
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export GOPROXY=goproxy.mihoyo.com,direct
export GOPROXY=https://goproxy.cn,direct
export FZF_DEFAULT_OPTS='--preview "bat --style=numbers,changes --color=always --line-range :500 {}"'
export BAT_THEME="1337"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH=$GOPATH/bin:$PATH
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
# export ANDROID_HOME=/Users/apple/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.atuin/bin
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"

export PROTOBUF=/usr/local/protobuf 
export PATH=$PROTOBUF/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# flutter
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH="$PATH":"/usr/local/Caskroom/flutter/2.0.3/flutter/.pub-cache/bin"
export PATH="$PATH":"$HOME/.config/bin"

# z.lua
# eval "$(lua ~/z.lua  --init zsh once enhanced)"
# alias zz='z -i'      # 使用交互式选择模式
# alias zf='z -I'      # 使用 fzf 对多个结果进行选择
# export RANGER_ZLUA="/Users/apple/.config/ranger/plugins/z.lua"

# zoxide
eval "$(zoxide init zsh --cmd j)"
# eval "$(navi widget zsh)"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export PATH="/usr/local/opt/mongodb-community@4.4/bin:$PATH"
export PATH="/usr/local/opt/ruby@3.0/bin:$PATH"


export MY_PING_PATH=/Applications/SASE.app/Contents/Services
export PATH=${MY_PING_PATH}:$PATH



[ -s "${HOME}/.g/env" ] && \. "${HOME}/.g/env"  # g shell setup


. "$HOME/.atuin/bin/env"
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' atuin-search

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

[ -s "${HOME}/.g/env" ] && \. "${HOME}/.g/env"  # g shell setup


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client@8.0/bin:$PATH"

source <(fzf --zsh)

fzfp() {
	rm -f /tmp/rg-fzf-{r,f}
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	INITIAL_QUERY="${*:-}"
	fzf --ansi --disabled --query "$INITIAL_QUERY" \
		--bind "start:reload:$RG_PREFIX {q}" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--bind 'ctrl-f:transform:[[ ! $FZF_PROMPT =~ rg ]] &&
		echo "rebind(change)+change-prompt(1. rg> )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" ||
		echo "unbind(change)+change-prompt(2. fzf> )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--prompt '1. rg> ' \
		--delimiter : \
		--header 'CTRL-T: Switch between rg/fzf' \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--preview-window 'right,45%,border-bottom,+{2}+3/3,~3' \
		--layout=reverse \
		--bind 'enter:become(code -g {1}:{2}:{3})'
		# --bind 'enter:become(nvim {1} +{2})'
}

 _fzf_project_widget() {
	# 调用你真正的函数
	fzfp
	# 关键：调用结束后，重绘命令行，防止界面错乱
	zle reset-prompt
}

# 3. 告诉 ZLE，我们上面创建的函数是一个 widget
zle -N _fzf_project_widget

# 4. 现在，将快捷键绑定到我们新创建的 widget 上
bindkey '^f' _fzf_project_widget

# 定义 cdd 命令，实现更灵活的模糊目录跳转
# - 不带参数 (cdd):         从家目录 (~) 开始搜索
# - 带参数 (cdd .):        从当前目录开始搜索
# - 带参数 (cdd /some/path): 从指定路径开始搜索
cc() {
	# 1. 设定搜索路径 (search_path)。
	#    使用 ${1:-~} 语法：如果第一个参数 ($1) 存在，就用它；否则，默认用家目录 (~)。
	local search_path=${1:-~}

	# 2. 使用 fd 在指定的 search_path 中查找目录 (-t d)。
	#    fd 的语法是 `fd [pattern] [path]`，这里的 pattern 是 `.`，表示匹配所有条目。
	#    结果通过管道 | 传递给 fzf。
	local dir
	dir=$(fd --type d . "$search_path" | fzf)

	# 3. 如果选中了目录，就 cd 进去。
	if [[ -n "$dir" ]]; then
		cd "$dir"
	fi
}

function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select

pp() {
	pet search --color "$@" | pbcopy
}

function pet-copy() {
	pet search --query "$LBUFFER" | pbcopy
    zle redisplay
}

zle -N pet-copy
bindkey '^o' pet-copy

source "$HOME/.config/fzf-git.sh"
export PATH="$HOME/.local/bin:$PATH"

# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

function oo() {
	navi --fzf-overrides '--no-exact --layout=reverse'
	zle accept-line
	# zle redisplay
}
zle -N oo
bindkey '^p' oo

function swenv() {
  local env_dir="$HOME/.config/env"
  local shared_file="$env_dir/share"

  # 如果没有提供参数，则列出可用环境
  if [[ -z "$1" ]]; then
    echo "Usage: switch-env <environment>"
    echo "Available environments in ${env_dir}:"
    for f in "$env_dir"/*; do
      if [[ -f "$f" && "$f" != "$shared_file" ]]; then
        local filename=$(basename "$f")
        echo "  - ${filename}"
      fi
    done
    return 1
  fi

  # --- 新增逻辑：加载共享配置文件 ---
  if [[ -f "$shared_file" ]]; then
    source "$shared_file"
    echo "ℹ️ Loaded shared settings from ${shared_file}]."
  fi
  # --- 结束新增逻辑 ---

  local env_file="$env_dir/$1"

  if [[ ! -f "$env_file" ]]; then
    echo "Error: Environment file not found: $env_file"
    return 1
  fi

  # 加载特定环境的配置文件
  source "$env_file"

  echo "✅ Successfully loaded environment from [${env_file}]."
}

# 1. 定义一个函数作为我们的小部件
ji-widget() {
	ji
	zle accept-line
	# zle redisplay
}

# 2. 告诉 ZLE 这个函数是一个新的小部件
zle -N ji-widget

# 3. 将 Ctrl+j 绑定到这个新的小部件上
bindkey '^J' ji-widget

# 1. 定义一个新的小部件
silent-lazygit-widget() {
	# 直接在函数中调用命令，而不是把它放到命令行缓冲区
	lazygit
	# 命令退出后，让 ZLE (Zsh Line Editor) 重新绘制界面，确保提示符干净
	zle redisplay
}

# 2. 告诉 ZLE 这是一个新的小部件
zle -N silent-lazygit-widget

# 3. 绑定快捷键 (仍然推荐使用 Ctrl-g)
bindkey '^g' silent-lazygit-widget

