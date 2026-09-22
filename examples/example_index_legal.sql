INSERT INTO legal_entity(name, address, phone)
SELECT
    'Company ' || i,
    'Address ' || i,
    '+79' || LPAD(i::text, 9, '0')
FROM generate_series(1, 10000) i;

ANALYZE legal_entity;

EXPLAIN ANALYZE
SELECT *
FROM legal_entity
WHERE name = 'Company 150000';