##!/bin/bash

SALT="T3rr4Bl@d3!"

while true; do
    echo -n "Email: "
    read email

    if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Email tidak valid! Pastikan format email benar (contoh: user@example.com)."
    elif awk -F',' -v e="$email" '$1 == e {found=1} END {exit !found}' data/player.csv; then
        echo "Email sudah terdaftar! Silakan gunakan email lain."
    else
        break
    fi
done

while true; do
    echo -n "Username: "
    read username

    if [[ -z "$username" || "$username" =~ [,\ ] ]]; then
        echo "Username tidak boleh kosong atau mengandung spasi/koma."
    else
        break
    fi
done

while true; do
    echo -n "Password: "
    read -s password
    echo ""

    if [[ ${#password} -lt 8 ]]; then
        echo "Password harus memiliki minimal 8 karakter."
    elif [[ ! "$password" =~ [a-z] ]]; then
        echo "Password harus mengandung setidaknya satu huruf kecil."
    elif [[ ! "$password" =~ [A-Z] ]]; then
        echo "Password harus mengandung setidaknya satu huruf besar."
    elif [[ ! "$password" =~ [0-9] ]]; then
        echo "Password harus mengandung setidaknya satu angka."
    else
        break
    fi
done

hashed_password=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')
echo "$email,$username,$hashed_password" >> data/player.csv

echo "Pendaftaran berhasil! Akun telah dibuat."
sleep 1
