# SQL Database Projects

Решение задач по базам данных в рамках итогового тестирования.

## Содержание

- [О проекте](#о-проекте)
- [Стек технологий](#стек-технологий)
- [Структура репозитория](#структура-репозитория)
- [Базы данных](#базы-данных)
- [Установка и запуск](#установка-и-запуск)
- [Проверка решений](#проверка-решений)

## О проекте

Проект содержит решения 13 задач по SQL, охватывающих:
- Работу с JOIN, агрегатными функциями, подзапросами
- Группировку и сортировку данных
- UNION и UNION ALL для объединения выборок
- Рекурсивные запросы (WITH RECURSIVE)
- Работу с датами и строками
- Агрегацию с группировкой и оконные функции

## Стек технологий

- **СУБД**: PostgreSQL 17
- **Клиент**: DBeaver / psql


## Структура репозитория
```
sql-database-projects/
├── README.md
├── database1_vehicles/       # Транспортные средства (2 задачи)
│   ├── scripts/              # Скрипты создания таблиц и наполнения
│   └── solutions/            # Решения задач
├── database2_racing/         # Автомобильные гонки (5 задач)
│   ├── scripts/
│   └── solutions/
├── database3_hotels/         # Бронирование отелей (3 задачи)
│   ├── scripts/
│   └── solutions/
└── database4_organization/   # Структура организации (1 задача)
├── scripts/
└── solutions/
```


## Базы данных

### База данных 1. Транспортные средства

| Задача | Описание |
|--------|----------|
| Task 1 | Мотоциклы с мощностью >150 л.с., ценой <20000$, тип Sport |
| Task 2 | Объединённая выборка по автомобилям, мотоциклам и велосипедам |

### База данных 2. Автомобильные гонки

| Задача | Описание |
|--------|----------|
| Task 1 | Лучший автомобиль в каждом классе |
| Task 2 | Глобально лучший автомобиль |
| Task 3 | Классы с наилучшей средней позицией |
| Task 4 | Автомобили лучше среднего по классу |
| Task 5 | Классы с наибольшим количеством "слабых" автомобилей |

### База данных 3. Бронирование отелей

| Задача | Описание |
|--------|----------|
| Task 1 | Клиенты с >2 бронями в разных отелях |
| Task 2 | Клиенты с >2 бронями и тратами >500$ |
| Task 3 | Предпочтения клиентов по типу отелей |

### База данных 4. Структура организации

| Задача | Описание |
|--------|----------|
| Task 1 | Рекурсивный вывод всех подчинённых Ивана Иванова |

## Установка и запуск

### Установка PostgreSQL (если не установлен)

**Для macOS (Homebrew):**
```
brew install postgresql@17
brew services start postgresql@17
```

**Для Windows: Скачайте установщик с postgresql.org**

### Предварительные требования

- PostgreSQL 17
- DBeaver или psql

### Создание баз данных
```
CREATE DATABASE vehicles_db;
CREATE DATABASE racing_db;
CREATE DATABASE hotels_db;
CREATE DATABASE organization_db;
```

### Загрузка схем и данных

### База данных 1 (Транспортные средства)
- `psql -d vehicles_db -f database1_vehicles/scripts/create_tables.sql`
- `psql -d vehicles_db -f database1_vehicles/scripts/insert_data.sql`

### База данных 2 (Автомобильные гонки)
- `psql -d racing_db -f database2_racing/scripts/create_tables.sql`
- `psql -d racing_db -f database2_racing/scripts/insert_data.sql`

### База данных 3 (Бронирование отелей)
- `psql -d hotels_db -f database3_hotels/scripts/create_tables.sql`
- `psql -d hotels_db -f database3_hotels/scripts/insert_data.sql`

### База данных 4 (Структура организации)
- `psql -d organization_db -f database4_organization/scripts/create_tables.sql`
- `psql -d organization_db -f database4_organization/scripts/insert_data.sql`

### Выполнение решений

### Пример для Базы данных 1
- `psql -d vehicles_db -f database1_vehicles/solutions/task1.sql`
- `psql -d vehicles_db -f database1_vehicles/solutions/task2.sql`

### База данных 2
- `psql -d racing_db -f database2_racing/solutions/task1.sql`
- `psql -d racing_db -f database2_racing/solutions/task2.sql`
- `psql -d racing_db -f database2_racing/solutions/task3.sql`
- `psql -d racing_db -f database2_racing/solutions/task4.sql`
- `psql -d racing_db -f database2_racing/solutions/task5.sql`

### База данных 3
- `psql -d hotels_db -f database3_hotels/solutions/task1.sql`
- `psql -d hotels_db -f database3_hotels/solutions/task2.sql`
- `psql -d hotels_db -f database3_hotels/solutions/task3.sql`

### База данных 4
- `psql -d organization_db -f database4_organization/solutions/task1.sql`

###  Альтернативный способ (через DBeaver)

- Откройте DBeaver и подключитесь к PostgreSQL
- Выберите нужную базу данных в выпадающем списке
- Откройте файл с решением (File → Open File)
- Выполните запрос (Ctrl + Enter)

#### Проверка решений

```
Ожидаемые результаты для каждой задачи приведены в документации. 
Для проверки можно использовать:

\copy (SELECT ...) TO 'result.csv' CSV HEADER;
```

