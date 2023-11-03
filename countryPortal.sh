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

    country_info=$(grep -i "^$country_name," countries.csv)

    if [ -n "$country_info" ]; then
        echo "Information for $country_name:"

        echo "Select an option to know more about $country_name"
        echo "1. Capital City"
        echo "2. Currency"
        echo "3. Official Language"
        echo "4. Head of Government"
        echo "5. Exit"

        while true; do
            read -p "Enter the option number (1/2/3/4/5): " option

            case $option in
                1)
                    echo "Capital City: $(echo $country_info | cut -d',' -f2)"
                    ;;
                2)
                    echo "Currency: $(echo $country_info | cut -d',' -f3)"
                    ;;
                3)
                    echo "Official Language: $(echo $country_info | cut -d',' -f4)"
                    ;;
                4)
                    echo "Head of Government: $(echo $country_info | cut -d',' -f5)"
                    ;;
                5)
                    echo "Returning to the main menu."
                    break
                    ;;
                *)
                    echo "Invalid option. Please select 1, 2, 3, 4, or 5."
                    ;;
            esac
        done
    else
        echo "Country not found or misspelled. Please check the spelling and try again."
    fi
done
