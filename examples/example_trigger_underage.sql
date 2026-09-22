INSERT INTO persons (
    person_id,
    first_name,
    last_name,
    birth_date,
    passport_series,
    address,
    phone
)
VALUES (
    999,
    'Тест',
    'Юный',
    CURRENT_DATE - INTERVAL '10 years',
    '1234567890',
    'Тестовый адрес',
    '+79001112233'
);