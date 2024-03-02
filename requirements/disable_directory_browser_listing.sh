#!/bin/bash


while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

if [[ -f "$filename" ]]; then

    cp "$filename" "$filename.bak"


    existing_lines=$(sed -n '/<Directory>/,/<\/Directory>/p' "$filename")

    if [ -n "$existing_lines" ]; then

        new_lines="<Directory> \n Options -Indexes \n </Directory>"
        if [ "$existing_lines" != "$new_lines" ]; then
            echo "The following lines will be replaced:"
            echo "$existing_lines"
            echo -e "\nWith the following directives:"
            echo -e "$new_lines"
        fi
    fi

    read -p "Do you want to proceed with the changes? (y/n): " choice

    if [ "$choice" == "y" ]; then
        existing_directives=$(echo "$existing_lines" | grep -v 'Options -Indexes')

        if [ "$existing_directives" != "Options -Indexes" ]; then
            sed -i -e '/<Directory>/,/<\/Directory>/d' "$filename"
            if [ -n "$existing_directives" ]; then
                printf "<Directory> \n $existing_directives \n Options -Indexes \n </Directory>\n" >>"$filename"
            else
                printf "<Directory> \n Options -Indexes \n </Directory>\n" >>"$filename"
            fi

            echo "Changes have been made to the file. You can revert to the original state using: cp $filename.bak $filename"

            echo "$(date): Modified $filename to disable directory listing." >>disable_directory_listing.log
        else
            echo "No changes have been made to the file."
        fi

    else
        echo "No changes have been made to the file."
    fi

else
    echo "No file exists with this name."
fi

