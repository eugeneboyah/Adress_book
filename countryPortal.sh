#!/bin/bash

# Welcome message
echo "Welcome to the Country Information Program!"

# Read user input
read -p "Enter a country name to get information: " country_name

# Search for the country in the data file
country_info=$(grep -i "^$country_name," countries.csv)

# Check if the country was found
if [ -n "$country_info" ]; then
     # Display the information in a vertical format
    echo "Information for $country_name:"
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