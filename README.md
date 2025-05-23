<<<<<<< README.md

<div align="center">
<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

</div>

## Установка проекта!


1. **Клонируем проект:**

    ```bash
    git clone https://github.com/JustMorv/GameJam
    ```

2. **Сборка проекта:

    ```bash
    docker-compose build 
    ```
3. **Собираем контейнер:

    ```bash
    docker-compose up -d
    ```

4. **Устанавливаем зависимости:**

    ```bash
   docker-compose run composer install
    ```

5. **Cоздаём файл `.env` Добавляем подчючение к базе данных :**

    ```
    DB_CONNECTION=mysql
    DB_HOST=mysql
    DB_PORT=3306
    DB_DATABASE=laravel
    DB_USERNAME=laravel
    DB_PASSWORD=secret
    ```

6. **Переходим по адресу:**
    ```bash
    http://localhost:8000/
    ```
7. **Стандарные команды:**
    - **[php artisan:]**
      ```bash
       docker-compose run artisan
      ```

    - **[php composer:]**
      ```bash
      docker-compose run composer
      ```
