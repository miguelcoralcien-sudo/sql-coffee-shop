# SQL Coffee Shop

Учебный проект по работе с SQL (SQLite + DBeaver) на примере интернет-магазина кофе.

## Структура
- `schema.sql` — создание таблиц `products` и `orders`.
- `seed.py` — скрипт на Python для генерации 120 товаров и тестовых заказов.
- `queries.sql` — все запросы по заданию (INSERT, UPDATE, DELETE, SELECT, JOIN, агрегация).
- `coffee_shop.db` — файл базы данных (создается после запуска `seed.py`).

## Безопасность (Параметризация)
**Опасно (конкатенация):**
`query = f"SELECT * FROM products WHERE sku = '{user_input}'"`
*Риск: SQL-инъекция. Пользователь может ввести `' OR 1=1; --` и вытащить все данные.*

**Безопасно (параметризация):**
`query = "SELECT * FROM products WHERE sku = ?"`
`cursor.execute(query, (user_input,))`
*Риск: нулевой. База данных воспринимает ввод как данные, а не как команду.*
