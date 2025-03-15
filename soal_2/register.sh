#!/bin/bash

SALT="T3rr4Bl@d3!"

echo "Email:"
read email
echo "Username:"
read username
echo "Password:"
read -s password

if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Email tidak valid. Pastikan format email benar."
    exit 1
fi

if [[ ${#password} -lt 8 ]]; then
    echo "Password harus memiliki minimal 8 karakter."
    exit 1
fi

if [[ ! "$password" =~ [a-z] ]]; then
    echo "Password harus mengandung setidaknya satu huruf kecil."
    exit 1
fi

if [[ ! "$password" =~ [A-Z] ]]; then
    echo "Password harus mengandung setidaknya satu huruf besar."
    exit 1
fi

if [[ ! "$password" =~ [0-9] ]]; then
    echo "Password harus mengandung setidaknya satu angka."
    exit 1
fi

if awk -F',' -v e="$email" '$1 == e {found=1} END {exit !found}' data/player.csv; then
    echo "Email sudah terdaftar. Silakan pilih email lain."
    exit 1
fi

hashed_password=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')

echo "$email,$username,$hashed_password" >> data/player.csv

echo "Pendaftaran berhasil! Akun telah dibuat." 
sleep 1
