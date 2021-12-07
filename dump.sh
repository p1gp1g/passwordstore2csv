#!/usr/bin/env bash

IFS=$'\n'

prefix=$(readlink -f ${PASSWORD_STORE_DIR-~/.password-store})
password_files=( $( fd -L ".gpg\$" "$prefix" ) )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

echo '"Group","Title","Username","Password","URL","Notes"'
for password in ${password_files[@]}; do
    echo -n "\"$(dirname ${password})\","
    echo -n "\"$(basename ${password})\","
    clear=( $(pass ${password} | sed -e 's/"/""/g') )
    pass="${clear[0]}"
    user=""
    url=""
    notes=""
    for line in ${clear[@]:1}; do
        case $line in
            url:\ *) url="${line#"url: "}";;
            login:\ *) login="${line#"login: "}";;
            *) notes+="${line#"comments: "}"$'\n';;
        esac
    done
    echo -n "\"$login\","
    echo -n "\"$pass\","
    echo -n "\"$url\","
    echo -n "\"$notes\""
    echo
done
