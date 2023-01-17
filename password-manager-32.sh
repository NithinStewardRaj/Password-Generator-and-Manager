#!/bin/bash

# Generate a strong password
password=$(openssl rand -base64 32)
echo "$password"

# Ask user if they want to use the generated password
read -p "Do you want to use the generated password? (y/n) " use_password
echo ""

if [ "$use_password" = "y" ]; then

    # Ask user if they want to copy the password to clipboard
    read -p "Do you want to copy the password to clipboard? (y/n) " copy_password

    if [ "$copy_password" = "y" ]; then

        # Check if xclip is installed
        if command -v xclip > /dev/null; then
            echo "$password" | xclip -selection clipboard
            echo "Password copied to clipboard."
        else
            echo "xclip is not installed. Installing xclip..."
            sudo apt-get install xclip
            echo "$password" | xclip -selection clipboard
            echo "Password copied to clipboard."
        fi

    fi

    # Ask user for URL, username, and website
    read -p "Enter URL: " url
    read -p "Enter username (optional): " username
    read -p "Enter website: " website

    # store all detail in same file
    echo "URL: $url" >> Password_Manager.txt
    echo "Username: $username" >> Password_Manager.txt
    echo "Website: $website" >> Password_Manager.txt
    echo "Password: $password" >> Password_Manager.txt

    # Ask user if they want to encrypt the file
    read -p "Do you want to encrypt the file? ${blue}(y/n) " encrypt_file

    if [ "$encrypt_file" = "y" ]; then

        # Ask user for a custom encryption phrase
        read -p "Enter a custom encryption phrase: " phrase

        # Encrypt the file with gpg
        gpg -c -a --passphrase "$phrase" Password_Manager.txt

        echo "File encrypted. To decrypt the file, run the following command: 'gpg -d Password_Manager.txt.gpg'"
    fi

fi

