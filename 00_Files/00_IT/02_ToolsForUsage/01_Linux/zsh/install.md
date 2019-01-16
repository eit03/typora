***
[TOC]
***

```
1. 下载 git zsh
$ sudo pacman -S git zsh
$ sudo chsh -s /bin/zsh

2. curl方式安装oh-my-zsh(zsh主题) 
$ su
# cd ~
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

3. 选择主题
# vim ~/.zshrc
ZSH_THEME="amuse"

4. 改动主题,使root是#命令提示符
if [ $UID -eq 0 ]; then
PROMPT='
%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info) ⌚%{$fg_bold[red]%}%*%{$reset_color%}
%{$fg_bold[green]%}%# %{$reset_color%}'
else
PROMPT='
%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info) ⌚%{$fg_bold[red]%}%*%{$reset_color%}
%{$fg_bold[green]%}%$ %{$reset_color%}'
fi

4. 其它用户
# cp -f .zshrc /home/<username>

5. 关闭zsh生效
```

