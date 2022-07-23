#!/bin/sh

set -e

check_substring(){
    # $1 - string, $2 - substring
    case "$1" in
        (*"$2"*) true;;
        (*) false;;
    esac
}

replace(){
    #$1 - pattern, $2 - replacement, $3 - file
    value=$(echo "$2" | sed 's/\//\\\//g' | sed 's/\&/\\\&/g')
    sudo sed -i -z "s/$1/$value/g" $3
}

templates_filling(){
    while IFS= read -r line
    do
        if [ "$line" = "\n" ] || [ "$line" = " " ] || [ "$line" = "" ]; then
            continue;
        fi

        key=$(echo "$line" | cut -d= -f1)

        if check_substring "$sed_command_template_homeserver_yaml" "{$key}"; then
            value=$(echo "$line" | cut -d= -f2)
            replace "{$key}" "$value" "$matrix_conf" 
        fi
        
        if check_substring "$sed_command_template_postgres_init" "{$key}"; then
            value=$(echo "$line" | cut -d= -f2)
            replace "{$key}" "$value" "$postgres_init" 
        fi

    done < "$env_file"
}

env_file="./.env"
matrix_conf="./matrix_conf/homeserver.yaml"
postgres_init="./postgres/postgres_init.sql"

sed_command_template_homeserver_yaml="  name: psycopg2\n  txn_limit: 10000\n  args:\n    user: {POSTGRES_USER}\n    password: {POSTGRES_PASSWORD}\n    database: {POSTGRES_DB}\n    host: {POSTGRES_HOST}\n    port: 5432\n    cp_min: 5\n    cp_max: 10\n"

sed_command_template_postgres_init="{DB_ROLE_PASSWORD}"


# generate default homeserver configuration
sudo docker-compose -f docker-compose.yml run --rm synapse generate


# change basedate settings in homeserver.yaml config
sudo sed -i -z "s/  name: sqlite3\n  args:\n    database: \/data\/homeserver.db/$sed_command_template_homeserver_yaml/g" "$matrix_conf"

# filling of templates
# filling db properties
# change synapse_user role password
templates_filling

# enable registration
sudo sed -i "s/#enable_registration: false/#enable_registration: true/g" "$matrix_conf"

# building container 
sudo docker-compose -f docker-compose.yml up --build

