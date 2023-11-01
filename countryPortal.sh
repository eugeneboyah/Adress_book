#!/bin/bash

# First step! Prompt User for a little information
echo "Please enter your name:"
read userName
echo "Hello, $userName, and welcome to our Portal"

while true; do
    # Read user input
    read -p "Enter a country name that you want to search (or 'exit' to quit): " country_name

    if [ "$country_name" == "exit" ]; then
        echo "Goodbye, $userName! Have a nice day."
        break
    elif [ "$country_name" == "continue" ]; then
        continue
    fi

    # Search for the country in the data file
    country_info=$(grep -i "^$country_name," countries.csv)

    if [ -n "$country_info" ]; then
        # Display the information in a vertical format
        echo "Information for $userName $country_name:"
        IFS=',' read -ra fields <<< "$country_info"
        echo "Country: ${fields[0]}"
        echo "Capital: ${fields[1]}"
        echo "Current President: ${fields[2]}"
        echo "Language: ${fields[3]}"
        echo "Currency: ${fields[4]}"
    else
        # Country not found or misspelled
        echo "Country not found or misspelled. Please check the spelling and try again."
    fi
done
