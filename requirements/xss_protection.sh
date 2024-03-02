#!/bin/bash

while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

if [[ -f "$filename" ]]; then

    cp "$filename" "$filename.bak"

    if grep -q 'Header set X-XSS-Protection "1; mode=block"' "$filename"; then
        echo "XSS Protection test Passed."
    else
        echo "XSS Protection test Failed."
        read -p "Do you want to add the required directive to the file? (y/n): " choice

        if [ "$choice" == "y" ]; then
            echo "Adding required directives to file..."
            printf '\nHeader set X-XSS-Protection "1; mode=block"\n' >>"$filename"
            echo "Changes have been made to the file. You can revert to the original state using: cp $filename.bak $filename"
        else
            echo "No changes have been made to the file."
        fi
    fi

    echo "$(date): XSS Protection check for $filename" >>xss_protection.log

else
    echo "No file exists with this name."
fi

