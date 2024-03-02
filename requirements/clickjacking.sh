#!/bin/bash

while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

log_file="clickjacking.log"  

if [[ -f "$filename" ]]; then

    cp "$filename" "$filename.bak"

    if grep -q "Header always append X-Frame-Options SAMEORIGIN" "$filename"; then
        echo "Clickjacking test Passed."
    else
        echo "Clickjacking test Failed."
        read -p "Do you want to add the required directive to the file? (y/n): " choice

        if [ "$choice" == "y" ]; then

            read -p "Enter X-Frame-Options header value (default: SAMEORIGIN): " x_frame_options
            x_frame_options=${x_frame_options:-SAMEORIGIN}

            echo "Adding required directives to file..."
            printf "\nHeader always append X-Frame-Options $x_frame_options\n" >>"$filename"
            echo "Changes have been made to the file. You can revert to the original state using: cp $filename.bak $filename"
        else
            echo "No changes have been made to the file."
        fi
    fi


    echo "$(date): Clickjacking check for $filename" >>"$log_file"

else
    echo "No file exists with this name."
fi

