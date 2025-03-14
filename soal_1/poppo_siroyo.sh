#!/bin/bash 
wget -q "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O reading_data.csv
FILE="reading_data.csv"
clear_screen(){
    clear
}
if [ "$1" = "soalA" ]; then
    clear_screen
    count=$(awk -F, 'tolower($2) == "chris hemsworth" {count++} END {print count}' "$FILE")
    echo "Chris Hemsworth membaca $count buku."

elif [ "$1" = "soalB" ]; then
    clear_screen
    Reading_Duration_Minutes=$(awk -F, '$8 == "Tablet" {sum+=$6; count++} END {if (count>0) print sum/count; else print 0}' "$FILE")
    echo "Rata-rata durasi membaca dengan Tablet adalah $Reading_Duration_Minutes menit."
    
elif [ "$1" = "soalC" ]; then
    clear_screen
    highest_rating=$(awk -F, 'NR>1 {if ($7 > max) {max=$7; name=$2; book=$3}} END {print name " - " book " - " max}' "$FILE")
    echo "Pembaca dengan rating tertinggi: $highest_rating"

elif [ "$1" = "soalD" ]; then 
    clear_screen
    result=$(awk -F, '
    $9 == "Asia" && $5 > "2023-12-31" {
        count[$4]++} END {
        max=0; genre="";
        for (g in count) {
            if (count[g] > max) {
                max=count[g]; genre=g
            }
        }
        printf "Genre paling populer di Asia setelah 2023 adalah %s dengan %d buku.\n", genre, max
    }' "$FILE")
    echo "$result"
else
    echo -e "\033[1;31mError: command '$1' tidak sesuai\033[0m"
    echo -e "\033[1;32mSilahkan pilih command [soalA/soalB/soalC/soalD]\033[0m"
    exit 1
fi 