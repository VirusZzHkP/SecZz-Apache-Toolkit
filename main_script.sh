#!/bin/bash

requirements_directory="requirements"
scripts=("git_source_code_exposure.sh" "remove_server_banner.sh" "disable_directory_browser_listing.sh" \
         "disable_trace_http_request.sh" "http_only_cookie_and_secure_flag.sh" "clickjacking.sh" \
         "xss_protection.sh" "http_one_0.sh" "strong_ssl_cipher.sh" "csp.sh")
completed=()


GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'

print_colored() {
    echo -e "${1}${2}"
}

print_colored "$CYAN" "Welcome to the ViruszzWarning Security Tool!"

print_colored "$YELLOW" "Please select the location and name of your 'httpd.conf' file."
filename=$(zenity --file-selection --title="Select httpd.conf file")
print_colored "$GREEN" "You've chosen '$filename' as your 'httpd.conf' file."

print_colored "$YELLOW" "Next, please select the location and name of your SSL configuration file."
sslfile=$(zenity --file-selection --title="Select SSL configuration file")
print_colored "$GREEN" "You've chosen '$sslfile' as your SSL configuration file."

while true; do
    if [ -f "$filename" ] || [ -f "$sslfile" ]; then
        export filename="$filename"
        export sslfile="$sslfile"


        print_colored "$CYAN" "\n============================= MENU ============================="
        for i in "${!scripts[@]}"; do
            if [[ "${completed[*]}" =~ "$i" ]]; then
                print_colored "$GREEN" "$((i+1)). [✓] ${scripts[i]}"
            else
                print_colored "$CYAN" "$((i+1)). ${scripts[i]}"
            fi
        done
        print_colored "$CYAN" "99. ${YELLOW}Exit"
        print_colored "$CYAN" "100. ${CYAN}Give Feedback"
        print_colored "$CYAN" "================================================================="

        read -p "Enter the script number (1-${#scripts[@]}), '99' to exit, or '100' to give feedback: " choice

        if [ "$choice" -eq '99' ]; then
            print_colored "$GREEN" "\nThanks for using my tool! Best wishes from ViruszzWarning."
            exit 0
        elif [ "$choice" -eq '100' ]; then
            print_colored "$YELLOW" "\nSorry for the inconvenience you faced."
            print_colored "$YELLOW" "\nContact Information:"
            print_colored "$CYAN" "================================================================="
            print_colored "$YELLOW" "Discord Server:[JustHack IT] https://discord.gg/sD5qqDBgfT"
            print_colored "$YELLOW" "Instagram:[@viruszzwarning] https://instagram.com/viruszzwarning"
            print_colored "$YELLOW" "Twitter:[@hrisikesh_pal] https://twitter.com/hrisikesh_pal"
            print_colored "$CYAN" "================================================================="

            exit 0
        elif [ "$choice" -ge 1 ] && [ "$choice" -le "${#scripts[@]}" ]; then
            script_to_run="${scripts[choice-1]}"
            
            if [ -f "$requirements_directory/$script_to_run" ]; then

                print_colored "$YELLOW" "\nYou've selected to run '${scripts[choice-1]}' script."
                print_colored "$CYAN" "Files chosen:\n  httpd.conf: $filename\n  SSL Config: $sslfile"
                read -p "Press Enter to continue..."
                

                bash "$requirements_directory/$script_to_run"
                completed+=("$((choice-1))")  
                print_colored "$GREEN" "\nProcess completed."
                read -p "Do you want to check for other options? (y/n): " continue_option
                if [ "$continue_option" != "y" ]; then
                    print_colored "$GREEN" "\nThanks for using my tool! Best wishes from ViruszzWarning."
                    exit 0
                fi
            else
                print_colored "$YELLOW" "File '$script_to_run' not found in the '$requirements_directory' directory."
            fi
        else
            print_colored "$YELLOW" "Invalid choice. Please enter a number between 1 and ${#scripts[@]}, '99' to exit, or '100' to give feedback."
        fi
    else
        print_colored "$YELLOW" "\nFile not found. Please run the script again with valid filenames."
        exit 1
    fi
done

