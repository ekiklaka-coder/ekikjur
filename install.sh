#!/bin/bash
set -e

PANEL_DIR="/var/www/pterodactyl"

echo "== Install Theme Panel =="

if [ ! -d "$PANEL_DIR" ]; then
  echo "Panel tidak ditemukan"
  exit 1
fi

cd $PANEL_DIR

echo "Backup dulu..."
cp -r public/assets public/assets.backup.$(date +%s)

echo "Pasang theme (contoh CSS)..."
echo "body { background-color:#0f172a; }" > public/assets/custom-theme.css

echo "Inject CSS ke panel..."
grep -q "custom-theme.css" resources/views/layouts/admin.blade.php || \
sed -i '/<\/head>/i <link rel="stylesheet" href="\/assets\/custom-theme.css">' \
resources/views/layouts/admin.blade.php

echo "Clear cache..."
php artisan view:clear
php artisan optimize:clear

echo "SELESAI"
