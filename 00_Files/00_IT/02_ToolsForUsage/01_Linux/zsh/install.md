***
[TOC]
***

```
1. 下载 git zsh
$ sudo pacman -S git zsh
$ sudo chsh -s /bin/zsh

2. 使用zsh
$ chsh -s /bin/zsh
$ sudo chsh -s /bin/zsh

3. curl方式安装oh-my-zsh(zsh主题) 
$ su
# cd ~
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

4. 选择主题
# vim ~/.zshrc
ZSH_THEME="amuse"

5. 改动主题,使root是#命令提示符
if [ $UID -eq 0 ]; then
PROMPT='%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info) ⌚%{$fg_bold[red]%}%*%{$reset_color%}
%{$fg_bold[green]%}# %{$reset_color%}'
else
PROMPT='%{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info) ⌚%{$fg_bold[red]%}%*%{$reset_color%}
%{$fg_bold[green]%}$ %{$reset_color%}'
fi

6. 其它用户
# cp -f .zshrc /home/<username>

7. 关闭zsh生效
```

