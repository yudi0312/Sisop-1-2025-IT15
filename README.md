# Praktikum Sisop Modul 1-2025-IT15

Anggota kelompok : 
- Putu Yudi Nandanjaya Wiraguna	5027241080
- Naruna Vicranthyo Putra Gangga	5027241105
- Az Zahrra Tasya Adelia	        5027241087

## Soal 1 (tidak revisi)

```bash
#!/bin/bash
wget -q --no-check-cerificate "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O reading_data.csv
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
```
## Soal 2 (tidak revisi)
## Soal 3 : The Dark Side of The Moon (DSOTM) - Bash Script
>Soal ini tidak terdapat revisi

Author : Putu Yudi Nandanjaya Wiraguna (5027241080)

### Deskripsi 

Script Bash ini dibuat oleh Authors sebagai bagian dari perayaan ulang tahun ke-52 album The Dark Side of The Moon oleh Pink Floyd. Program ini menampilkan lima fitur yang terinspirasi dari lima lagu dalam album tersebut. Script Bash ini dijalankan dengan cara ` ./dsotm.sh --play="<Track>` dengan Track sebagai nama lagu, seperti berikut ini : 

**1. Speak to Me** 

Menampilkan word of affirmation yang diperbarui setiap detik dengan mengambil data dari API [affirmation](https://github.com/annthurium/affirmations).

**2. On the Run**

Menyimulasikan progress bar dengan interval acak (0.1 - 1 detik) yang mempertahankan panjang tetap dan menampilkan persentase progres.

**3. Time**

Menampilkan jam waktu nyata (live clock) yang mencakup informasi tahun, bulan, tanggal, jam, menit, dan detik yang diperbarui setiap detik.

**4. Money**

Menyajikan efek visual matrix-style menggunakan simbol mata uang seperti $, €, £, ¥, dan lainnya.

**5. Brain Damage**

Menyediakan tampilan informasi proses sistem yang berjalan, mirip dengan task manager, diperbarui setiap detik dengan data dari ps dan top.

### ./dsotm.sh 

```bash
#!/bin/bash
clear_screen() {
    clear
}
show_header() {
    echo -e "\033[1;35m"
    echo "   █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█"
    echo "   █░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░█"
    echo "   █░THE DARK SIDE OF THE MOON░█"
    echo "   █░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░█"
    echo "   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
    echo -e "\033[0m"
}


speak_to_me() {
    declare -a history
    colors=(31 32 33 34 35 36 91 92 93 94 95 96)
    while true; do
        response=$(curl -s "https://www.affirmations.dev")
        affirmation=$(echo "$response" | awk -F'"' '/affirmation/{print $4}')
        if [ -n "$affirmation" ]; then
            history+=("$affirmation")
        fi

        clear_screen
        show_header

        echo -e "\n\033[1;35m╔════════════════════════════════════╗"
        echo -e "║     SPEAK TO ME - AFFIRMATIONS     ║"
        echo -e "╚════════════════════════════════════╝\033[0m"

        for ((i = 0; i < ${#history[@]}; i++)); do
            color_index=$((i % ${#colors[@]})) 
            echo -e "\033[1;${colors[color_index]}m◈ ${history[$i]}\033[0m"
        done

        echo -e "\n\033[1;37mPress Ctrl+C to return...\033[0m"
        sleep 1
    done
}

on_the_run() {
    width=$(tput cols)
    simbols=("▓")
    echo -e "\033[1;35mLoading ...\033[0m"
    for ((i=0; i<=100; i+=2)); do
        filled=$((width * i / 100))
        bar=$(printf "%${filled}s" | sed "s/ /${simbols[RANDOM%1]}/g")
        echo -ne "\r\033[1;32m${bar}\033[0m \033[1;37m$i%\033[0m"
        sleep 1
    done
    echo
}

time_clock() {
    while true; do
        clear_screen
        show_header
        echo -e "\n\033[1;33m╔════════════════════════════════════╗"
        echo -e "║                TIME                ║"
        echo -e "╚════════════════════════════════════╝\033[0m"
        date +"%Y-%m-%d | %H:%M:%S" | awk -F ' \\| ' '{
            printf "\n\033[1;32m%s \033[1;36m%s\033[0m\n", $1, $2
        }'
        
        sleep 1
    done
}

money_matrix() {
    symbols=('$' '€' '£' '¥' '₿' '₹' '₣' '¢' '₩')
    cols=$(tput cols)
    while true; do
        clear_screen
        for ((i=0; i<cols; i++)); do
            sym=${symbols[$RANDOM % ${#symbols[@]}]}
            echo -ne "\033[$((RANDOM % 10 + 2));${i}H\033[1;32m${sym}\033[0m"
        done
        sleep 0.1
    done
}

brain_damage() {
    while true; do
        clear_screen
        show_header
        echo -e "\n\033[1;35m╔═════════════════════════════════════════════╗"
        echo -e "║                BRAIN DAMAGE                 ║"
        echo -e "╚═════════════════════════════════════════════╝\033[0m"

       echo "top - $(uptime)"
        total_tasks=$(ps -e --no-headers | wc -l)
        running=$(ps -eo stat | grep -c 'R')
        sleeping=$(ps -eo stat | grep -c 'S')
        echo "Tasks: $total_tasks total, $running running, $sleeping sleeping, 0 stopped, 0 zombie"
        
        cpu_data=$(top -bn1 | grep '%Cpu(s)')
        echo "$cpu_data" | awk '{
            printf "%%Cpu(s): %5.1f us, %5.1f sy, %5.1f ni, %5.1f id, %5.1f wa, %5.1f hi, %5.1f si, %5.1f st\n",
            $2, $4, $6, $8, $10, $12, $14, $16
        }'
        
        free -m | awk '/Mem:/ {printf "MiB Mem : %s total, %s free, %s used, %s buff/cache\n", $2, $4, $3, $6}'
        free -m | awk '/Swap:/ {printf "MiB Swap: %s total, %s free, %s used\n", $2, $4, $3}'
        
        echo ""
        echo "  PID USER    PR  NI  VIRT    RES S %CPU %MEM   TIME+ COMMAND"
        ps -eo pid,user,pri,ni,vsz,rss,stat,%cpu,%mem,time,comm --sort=-%cpu | 
        head -n 11 | 
        awk 'NR>1 {
            printf "%5d %-8s %2d %3d %6dM %5dM %1s %4.1f %4.1f %9s %s\n",
            $1, $2, $3, $4, $5/1024, $6/1024, $7, $8, $9, $10, $11
        }'
        
        sleep 1
    done
}

if [[ $1 == "--play="* ]]; then
    track="${1#*=}"
    track="${track//\"/}"
    clear_screen
    show_header
    case $track in
        "Speak to Me") speak_to_me ;;
        "On the Run") on_the_run ;;
        "Time") time_clock ;;
        "Money") money_matrix ;;
        "Brain Damage") brain_damage ;;
        *) 
            echo -e "\033[1;31mInvalid track!\033[0m"
            echo -e "\033[1;32mUse : ./dsotm.sh --play="[TRACK]"\033[0m"
            echo -e "Available tracks: Speak to Me, On the Run, Time, Money, Brain Damage"
            echo -e "\033[1;31mPLZ!!!! MATCH THE COMMAND TRACK FORMAT\033[0m"
            exit 1
            ;;
    esac
else
    echo -e "\033[1;31mUsage: ./dsotm.sh --play=\"<Track>\"\033[0m"
    echo -e "\033[1;34mAvailable tracks:\033[0m"
    echo -e "  \033[1;36mSpeak to Me\033[0m    - Word Affirmation"
    echo -e "  \033[1;32mOn the Run\033[0m     - Loading Bar"
    echo -e "  \033[1;33mTime\033[0m         - Live clock"
    echo -e "  \033[1;35mMoney\033[0m        - Matrix"
    echo -e "  \033[1;34mBrain Damage\033[0m - System monitor"
    exit 1
fi
```
#### Track `speak_to_me`
```bash
speak_to_me() {
    declare -a history
    colors=(31 32 33 34 35 36 91 92 93 94 95 96)
    while true; do
        response=$(curl -s "https://www.affirmations.dev")
        affirmation=$(echo "$response" | awk -F'"' '/affirmation/{print $4}')
        if [ -n "$affirmation" ]; then
            history+=("$affirmation")
        fi

        clear_screen
        show_header

        echo -e "\n\033[1;35m╔════════════════════════════════════╗"
        echo -e "║     SPEAK TO ME - AFFIRMATIONS     ║"
        echo -e "╚════════════════════════════════════╝\033[0m"

        for ((i = 0; i < ${#history[@]}; i++)); do
            color_index=$((i % ${#colors[@]})) 
            echo -e "\033[1;${colors[color_index]}m◈ ${history[$i]}\033[0m"
        done

        echo -e "\n\033[1;37mPress Ctrl+C to return...\033[0m"
        sleep 1
    done
}
```

Fungsi `speak_to_me` menampilkan kata afirmasi dengan mengambil data dari API [affirmation](https://github.com/annthurium/affirmations). Setiap detik, fungsi ini akan mengakses API menggunakan `curl`, mengekstraknya menggunakan `awk`, dan menambahkan ke dalam array `history`. 

#### Track `on_the_run`

```bash
on_the_run() {
    width=$(tput cols)
    simbols=("▓")
    echo -e "\033[1;35mLoading ...\033[0m"
    for ((i=0; i<=100; i+=2)); do
        filled=$((width * i / 100))
        bar=$(printf "%${filled}s" | sed "s/ /${simbols[RANDOM%1]}/g")
        echo -ne "\r\033[1;32m${bar}\033[0m \033[1;37m$i%\033[0m"
        sleep 1
    done
    echo
}
```

Fungsi `on_the_run` menampilkan progres bar dinamis pada terminal. `tput cols` digunakan untuk memperoleh lebar terminal, lalu progres loading bar ditampilakn dengan karakter `▓`. Setiap iterasi dalam loop, panjang progress bar dihitung berdasarkan persentase kemajuan, kemudian diisi dengan simbol menggunakan `printf` dan `sed`. Tampilan diperbarui secara real-time dengan `echo -ne`, diikuti oleh persentase progres. Iterasi yang saya gunakan berlangsung dengan peningkatan 2% setiap detik hingga mencapai 100%. 

#### Track `time_clock`

```bash
time_clock() {
    while true; do
        clear_screen
        show_header
        echo -e "\n\033[1;33m╔════════════════════════════════════╗"
        echo -e "║                TIME                ║"
        echo -e "╚════════════════════════════════════╝\033[0m"
        date +"%Y-%m-%d | %H:%M:%S" | awk -F ' \\| ' '{
            printf "\n\033[1;32m%s \033[1;36m%s\033[0m\n", $1, $2
        }'
        
        sleep 1
    done
}
```

Fungsi `time_clock` menampilkan hari dan jam di terminal dengan update setiap detik. Terdapat looping tak terbatas, terminal dibersihkan setiap looping menggunakan `clear_screen`. Fungsi `date +"%Y-%m-%d | %H:%M:%S"` digunakan untuk mendapatkan tanggal dan waktu saat ini. Setelah mencetak semuanya, program akan melakukan pembaruan setiap detik menggunakan `sleep 1`. 

#### Track `money_matrix`

```bash
money_matrix() {
    symbols=('$' '€' '£' '¥' '₿' '₹' '₣' '¢' '₩')
    cols=$(tput cols)
    while true; do
        clear_screen
        for ((i=0; i<cols; i++)); do
            sym=${symbols[$RANDOM % ${#symbols[@]}]}
            echo -ne "\033[$((RANDOM % 10 + 2));${i}H\033[1;32m${sym}\033[0m"
        done
        sleep 0.1
    done
}
```

Fungsi `money_matrix` menampilkan program seperti cmatrix, tetapi menggunakan simbol mata uang, seperti `$`, `€`, `£`, `¥`, `₿`, `₹`, `₣`, `¢`,dan `₩`. Lebar terminal diperoleh menggunakan `tput cols`. Setiap iterasi, simbol akan diacak secara random dan ditampilkan secara horizontal dan vertikal. Dengan menggunakan `sleep 0,1`, tampilan diperbarui setiap 0,1 detik. 

#### Track `brain_damage`

```bash
brain_damage() {
    while true; do
        clear_screen
        show_header
        echo -e "\n\033[1;35m╔═════════════════════════════════════════════╗"
        echo -e "║                BRAIN DAMAGE                 ║"
        echo -e "╚═════════════════════════════════════════════╝\033[0m"

       echo "top - $(uptime)"
        total_tasks=$(ps -e --no-headers | wc -l)
        running=$(ps -eo stat | grep -c 'R')
        sleeping=$(ps -eo stat | grep -c 'S')
        echo "Tasks: $total_tasks total, $running running, $sleeping sleeping, 0 stopped, 0 zombie"
        
        cpu_data=$(top -bn1 | grep '%Cpu(s)')
        echo "$cpu_data" | awk '{
            printf "%%Cpu(s): %5.1f us, %5.1f sy, %5.1f ni, %5.1f id, %5.1f wa, %5.1f hi, %5.1f si, %5.1f st\n",
            $2, $4, $6, $8, $10, $12, $14, $16
        }'
        
        free -m | awk '/Mem:/ {printf "MiB Mem : %s total, %s free, %s used, %s buff/cache\n", $2, $4, $3, $6}'
        free -m | awk '/Swap:/ {printf "MiB Swap: %s total, %s free, %s used\n", $2, $4, $3}'
        
        echo ""
        echo "  PID USER    PR  NI  VIRT    RES S %CPU %MEM   TIME+ COMMAND"
        ps -eo pid,user,pri,ni,vsz,rss,stat,%cpu,%mem,time,comm --sort=-%cpu | 
        head -n 11 | 
        awk 'NR>1 {
            printf "%5d %-8s %2d %3d %6dM %5dM %1s %4.1f %4.1f %9s %s\n",
            $1, $2, $3, $4, $5/1024, $6/1024, $7, $8, $9, $10, $11
        }'
        
        sleep 1
    done
}
```

Fungsi `brain_damage` menampilkan informasi sistem secara real-time, mirip dengan perintah top, dengan tampilan yang diperbarui setiap detik. Terminal dibersihkan dengan `clear_screen`. Fungsi ini menampilkan jumlah total proses, jumlah proses yang sedang berjalan (`R`), serta yang dalam keadaan tidur (`S`). Informasi penggunaan CPU diekstrak dari perintah `top -bn1`, lalu diformat dengan `awk` untuk menampilkan persentase penggunaan dalam berbagai kategori (user, system, idle, dsb.). Penggunaan memori (RAM dan swap) diperoleh melalui `free -m`, lalu diformat agar lebih mudah dibaca. Selanjutnya, daftar 10 proses dengan penggunaan CPU tertinggi ditampilkan menggunakan `ps -eo` dan diformat dengan `awk`, mencantumkan detail seperti PID, user, prioritas, penggunaan memori, dan CPU. Fungsi ini berjalan dalam loop tak terbatas dengan `sleep 1`, sehingga data diperbarui setiap detik.

Setelah semua fungsi berjalan, program akan melakukan parsing sesuai dengan argument yang sesuai dan tidak sesuai : 

```bash
if [[ $1 == "--play="* ]]; then
    track="${1#*=}"
    track="${track//\"/}"
    clear_screen
    show_header
    case $track in
        "Speak to Me") speak_to_me ;;
        "On the Run") on_the_run ;;
        "Time") time_clock ;;
        "Money") money_matrix ;;
        "Brain Damage") brain_damage ;;
        *) 
            echo -e "\033[1;31mInvalid track!\033[0m"
            echo -e "\033[1;32mUse : ./dsotm.sh --play="[TRACK]"\033[0m"
            echo -e "Available tracks: Speak to Me, On the Run, Time, Money, Brain Damage"
            echo -e "\033[1;31mPLZ!!!! MATCH THE COMMAND TRACK FORMAT\033[0m"
            exit 1
            ;;
    esac
else
    echo -e "\033[1;31mUsage: ./dsotm.sh --play=\"<Track>\"\033[0m"
    echo -e "\033[1;34mAvailable tracks:\033[0m"
    echo -e "  \033[1;36mSpeak to Me\033[0m    - Word Affirmation"
    echo -e "  \033[1;32mOn the Run\033[0m     - Loading Bar"
    echo -e "  \033[1;33mTime\033[0m         - Live clock"
    echo -e "  \033[1;35mMoney\033[0m        - Matrix"
    echo -e "  \033[1;34mBrain Damage\033[0m - System monitor"
    exit 1
fi
```

Kendala tidak ada. 

screenshot : 

## Soal 4 - Pokemon Analysis
> Soal ini terdapat revisi di bagian `--grep`

Author : Putu Yudi Nandanjaya Wiraguna (5027241080)

### Deskripsi

Script Bash ini ditugaskan kepada Author untuk membuat berbagai fitur analis yang berguna dalam turnamen **Pokemon “Generation 9 OverUsed 6v6 Singles”**. Nah, data yang kita akan analis tersebut terdiri dari beberapa kolom, seperti berikut ini 

- Nama Pokemon
- Usage% 
- RawUsage
- HP
- Atk
- Def
- Sp.Atk
- Sp.def
- Speed

### ./pokemon_analysis.sh 
``` bash
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
                echo -e "\033[1;32mSORT BY '$2'\033[0m";
                echo -e "\033[1m$HEADER\033[0m"
                awk -F, 'NR > 1 {             
                    print $2 "," $0
                }' "$CSV_FILE" | sort -t, -k1,1nr | cut -d, -f2-
                ;;
            raw|hp|atk|def|spatk|spdef|speed)
                echo -e "\033[1;32mSORT BY '$2'\033[0m";
                COL_NUM=$(awk -F, -v f="$CRITERIA" 'NR==1 {
                    cols["raw"]=3; cols["hp"]=6; cols["atk"]=7
                    cols["def"]=8; cols["spatk"]=9; cols["spdef"]=10; cols["speed"]=11
                    print cols[f]}' "$CSV_FILE")
                echo -e "\033[1m$HEADER\033[0m"
                awk 'NR > 1' "$CSV_FILE" | sort -t, -k$COL_NUM,$COL_NUM -nr
                ;;
            name)
                echo -e "\033[1;32mSORT BY '$2'\033[0m";
                echo -e "\033[1m$HEADER\033[0m"
                awk 'NR > 1' "$CSV_FILE" | sort -t, -k1,1
                ;;
            *) 
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
                exit 1
                ;;
        esac
        ;;

    -g | --grep)
        clear_screen
        [ -z "$2" ] && { 
            echo -e "\033[1;31mError: Missing search term\033[0m";
            echo -e "\033[1;32mPlease enter a search term\033[0m";
            exit 1; 
        }

        shift
        SEARCH_TERM=$(echo "$*" | tr '[:upper:]' '[:lower:]' | xargs)
        HEADER=$(head -1 "$CSV_FILE")

        RESULTS=$(awk -F, -v term="$SEARCH_TERM" '
        NR == 1 { next }
        tolower($1) ~ term {
            gsub(/%/, "", $2)
            printf "%s,%.5f%%,%d,%s,%s,%d,%d,%d,%d,%d,%d\n", 
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
        }' "$CSV_FILE")

        if [ -z "$RESULTS" ]; then
            echo -e "\033[1;31mError: No entries found for name containing '$SEARCH_TERM'\033[0m"
            exit 1
        else
            echo -en "\033[1;32mFound match(es) for Pokemon: '$SEARCH_TERM'\033[0m\n"
            echo -e "\033[1m$HEADER\033[0m"
            echo "$RESULTS"
        fi
    ;;

    -f | --filter)
        clear_screen
        [ -z "$2" ] && { 
        echo -e "\033[1;31mError: Missing type filter\033[0m";
        echo -e "\033[1;32mPlease enter a Pokemon Type \033[0m";
        exit 1; }
        FILTER_TYPE=$(echo "$2" | tr '[:upper:]' '[:lower:]')
        HEADER=$(head -1 "$CSV_FILE")
        output=$(awk -F, -v type="$FILTER_TYPE" '
        BEGIN { found = 0 }
        NR == 1 { next }
        tolower($4) == type || tolower($5) == type {
            found = 1
            gsub(/%/, "", $2)
            printf "%s,%.5f%%,%d,%s,%s,%d,%d,%d,%d,%d,%d\n", 
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
        }
        END {
            if (found == 0) {
                print "This pokemon type is not in the data, try searching again"
            }
        }' "$CSV_FILE" | sort -t, -k2,2nr)
        if [ "$output" = "This pokemon type is not in the data, try searching again" ]; then
            echo -e "\033[1;31m$output\033[0m"
        else
            echo -en "\033[1;32mPOKEMON TYPE '$2'\033[0m\n";
            echo -e "\033[1m$HEADER\033[0m"
            echo "$output"
        fi
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
```

#### Melihat summary dari data

```bash
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
```

Opsi `-i | --info` digunakan untuk menampilkan nama Pokemon dengan Usage% dan RawUsage paling tinggi. Script ini menggunakan `awk` untuk membaca dan memproses data dalam format CSV, di mana setiap kolom dipisahkan oleh koma (-F,). Baris pertama dilewati karena berisi header. Kemudian, skrip mencari Pokemon dengan Usage% tertinggi dan Raw Usage tertinggi dengan membandingkan setiap nilai di kolom kedua dan ketiga. Setelah menemukan nilai tertinggi, informasi ini ditampilkan dengan fungsi `printf`. Output yang dihasilkan menampilkan Pokemon dengan persentase Usage tertinggi serta Pokemon dengan RawUsage tertinggi. 

#### Mengurutkan Pokemon berdasarkan data kolom

```bash
-s | --sort)
        clear_screen
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
                echo -e "\033[1;32mSORT BY '$2'\033[0m";
                echo -e "\033[1m$HEADER\033[0m"
                awk -F, 'NR > 1 {             
                    print $2 "," $0
                }' "$CSV_FILE" | sort -t, -k1,1nr | cut -d, -f2-
                ;;
            raw|hp|atk|def|spatk|spdef|speed)
                echo -e "\033[1;32mSORT BY '$2'\033[0m";
                COL_NUM=$(awk -F, -v f="$CRITERIA" 'NR==1 {
                    cols["raw"]=3; cols["hp"]=6; cols["atk"]=7
                    cols["def"]=8; cols["spatk"]=9; cols["spdef"]=10; cols["speed"]=11
                    print cols[f]}' "$CSV_FILE")
                echo -e "\033[1m$HEADER\033[0m"
                awk 'NR > 1' "$CSV_FILE" | sort -t, -k$COL_NUM,$COL_NUM -nr
                ;;
            name)
                echo -e "\033[1;32mSORT BY '$2'\033[0m";
                echo -e "\033[1m$HEADER\033[0m"
                awk 'NR > 1' "$CSV_FILE" | sort -t, -k1,1
                ;;
            *) 
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
                exit 1
                ;;
        esac
        ;;

```

Opsi `-s | --sort` digunakan untuk mengurutkan dataset **pokemon_usage.csv** berdasarkan kriteria tertentu. Script ini mendukung pengurutan berdasarkan **Nama, Usage%, RawUsage, HP, Atk, Def, Sp.Atk, Sp.def, dan Speed**. Proses pengurutan dilakukan menggunakan `awk` dan `sort`, di mana data numerik diurutkan secara descending (dari nilai terbesar ke terkecil), sementara pengurutan berdasarkan nama dilakukan secara alfabetis. 

#### Mencari nama Pokemon tertentu

```bash
 -g | --grep)
        clear_screen
        [ -z "$2" ] && { 
            echo -e "\033[1;31mError: Missing search term\033[0m";
            echo -e "\033[1;32mPlease enter a search term\033[0m";
            exit 1; 
        }

        shift
        SEARCH_TERM=$(echo "$*" | tr '[:upper:]' '[:lower:]' | xargs)
        HEADER=$(head -1 "$CSV_FILE")

        RESULTS=$(awk -F, -v term="$SEARCH_TERM" '
        NR == 1 { next }
        tolower($1) ~ term {
            gsub(/%/, "", $2)
            printf "%s,%.5f%%,%d,%s,%s,%d,%d,%d,%d,%d,%d\n", 
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
        }' "$CSV_FILE")

        if [ -z "$RESULTS" ]; then
            echo -e "\033[1;31mError: No entries found for name containing '$SEARCH_TERM'\033[0m"
            exit 1
        else
            echo -en "\033[1;32mFound match(es) for Pokemon: '$SEARCH_TERM'\033[0m\n"
            echo -e "\033[1m$HEADER\033[0m"
            echo "$RESULTS"
        fi
    ;;

```

Opsi `-g | --grep` digunakan untuk mencari nama Pokemon dari dataset pokemon_usage.csv. Skrip ini mengkonversi input nama Pokemon ke lowercase, supaya pencarian tidak bersifat case-sensitive. Kemudian, dengan menggunakan `awk`, skrip memeriksa apakah nama Pokemon dalam dataset cocok dengan kata pencarian yang diberikan. Jika ditemukan hasil yang sesuai, skrip akan menampilkan data Pokemon tersebut dengan format yang sudah diformat ulang, termasuk persentase penggunaan yang ditampilkan hingga lima desimal. Jika tidak ada hasil yang cocok, pesan kesalahan akan ditampilkan.

#### Mencari Pokemon berdasarkan filter nama type

```bash
-f | --filter)
        clear_screen
        [ -z "$2" ] && { 
        echo -e "\033[1;31mError: Missing type filter\033[0m";
        echo -e "\033[1;32mPlease enter a Pokemon Type \033[0m";
        exit 1; }
        FILTER_TYPE=$(echo "$2" | tr '[:upper:]' '[:lower:]')
        HEADER=$(head -1 "$CSV_FILE")
        output=$(awk -F, -v type="$FILTER_TYPE" '
        BEGIN { found = 0 }
        NR == 1 { next }
        tolower($4) == type || tolower($5) == type {
            found = 1
            gsub(/%/, "", $2)
            printf "%s,%.5f%%,%d,%s,%s,%d,%d,%d,%d,%d,%d\n", 
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11
        }
        END {
            if (found == 0) {
                print "This pokemon type is not in the data, try searching again"
            }
        }' "$CSV_FILE" | sort -t, -k2,2nr)
        if [ "$output" = "This pokemon type is not in the data, try searching again" ]; then
            echo -e "\033[1;31m$output\033[0m"
        else
            echo -en "\033[1;32mPOKEMON TYPE '$2'\033[0m\n";
            echo -e "\033[1m$HEADER\033[0m"
            echo "$output"
        fi
    ;;
```

Opsi `-f | --filter` digunakan untuk menyaring Pokemon berdasarkan tipe dalam dataset pokemon_usage.csv. Script mengubah input ke huruf kecil untuk memastikan pencocokan tidak case-sensitive. Dengan menggunakan awk, skrip memeriksa apakah tipe utama (Type1) atau tipe sekunder (Type2) dari setiap Pokemon sesuai dengan tipe yang diminta. Jika ada hasil yang cocok, data Pokemon akan ditampilkan dalam urutan berdasarkan Usage% secara menurun. Jika tidak ditemukan Pokemon dengan tipe tersebut, pesan kesalahan akan ditampilkan. 

#### Eror Handling 

Dilihat dari script dari kami, sudah terdapat eror handling di setiap argumentnya. 

#### Help screen yang menarik

```bash 
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

```

Opsi `-h | --help` berfungsi sebagai panduan penggunaan script `pokemon_analysis.sh` ini. Fungsi `show_help` kemudian mendefinisikan panduan penggunaan skrip, mencantumkan berbagai opsi seperti --info untuk melihat Pokemon dengan penggunaan tertinggi, --sort untuk mengurutkan berdasarkan berbagai atribut (seperti serangan atau kecepatan), --grep untuk mencari Pokemon berdasarkan nama, dan --filter untuk menyaring Pokemon berdasarkan tipe. Jika dari pengguna melakukan kesalahan argument, akan memunculkan `show_header` dan `show_help` sebagai panduan agar argument tersebut benar. `show_header` menggunakan ASCII ART dengan tulisan Pokemon yang menarik pengguna untuk memakai program ini. 

Kendala : Terdapat kendala pada bagian `-g | --grep`, dimana seharusnya jika pengguna memanggil argument `-g | --grep` dengan tipe nama yang lebih dari satu di dalam file pokemon_usage.csv tersebut, akan memberikan output semua nama Pokemon dengan nama yang dicari oleh pengguna. Akan tetapi, program saya hanya dapat mengambil satu nama Pokemon saja. Hal tersebut sudah saya revisi dan commit ulang. 

screenshot : 


