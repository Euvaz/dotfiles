if [ -L ~/.guix-profile/ ]; then
    GUIX_PROFILE="${HOME}/.guix-profile"
    . "${GUIX_PROFILE}/etc/profile"
fi

if [ -z "$GUIX_ENVIRONMENT" ]; then
    export GUIX_LOCPATH="${HOME}/.guix-profile/lib/locale"
fi
