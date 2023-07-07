#!/bin/bash

CONTAINER_NAME=""
dir_base=""
HOST=$(hostname)
MUSER=""
MSENHA=""
DB=( )

datap=$(date +%Y_%m_%d_%H_%M)
created_at=$(date +%Y%m%d%H%M%S)

find "$dir_base" -mtime +4 -type f -delete
find "$dir_base" -mtime +4 -exec rm -r {} \;

cd "$dir_base" || exit

mkdir "$HOST"_"$datap"
chmod 755 -R "$HOST"_"$datap"

for i in "${DB[@]}"; do
    MYSQL_DATA="$i.sql.gz"
    docker exec "$CONTAINER_NAME" mysqldump "$i" -u root -p | gzip > "$dir_base/$HOST"_"$datap/$MYSQL_DATA"
done

gzip -r "$HOST"_"$datap"

# scp -r "$datap" "$SERVER_DESTINO:$BACKUP_REMOTO"

if [[ -d "$dir_base/$HOST"_"$datap" ]]; then
    curl -X POST -H "Content-Type: application/json" \
        -d '{"status":"sucesso", "message":"backup realizado com sucesso", "created_at":"'"$created_at"'"}' \
        https://webhook.site/
else
    curl -X POST \
        -H 'Content-Type: application/json' \
        -d '{"chat_id": " ", "text": "Backup falhou", "disable_notification": true}' \
        https://api.telegram.org/bot
fi

exit 0
