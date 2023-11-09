#!/bin/bash


echo "Hello, and welcome to our Country Information Portal"

declare -A search_history

while true; do
    read -p "Enter a country name or the first letter of a country (or 'exit' to quit): " user_input

    if [ "$user_input" == "exit" ]; then
        echo "Goodbye, $userName! Have a nice day."
        break
    elif [ "$user_input" == "continue" ]; then
        continue
    elif [ -n "$user_input" ]; then
        if [[ "$user_input" == "*" ]]; then
            # User entered a wildcard, so list all countries
            matching_countries=($(cut -d',' -f1 countries.csv))

            if [ "${#matching_countries[@]}" -eq 0 ]; then
                echo "No countries found."
            else
                echo "All countries:"
                for country_name in "${matching_countries[@]}"; do
                    echo "- $country_name"
                done
            fi
        elif [[ "$user_input" == [A-Za-z] ]]; then
            # User Can entered a single letter, to list countries starting with that letter
            matching_countries=($(grep -i "^$user_input" countries.csv | cut -d',' -f1))

            if [ "${#matching_countries[@]}" -eq 0 ]; then
                echo "No countries start with '$user_input'."
            else
                echo "Countries starting with '$user_input':"
                for country_name in "${matching_countries[@]}"; do
                    echo "- $country_name"
                done
            fi
        else
            # User entered a full country name, search for the country
            country_info=$(grep -i "^$user_input," countries.csv)

            if [ -n "$country_info" ]; then
                echo "Information for $user_input:"

                echo "Select an option to know more about $user_input"
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
        fi
    else
        echo "Please enter a valid input."
    fi
done

# Print search history
echo "Search History:"
echo 
for key in "${!search_history[@]}"; do
    echo "$key: ${search_history[$key]}"
done
