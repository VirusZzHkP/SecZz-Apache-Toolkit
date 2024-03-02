#!/bin/bash

while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

if [[ -f "$filename" ]]; then

    if grep -q "Content-Security-Policy:" "$filename"; then
        echo "CSP header is already present in $filename"
    else

        cp "$filename" "$filename.bak"

        read -p "Enter the default source for CSP (default-src): " default_src
        read -p "Enter the script source for CSP (script-src): " script_src
        read -p "Enter the style source for CSP (style-src): " style_src
        read -p "Enter the object source for CSP (object-src): " object_src
        read -p "Enter the frame-ancestors for CSP (frame-ancestors): " frame_ancestors

        # Set default values if the user pressed Enter
        default_src=${default_src:-'self'}
        script_src=${script_src:-'self'}
        style_src=${style_src:-'self'}
        object_src=${object_src:-'none'}
        frame_ancestors=${frame_ancestors:-'none'}

        # Restricting Inline Scripts
        inline_script_directive="script-src '$script_src' 'unsafe-inline';"

        # Restricting Remote Scripts
        remote_script_directive="script-src '$script_src';"

        # Restricting Unsafe JavaScript
        unsafe_js_directive="script-src '$script_src';"

        # Restricting Form submissions
        form_submission_directive="form-action 'self';"

        # Restricting Objects
        object_directive="object-src '$object_src';"

        # Strict CSP
        strict_csp_directive="Content-Security-Policy: $inline_script_directive $remote_script_directive $form_submission_directive $object_directive frame-ancestors '$frame_ancestors';"

        # Define the CSP header with user-specified values
        csp_directive="Content-Security-Policy: default-src '$default_src'; $inline_script_directive style-src '$style_src'; $object_directive frame-ancestors '$frame_ancestors';"


        if grep -q "$csp_directive" "$filename"; then
            echo "CSP header is already present in $filename"
        else
            echo "CSP Protection test Failed."
            read -p "Do you want to add the required directive to the file? (y/n): " choice

            if [ "$choice" == "y" ]; then
                echo "Adding required directives to file..."
                printf '\n%s\n' "$csp_directive" >> "$filename"
                echo "Changes have been made to the file. You can revert to the original state using: cp $filename.bak $filename"
            else
                echo "No changes have been made to the file."
            fi
        fi


        echo "$(date): CSP Protection check for $filename" >> csp_protection.log
    fi
else
    echo "No file exists with this name."
fi

