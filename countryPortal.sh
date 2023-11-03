#!/bin/bash

echo "Please enter your name:"
read userName
echo "Hello, $userName, and welcome to our Country Information Portal"

while true; do
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
        echo "Information for $country_name:"
        
        # Provide options for specific information
        echo "Select an option to know more about this country"
        echo "1. Capital City"
        echo "2. Language"
        echo "3. Currency"
        read -p "Enter the option number (1/2/3): " option

        case $option in
            1)
                echo "Capital City: $(echo $country_info | cut -d',' -f2)"
                ;;
            2)
                echo "Language: $(echo $country_info | cut -d',' -f3)"
                ;;
            3)
                echo "Currency: $(echo $country_info | cut -d',' -f4)"
                ;;
            *)
                echo "Invalid option. Please select 1, 2, or 3."
                ;;
        esac
    else
        echo "Country not found or misspelled. Please check the spelling and try again."
    fi
done
