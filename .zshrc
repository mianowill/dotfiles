# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"
DEFAULT_USER="mia"
plugins=(brew git zsh-completions jq)

zstyle ':omz:update' mode auto # update automatically without asking
HIST_STAMPS="yyyy-mm-dd"

source $ZSH/oh-my-zsh.sh

# zsh-completions
autoload -U compinit && compinit

export PATH="$PATH:/Users/mia/.local/bin"
alias python="python3"
alias lls="eza --icons --group-directories-first"
alias rg="rg --smart-case"
alias gmake="gmake -j8 -Orecurse -s"
alias vim=nvim
alias git-exclude="git update-index --assume-unchanged"
alias git-include="git update-index --no-assume-unchanged"
alias pilot="gh copilot suggest -t shell"

# homebrew under rosetta
alias ibrew="arch -x86_64 /usr/local/bin/brew"

export FZF_DEFAULT_COMMAND='fd --type f'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# add esp idf version to prompt
prompt_context() {
	if [ -n "$ESP_IDF_VERSION" ]; then
		prompt_segment black green "IDF $ESP_IDF_VERSION"
	fi
}

askgpt() {
	cols=$(tput cols)
	/opt/ask_gpt.py "$@" | glow -w $((cols - 2))
}

eval $(thefuck --alias)                    # fuck
eval "$(zoxide init zsh)"                  # z
eval "$(register-python-argcomplete pipx)" # pipx
compctl -K _gh gh                          # gh zsh autocompletions

# fortune
shufwords() {
	echo $(shuf -e $(echo "$@"))
}

shufcow() {
	shufwords "$@" | cowsay -f $(ls /opt/homebrew/share/cowsay/cows | shuf -n 1)
}

if [ -n "$SOURCE_IDF" ]; then
	idf-setup
elif [ -x "$(command -v fortune)" ] && [ -x "$(command -v cowsay)" ]; then
	# select a random cow (requires shuf from coreutils)
	export COW=$(ls /opt/homebrew/share/cowsay/cows | shuf -n 1)
	cowsay -f $COW $(fortune)
fi

function aladark() {
  sed 's/light.toml/dark.toml/' ~/.config/alacritty/alacritty.toml > /tmp/alacritty.toml
  mv /tmp/alacritty.toml ~/.config/alacritty/alacritty.toml
}

function alalight() {
  sed 's/dark.toml/light.toml/' ~/.config/alacritty/alacritty.toml > /tmp/alacritty.toml
  mv /tmp/alacritty.toml ~/.config/alacritty/alacritty.toml
}
