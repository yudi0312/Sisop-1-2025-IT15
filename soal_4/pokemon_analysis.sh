#!/bin/bash 

wget -q "https://drive.usercontent.google.com/u/0/uc?id=1n-2n_ZOTMleqa8qZ2nB8ALAbGFyN4-LJ&export=download" -O pokemon_usage.csv

clear_screen() {
    clear 
}

pokemon_header(){
    echo -e "\033[1;33m                                                                                                                
                                                         █▒                                              
                                                       ▓▓▒▒▓                                             
                                                     ▒▓▓░░░░▓░                                           
                                        ░ ░▓       ░▓▓░░░░▒▓░                                            
          ▒▒▓▓▓▓▓▓▓▒░             ░▒▓▓▓▓▓█▓▓▓▓    ██▓▓▒▓▓      ░▓▒▒▒▒▒▓▓▓▒▒▒▒▓                           
     ▒▓▓▓▓░░░░░░░░░░▒▓▓░      ██▓▒░░░░░▒▓▓▒░░░▓▓  ░▓▓▓▓▓▓▓▓▓▓░░█▓▓░░░░░▓▒░░░░▓      ▓█▓▓▓▓▓▓▒░           
  ▒▓▓▒░░░░░░░░░░░░░░░░░▓▓     █▓▓▓▓░░░░░▓░░░░░░░▓▓▓░░░░░░░░░░▒▓▓▓▒░░░░░▒░░░░░▓░     ▒█▓▒░░░░░░▓▓█▓▓▓▒░   
███▓▒░░░░░░░░░░░░░░░░░░░▓▒    ▓▓██▓░░░░░░░░░░░░▓▓░░░░▓▓▓▓▒░░░▓▓▓▓░░░░░░░░░░░░▒▓     ▒██▓▒░░░░░▒▓▓▒░░░░░▒░
 ▓██▓▓░░░░░░░░░░▓▓▓▓░░░░▒▓   ░░░██▓▒░░░░░░░░░▒▓▓▓░░░▓  ▓░░░▒▓▓█▓▓░░░░░░░░░░░░░▓▒▓▒▒░░▒▒▓▒░░░░░░▓▓░░░░░▒▓ 
  ░▓▓▓▓▒▓░░░░░░░▓▒ ▓▒░░░▓▓▓▒░░░░░░▓▓░░░░░░░▒▓  ▓▓░░░▒▓░░░▒▓░░▒▓▓▒░░░░░░░░░░░░▒▓░░▒▒░░░░░▒▒░░░░░▒▒░░░░░▓░ 
   ░▓▓▓▓▓▓░░░░░░░▓▒▓░░░▓▓░░░▓░░░░░░░▓░░░░░░░░▒▓▓▓░░░░░░░░░░░░░░▒▓▒░░░░░░░░░░▓▓░░▒▓▓░░░▒░░▓░░░░░░░░░░░▓▒  
       ▓█▓▓░░░░░░░░░░▒▓▓░░░▒▓▓░░▒░░░▓░░░░░░░░░░░▒▓▒░░░░░░░░░░▒▓▓░░░░░▓░░░▒░░▓░░░░▒▓▓▓▒░░░▓░░░░░░░░░░▒▓   
        ██▓▓░░░░░░░▓▓▓▓▒░░░░▒▓▓▓░░░░▓░░░▒▓▓▒░░░░░░▒▓▓▓▓▓▓▓▓▓▓█▓▒░░░░▒▓▓░▒▓░░▓░░░░░░░░░░░▒▒░░░░░░░░░░▓░   
        ░██▓▒░░░░░░▓▓█▓▓░░░░░░░░░░░▓▓░░░▒▓██▓▓▓░░░░░░░▒▓█▒  ██▓▒░░░░▓▓▓▓▓▓░░▒▓░░░░░░░░░▒▒░░░▒░░░░░░▒▒    
         ▒██▓▒░░░░░▓▓██▓▒░░░░░░░░░▓▓░░░░▒▓  ████▓▓▓░░░▒▓    ██████▓▓▓██▓█▓░░░░▓▓▒░░▒▒▓▓░░░░▒▒░░░░░▒▓     
          ███▓░░░░░░▓▓██▓▓▓░░░░▓▓▓█▓▒░░░▓▓      ███▓▓▓▓▓             ░░▓█▓▓▓▒░░▒▓▓█░██▓░░░░▒▒░░░░░▓░     
           ███▓░░░░░▒▓  ███████░ ▒█▓▓▓██▓          ░████                ▒▓████▓▓▓▒  ██▓▓▓▓▓▓▒░░░░▒▓      
            ██▓▓░░░░▒▓▒                                                                   █▓▒░░░░▓       
             ██▓▓▓▓▓█▓                                                                    ███▓▓▓▓▒       
              ██▒                                                                                     \e[0m"

}

show_help() {
    echo -e "\033[1;33mUsage: ./pokemon_analysis.sh [FILE] [OPTION]\033[0m"
    echo -e "\n\033[1;32m[OPTION] : \033[0m"
    echo "  -i, --info               Show the highest adjusted and raw usage"
    echo "  -s, --sort  [METHOD]     Sort the data by the specified column"
    echo "        name               Sort by Pokemon Name"
    echo "        usage              Sort by Adjusted Usage"
    echo "        raw                Sort by Raw Usage"
    echo "        hp                 Sort by HP"
    echo "        atk                Sort by Attack"
    echo "        def                Sort by Defense"
    echo "        spatk              Sort by Special Attack"
    echo "        spdef              Sort by Special Defense"
    echo "        speed              Sort by Speed"
    echo "  -g, --grep  [NAME]       Search Pokemon by name"
    echo "  -f, --filter [TYPE]      Filter by Pokemon type"
    echo "  -h, --help               Show this help"
    echo -e "\n\033[1;35mExamples:\033[0m"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --info"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --sort atk"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --grep 'Pikachu'"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --filter 'Dark'"
}

[ $# -lt 2 ] && { pokemon_header; show_help; exit 1; }
[ ! -f "$1" ] && { 
    echo -e "\033[1;31mError : File '$1' not found\033[0m"
    echo -e "\033[1;32mUse -h or --help for more information\033[0m"
    exit 1
}

CSV_FILE="$1"
shift

case "$1" in
    -i | --info)
        clear_screen
        pokemon_header
        awk -F, '
        BEGIN {
            max_usage = 0
            max_raw = 0
        }
        NR == 1 { next }
        {
            gsub(/%/, "", $2)
            current_usage = $2 + 0
            current_raw = $3 + 0
            
            if (current_usage > max_usage) {
                max_usage = current_usage
                max_pokemon_usage = $1
            }
            if (current_raw > max_raw) {
                max_raw = current_raw
                max_pokemon_raw = $1
            }
        }
        END {
            printf "\033[1;33m╔════════════════════════════════╗\n"
            printf "║            SUMMARY OF          ║\n"
            printf "║        pokemon_usage.csv       ║\n"
            printf "╚════════════════════════════════╝\n"
            printf " Highest Usage%%      %-10s \n", max_pokemon_usage
            printf " Value               \033[1;36m%-9.5f%%\033[1;33m \n", max_usage
            printf " ════════════════════════════════\n"
            printf " Highest Raw Usage   %-10s \n", max_pokemon_raw
            printf " Value               \033[1;36m%-9d\033[1;33m \n", max_raw
            printf " ════════════════════════════════\033[0m\n"
        }' "$CSV_FILE"
        ;;

    -s | --sort)
        clear_screen
        echo -e "\033[1;32mSORT BY '$2'\033[0m";
        [ -z "$2" ] && { 
            echo -e "\033[1;31mError: Missing sort criteria \033[0m"; 
            echo -e "\033[1;32mPlease add one [CRITERIA] of the following options :  \033[0m";
            echo -e "\033[1;32m- usage\033[0m";
            echo -e "\033[1;32m- raw\033[0m";
            echo -e "\033[1;32m- hp\033[0m";
            echo -e "\033[1;32m- atk\033[0m";
            echo -e "\033[1;32m- def\033[0m";
            echo -e "\033[1;32m- spatk\033[0m";
            echo -e "\033[1;32m- spdef\033[0m";
            echo -e "\033[1;32m- speed\033[0m";
            echo -e "\033[1;32m- name\033[0m";
            exit 1; } 
        CRITERIA="$2"
        HEADER=$(head -1 "$CSV_FILE")
        case "$CRITERIA" in
            usage)
                echo -e "\033[1m$HEADER\033[0m"
                awk -F, 'NR > 1 {             
                    print $2 "," $0
                }' "$CSV_FILE" | sort -t, -k1,1nr | cut -d, -f2-
                ;;
            raw|hp|atk|def|spatk|spdef|speed)
                COL_NUM=$(awk -F, -v f="$CRITERIA" 'NR==1 {
                    cols["raw"]=3; cols["hp"]=6; cols["atk"]=7
                    cols["def"]=8; cols["spatk"]=9; cols["spdef"]=10; cols["speed"]=11
                    print cols[f]}' "$CSV_FILE")
                echo -e "\033[1m$HEADER\033[0m"
                awk 'NR > 1' "$CSV_FILE" | sort -t, -k$COL_NUM,$COL_NUM -nr
                ;;
            name)
                echo -e "\033[1m$HEADER\033[0m"
                awk 'NR > 1' "$CSV_FILE" | sort -t, -k1,1
                ;;
            *) 
                echo -e "\033[1;31mError: Invalid criteria '$CRITERIA'\033[0m"
                exit 1
                ;;
        esac
        ;;

    -g | --grep)
    clear_screen
    echo -en "\033[1;32mThis is Pokemon name that contains the word : '$2' \033[0m\n";
    [ -z "$2" ] && { 
        echo -e "\033[1;31mError: Missing search term\033[0m";
        echo -e "\033[1;32mPlease enter a search term \033[0m";
        exit 1; }
        SEARCH_TERM=$(echo "$2" | tr '[:upper:]' '[:lower:]')
        HEADER=$(head -1 "$CSV_FILE")
        
        RESULTS=$(awk -F, -v term="$SEARCH_TERM" '
        NR == 1 { next }
        index(tolower($1), term) > 0 {
            gsub(/%/, "", $2)
            printf "%s,%.5f%%,%d,%s,%s,%d,%d,%d,%d,%d,%d\n", 
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
        }' "$CSV_FILE" | sort -t, -k2,2nr)
        if [ -z "$RESULTS" ]; then
            
            echo -e "\033[1;31mError: No entries found for name '$2'\033[0m"
            exit 1
        else
            echo -e "\033[1m$HEADER\033[0m"
            echo "$RESULTS"
        fi

    ;;

    -f | --filter)
        clear_screen
        echo -en "\033[1;32mPOKEMON TYPE '$2'\033[0m\n";
        [ -z "$2" ] && { 
        echo -e "\033[1;31mError: Missing type filter\033[0m";
        echo -e "\033[1;32mPlease enter a Pokemon Type \033[0m";
        exit 1; }
        FILTER_TYPE=$(echo "$2" | tr '[:upper:]' '[:lower:]')
        HEADER=$(head -1 "$CSV_FILE")
        echo -e "\033[1m$HEADER\033[0m"
        awk -F, -v type="$FILTER_TYPE" '
        NR == 1 { next }
        tolower($4) == type || tolower($5) == type {
            gsub(/%/, "", $2)
            printf "%s,%.5f%%,%d,%s,%s,%d,%d,%d,%d,%d,%d\n", 
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
        }' "$CSV_FILE" | sort -t, -k2,2nr
        ;;

    -h |--help)
        pokemon_header
        show_help
        ;;
        
    *)
        echo -e "\033[1;31mError: Invalid command '$1'\033[0m"
        echo -e "\033[1;32mUse -h or --help for more information\033[0m"
        exit 1
        ;;
esac