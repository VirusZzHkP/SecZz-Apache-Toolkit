#!/bin/bash

while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

if [[ -f "$filename" ]]; then
    cp "$filename" "$filename.bak"

    declare -a http_checks=('RewriteEngine On' 'RewriteCond %{THE_REQUEST} !HTTP/1.1$' 'RewriteRule .* - [F]')

    changes_made=false
    for check in "${http_checks[@]}"; do
        if grep -q "$check" "$filename"; then
            echo "$check already exists."
        else
            echo "$check not found..."
            read -p "Do you want to add the required directive? (y/n): " choice

            if [ "$choice" == "y" ]; then
                echo "$check" >>"$filename"
                echo "Directive added: $check"
                changes_made=true
            else
                echo "No changes have been made."
            fi
        fi
    done

    echo "$(date): HTTP security checks for $filename" >>"http_security_checks.log"

    if [ "$changes_made" == true ]; then
        echo "Changes have been made to the file. You can revert to the original state using: cp $filename.bak $filename"
    fi
else
    echo "Invalid file name or file does not exist."
fi

