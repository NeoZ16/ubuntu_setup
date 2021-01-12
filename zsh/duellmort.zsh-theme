# user, host, full path, and time/date
# on two lines for easier vgrepping
# entry in a nice long thread on the Arch Linux forums: https://bbs.archlinux.org/viewtopic.php?pid=521888#p521888
# echo "%{$FG[012]%}%n%{$reset_color%}"

#prepare git prompt exentsion
autoload -Uz vcs_info
autoload -U add-zsh-hook
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' get-revision false #not needed for git
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' check-for-staged-changes '%b'
zstyle ':vcs_info:*+set-message:*' hooks vcsinfo
zstyle ':vcs_info:*+no-vcs:*'      hooks vcsinfo

function +vi-vcsinfo() {
    hook_com[vcs]=${hook_com[vcs]/#%git-svn/git}
    for KEY in staged unstaged; do
        KEY_NAME="${KEY/-/_}"
        KEY_NAME="${KEY_NAME:u}"
        export "VCS_${KEY_NAME}=${hook_com[$KEY]}"
    done
}

precmd_vcs_info() { 
  # As always first run the system so everything is setup correctly.
  vcs_info
  # And then just set PS1, RPS1 and whatever you want to. This $PS1
  # is (as with the other examples above too) just an example of a very
  # basic single-line prompt. See "man zshmisc" for details on how to
  # make this less readable. :-)
  #if [[ -z ${vcs_info_msg_0_} ]]; then
  # Oh hey, nothing from vcs_info, so we got more space.
  # Let's print a longer part of $PWD...
  #PS1="%5~%# "
  #else
  # vcs_info found something, that needs space. So a shorter $PWD
  # makes sense.
  #PS1="%3~${vcs_info_msg_0_}%# "
  #fi
}
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

user(){
  echo "%(0?.%{\e[32m%}%n.%{\e[31m%}%n)"
}

user_and_machine() {
  echo "$(user)%{\e[1;34m%}@%{\e[0;36m%}%m%{\e[0m%}"
}

priviliges(){
  echo "%(!.#.$)"
}

current_path(){
  echo "%~"
}

git_info(){
  COLOR="%{\e[32m%}"
  [[ ${VCS_STAGED} == S ]] && COLOR="%{\e[93m%}"
  [[ ${VCS_UNSTAGED} == U ]] && COLOR="%{\e[31m%}"
  echo "${COLOR}${vcs_info_msg_0_}%{\e[0m%}"
}

blue_output(){
  echo "%{\e[0;34m%}$1%{\e[0m%}"
}

purple_output(){
  echo "%{\e[0;35m%}$1%{\e[0m%}"
}



PROMPT=$'$(user_and_machine) $(blue_output "%B\[%b")%~$(blue_output "%B\]%b") $(purple_output $(priviliges)) '
RPROMPT='$(git_info)'
PS2=$'%{\e[0;34m%}%B>%{\e[0m%}%b '

#PROMPT=$'$(blue_output "%B┌─\(%b")$(user_and_machine)$(blue_output "%B\)%b") - $(blue_output "%B\[%b")%~$(blue_output "%B\]%b")
#$(blue_output └─)$(blue_output "%B\[%b")$(purple_output $)$(blue_output "%B\]%b")'
#RPROMPT='$(purple_output "[")%D$(purple_output "]")'
#RPROMPT='%(?.."Last command failed")$(purple_output "[")%D$(purple_output "]")'

