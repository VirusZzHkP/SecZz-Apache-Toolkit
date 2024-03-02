#!/bin/bash

while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

if [[ -f "$filename" ]]; then

    cp "$filename" "$filename.bak"

    server_tokens_present=$(grep -q "ServerTokens Prod" "$filename" && echo "true" || echo "false")
    server_signature_present=$(grep -q "ServerSignature Off" "$filename" && echo "true" || echo "false")

    if [ "$server_tokens_present" == "true" ] && [ "$server_signature_present" == "true" ]; then
        echo "Server banner test passed."
    else
        echo "Server banner test failed."

        read -p "Do you want to add the required directives to the file to remove the server banner? (y/n): " choice

        if [ "$choice" == "y" ]; then

            if [ "$server_tokens_present" == "false" ]; then
                read -p "Enter ServerTokens directive value (default: Prod): " server_tokens_value
                server_tokens_value=${server_tokens_value:-Prod}
                echo "ServerTokens $server_tokens_value" >>"$filename"
            fi
            
            if [ "$server_signature_present" == "false" ]; then
                read -p "Enter ServerSignature directive value (default: Off): " server_signature_value
                server_signature_value=${server_signature_value:-Off}
                echo "ServerSignature $server_signature_value" >>"$filename"
            fi

            echo "Server banner modified."
        else
            echo "No changes have been made to the file."
        fi
    fi

    echo "$(date): Server banner check for $filename" >>"server_banner.log"

else
    echo "No file exists with this name."
fi

