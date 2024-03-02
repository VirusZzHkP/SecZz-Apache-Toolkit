#!/bin/bash

while [ -z "$sslfile" ]; do
    echo "Please enter a valid file name:"
    read -r sslfile
done

if [[ -f "$sslfile" ]]; then
    cp "$sslfile" "$sslfile.bak"

    changes_made=false

    if grep -q "SSLCipherSuite HIGH:!MEDIUM:!aNULL:!MD5:!RC4" "$sslfile"; then
        echo "Cipher test 1 passed, using only higher encryption algorithms."
    else
        echo "Cipher test 1 failed, modifying SSLCipherSuite directive in httpd-ssl.conf."
        read -p "Do you want to add the required directive for Cipher test 1? (y/n): " choice

        if [ "$choice" == "y" ]; then
            echo "SSLCipherSuite HIGH:!MEDIUM:!aNULL:!MD5:!RC4" >>"$sslfile"
            echo "Cipher test 1 directive added."
            changes_made=true
        else
            echo "No changes have been made for Cipher test 1."
        fi
    fi
    if grep -q "SSLProtocol –ALL +TLSv1.2" "$sslfile"; then
        echo "Cipher test 2 passed, using TLS 1.2 and newer protocols."
    else
        echo "Cipher test 2 failed, modifying SSLProtocol directive in httpd-ssl.conf to accept only TLS 1.2 and newer protocols."
        read -p "Do you want to add the required directive for Cipher test 2? (y/n): " choice

        if [ "$choice" == "y" ]; then
            echo "SSLProtocol -ALL +TLSv1.2" >>"$sslfile"
            echo "Cipher test 2 directive added."
            changes_made=true
        else
            echo "No changes have been made for Cipher test 2."
        fi
    fi

    if grep -q "SSLProtocol -ALL +TLSv1.3" "$sslfile"; then
        echo "Using TLS 1.3."
    else
        echo "Modifying SSLProtocol directive to include TLS 1.3."
        read -p "Do you want to add the required directive for TLS 1.3? (y/n): " choice

        if [ "$choice" == "y" ]; then
            echo "SSLProtocol -ALL +TLSv1.3" >>"$sslfile"
            echo "TLS 1.3 directive added."
            changes_made=true
        else
            echo "No changes have been made for TLS 1.3."
        fi
    fi
    echo "$(date): Cipher tests check for $sslfile" >>"cipher_tests.log"

    if [ "$changes_made" == true ]; then
        echo "Changes have been made to the file. You can revert to the original state using: cp $sslfile.bak $sslfile"
    fi

else
    echo "Invalid file name or file does not exist."
fi

