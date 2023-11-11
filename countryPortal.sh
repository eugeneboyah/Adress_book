#!/bin/bash

echo "Hello, and welcome to our Country Information Portal"

declare -A search_history

while true; do
    read -p "Enter a country name or the first letter of a country (or 'exit' to quit): " user_input

    if [ "$user_input" == "exit" ]; then
        echo "Goodbye! Have a nice day."
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
                printf "%s\n" "${matching_countries[@]}" | column
            fi
        elif [[ "$user_input" == [A-Za-z] ]]; then
            # User entered a single letter, to list countries starting with that letter
            matching_countries=($(grep -i "^$user_input" countries.csv | cut -d',' -f1))

            if [ "${#matching_countries[@]}" -eq 0 ]; then
                echo "No countries start with '$user_input'."
            else
                echo "Countries starting with '$user_input':"
                printf "%s\n" "${matching_countries[@]}" | column
            fi
        else
            # User entered a full country name, search for the country
            country_info=$(grep -i "^$user_input," countries.csv)

            if [ -n "$country_info" ]; then
                echo "Information for $user_input:"

                PS3="Select an option to know more about $user_input: "
                options=("Capital City" "Currency" "Official Language" "Head of Government" "Exit")

                select option in "${options[@]}"; do
                    case $REPLY in
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
                            echo "Invalid option. Please select a valid option."
                            ;;
                    esac
                done

                # Add the search term to the search history
                search_history["$user_input"]=$(date +"%Y-%m-%d %H:%M:%S")
                echo "Search for $user_input added to the search history."

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
echo "-------------------------------------------"
printf "%-15s | %-20s\n" "Search Term" "Timestamp"
echo "-------------------------------------------"

for key in "${!search_history[@]}"; do
    printf "%-15s | %-20s\n" "$key" "${search_history[$key]}"
done

echo "-------------------------------------------"
