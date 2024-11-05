#!/bin/bash

# Проверяем, что скрипт запущен от root
if [ "$EUID" -ne 0 ]
  then echo "Пожалуйста, запустите скрипт от root"
  exit
fi

# Проверка аргументов
if [ $# -ne 1 ]; then
    echo "Использование: $0 <пароль для пользователя postgres>"
    exit 1
fi

POSTGRES_PASSWORD=$1

# Установка PostgreSQL
echo "Установка PostgreSQL..."
apt update
apt install -y postgresql postgresql-contrib

# Включение автозапуска PostgreSQL при старте системы
echo "Включение PostgreSQL в автозапуске..."
systemctl enable postgresql

# Запуск PostgreSQL
echo "Запуск PostgreSQL..."
systemctl start postgresql

# Установка пароля для пользователя postgres
echo "Настройка пароля для пользователя postgres..."
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '$POSTGRES_PASSWORD';"

# Проверка статуса PostgreSQL
echo "Проверка статуса PostgreSQL..."
systemctl status postgresql

echo "PostgreSQL успешно установлен и настроен."
