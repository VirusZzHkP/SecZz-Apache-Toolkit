#!/bin/bash

while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

if [[ -f "$filename" ]]; then
    cp "$filename" "$filename.bak"

    changes_made=false

    if grep -q "Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure" "$filename"; then
        echo "HttpOnly Cookie and Secure Flag Passed."
    else
        echo "HttpOnly Cookie and Secure Flag Failed."
        read -p "Do you want to add the required directive? (y/n): " choice

        if [ "$choice" == "y" ]; then
            echo "Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure" >>"$filename"
            echo "Directive added."
            changes_made=true
        else
            echo "No changes have been made."
        fi
    fi

    echo "$(date): HttpOnly Cookie and Secure Flag check for $filename" >>"http_cookie_flags.log"

    if [ "$changes_made" == true ]; then
        echo "Changes have been made to the file. You can revert to the original state using: cp $filename.bak $filename"
    fi

else
    echo "Invalid file name or file does not exist."
fi

