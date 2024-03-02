#!/bin/bash

while [ -z "$filename" ]; do
    echo "Please enter a valid file name:"
    read -r filename
done

if [[ -f "$filename" ]]; then

    cp "$filename" "$filename.bak"

    if grep -q "TraceEnable off" "$filename"; then
        echo "Tracing HTTP requests already disabled."
    else
        echo "Server banner test failed..."
        read -p "Do you want to add the required directive to the file to disable tracing HTTP requests? (y/n): " choice

        if [ "$choice" == "y" ]; then

            read -p "Enter TraceEnable directive value (default: off): " trace_enable_value
            trace_enable_value=${trace_enable_value:-off}

            echo "Adding required directives to file to disable tracing HTTP requests..."
            echo "TraceEnable $trace_enable_value" >>"$filename"
            echo "Tracing HTTP requests disabled."
        else
            echo "No changes have been made to the file."
        fi
    fi

    echo "$(date): Tracing HTTP requests check for $filename" >>"trace_disable.log"

else
    echo "No file exists with this name."
fi

