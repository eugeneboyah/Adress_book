declare -A search_history

echo "Please enter your name:"
echo
read userName
echo "Hello, $userName, and welcome to our Country Information Portal"
echo 

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
                    capital_city=$(echo $country_info | cut -d',' -f2)
                    echo "Capital City: $capital_city"
                    search_history["$country_name, Capital City"]=$capital_city
                    echo
                    ;;
                    
                2)
                    currency=$(echo $country_info | cut -d',' -f3)
                    echo "Currency: $currency"
                    search_history["$country_name, Currency"]=$currency
                    echo
                    ;;
                    
                3)
                    language=$(echo $country_info | cut -d',' -f4)
                    echo "Official Language: $language"
                    search_history["$country_name, Official Language"]=$language
                    echo
                    ;;
                    
                4)
                    head_of_govt=$(echo $country_info | cut -d',' -f5)
                    echo "Head of Government: $head_of_govt"
                    search_history["$country_name, Head of Government"]=$head_of_govt
                    echo
                    ;;
                    
                5)
                    echo "Returning to the main menu."
                    break
                    echo
                    ;;
                    
                *)
                    echo "Invalid option. Please select 1, 2, 3, 4, or 5."
                    echo
                    ;;
                    
            esac
        done
    else
        echo "Country not found or misspelled. Please check the spelling and try again."
        echo
    fi
done

# Print search history using AWK
echo "Search History:"
echo 
for key in "${!search_history[@]}"; do
    echo "$key: ${search_history[$key]}"
done