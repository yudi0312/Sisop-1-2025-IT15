#!/bin/bash

SALT="T3rr4Bl@d3!"

echo "Email:"
read email
echo "Password:"
read -s password

if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Email tidak valid. Pastikan format email benar."
    exit 1
fi

user_data=$(grep "^$email," data/player.csv)

if [ -z "$user_data" ]; then
    echo "Email tidak terdaftar."
    exit 1
fi

stored_hashed_password=$(echo "$user_data" | cut -d',' -f3)

hashed_input_password=$(echo -n "$password$SALT" | sha256sum | awk '{print $1}')

if [ "$stored_hashed_password" != "$hashed_input_password" ]; then
    echo "Password salah."
    exit 1
fi

echo "Login berhasil!"
