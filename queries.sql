-- 1. Базовые INSERT (3 ручных)
INSERT INTO products (name, category, price, sku) VALUES ('Тестовый товар 1', 'Аксессуары', 500, 'TEST-001');
INSERT INTO products (name, category, price, sku) VALUES ('Тестовый товар 2', 'Аксессуары', 700, 'TEST-002');
INSERT INTO products (name, category, price, sku) VALUES ('Тестовый товар 3', 'Аксессуары', 900, 'TEST-003');

-- 1.2. Массовая вставка
INSERT INTO products (name, category, price, sku) VALUES 
('Массовый товар 1', 'Аксессуары', 100, 'MASS-001'),
('Массовый товар 2', 'Аксессуары', 200, 'MASS-002');

-- 2. UPDATE (3 осмысленных, с WHERE!)
UPDATE products SET price = price * 0.9 WHERE category = 'Дрип-пакеты';
UPDATE products SET price = 2500 WHERE sku = 'SKU-1234';
UPDATE products SET description = 'Распродажа' WHERE price < 1000;

-- 3. DELETE (с безопасным WHERE)
DELETE FROM products WHERE sku LIKE 'TEST-%';

-- 4. SELECT с WHERE + ORDER BY + LIMIT (топ-5)
SELECT name, price FROM products WHERE price > 2000 ORDER BY price DESC LIMIT 5;

-- 5. Агрегация (по категориям)
SELECT category, COUNT(*) AS count, AVG(price) AS avg_price FROM products GROUP BY category HAVING COUNT(*) > 5;

-- 6. LIKE (исправленный: ищем точное совпадение регистра)
SELECT name, price FROM products WHERE name LIKE '%Эфиопия%';

-- 7. JOIN (сводная выборка заказов)
SELECT o.id AS order_id, p.name AS product_name, o.quantity, (o.quantity * p.price) AS total_sum
FROM orders o
JOIN products p ON o.product_id = p.id;

-- 10. Пример безопасности (Параметризация)
-- ОПАСНО (никогда так не делайте):
-- query = f"SELECT * FROM products WHERE sku = '{user_input}'"
-- cursor.execute(query) 
-- Риск: пользователь может ввести ' OR 1=1; -- и вытащить все данные.

-- БЕЗОПАСНО (правильно):
-- query = "SELECT * FROM products WHERE sku = ?"
-- cursor.execute(query, (user_input,))
-- Риск: нулевой. База данных воспринимает ввод как данные, а не как команду.