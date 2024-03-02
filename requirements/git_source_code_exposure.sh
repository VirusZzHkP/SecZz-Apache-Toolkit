#!/bin/bash

while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

declare -a git_checks=('<DirectoryMatch "^/.*/\.git/">' 'Order deny,allow' 'Deny from all' '</DirectoryMatch>')

if [[ -f "$filename" ]]; then

    cp "$filename" "$filename.bak"

    for ((i=0; i<${#git_checks[@]}; i++)); do
        if grep -q "${git_checks[i]}" "$filename"; then
            echo "Passed check ${i}"
        else
            echo "Check ${i} failed..."
            read -p "Do you want to add the required directive to the file? (y/n): " choice

            if [ "$choice" == "y" ]; then

                read -p "Enter Git-related directive value (default: ${git_checks[i]}): " git_directive_value
                git_directive_value=${git_directive_value:-${git_checks[i]}}
                printf "\n%s\n" "$git_directive_value" >>"$filename"
                echo "Git-related directive added."
            else
                echo "No changes have been made to the file."
            fi
        fi
    done
    echo "$(date): Git-related checks for $filename" >>"git_security.log"

else
    echo "No file exists with this name."
fi

