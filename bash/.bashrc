export SHELL

if [[ $- != *i* ]]
then
    [[ -n "${SSH_CLIENT}" ]] && source /etc/profile
    return 0
fi

if [[ -e /etc/bashrc ]]; then
    source /etc/bashrc
fi

if [[ -n "${GUIX_ENVIRONMENT}" ]]
then
    PS1="\[\e[38;5;4m\]\u@\h \[\e[38;5;13m\]\w \[\e[38;5;5m\][env] \[\e[38;5;14m\]\$ \[\e[m\]"
else
    PS1="\[\e[38;5;4m\]\u@\h \[\e[38;5;13m\]\w \[\e[38;5;14m\]\$ \[\e[m\]"
fi
