#!/bin/sh
set -e

composer install --no-interaction --prefer-dist
npm install
npm run build

if ! grep -q '^APP_KEY=base64:' .env 2>/dev/null; then
    php artisan key:generate --force
fi

php artisan migrate:fresh --seed --force

exec php-fpm
