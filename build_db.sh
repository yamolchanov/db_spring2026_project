#!/usr/bin/env sh

DB_NAME="${DB_NAME:-traffic_violations}"
DB_USER="${DB_USER:-$USER}"
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DROP_SCHEMA="${DROP_SCHEMA:-0}"

if [ "${1:-}" = "--rebuild" ]; then
  DROP_SCHEMA=1
fi

PSQL="psql -v ON_ERROR_STOP=1 -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME"

echo "База данных: $DB_NAME"
echo "Пользователь: $DB_USER"
echo "Хост: $DB_HOST"
echo "Порт: $DB_PORT"

if [ "$DROP_SCHEMA" = "1" ]; then
  echo "Удаляю старую схему"
  $PSQL -c "DROP SCHEMA IF EXISTS public CASCADE; CREATE SCHEMA public;"
fi

echo "Загружаю схему"
$PSQL -f "data/db.sql"

echo "Загружаю тестовые данные"
$PSQL -f "data/synthetic_data.sql"

echo "Загружаю индексы"
$PSQL -f "advanced_part/indexes/indexes.sql"

echo "Загружаю представления"
for f in advanced_part/views/*.sql; do
  if [ -f "$f" ]; then
    $PSQL -f "$f"
  fi
done

echo "Загружаю процедуры и функции"
for f in advanced_part/procedure/*.sql; do
  if [ -f "$f" ]; then
    $PSQL -f "$f"
  fi
done

echo "Загружаю триггеры"
for f in advanced_part/triggers/*.sql; do
  if [ -f "$f" ]; then
    $PSQL -f "$f"
  fi
done

echo "Готово."
