Сгенерируй синтетический датасет в виде SQL INSERT-выражений для базы данных информационной системы ГИБДД.

**Схема таблиц:**
- persons(id, first_name, last_name, birth_date, passport_series, address, phone)
- driving_license(id, number, expiry_date, category, status)  — status: active/expired/suspended
- departments(id, name, region, address)
- legal_entity(id, name, address, phone)
- vehicle(id, vin, brand, model, year, color, category, owner_person_id, owner_legal_id)
- registration(id, vehicle_id, plate_number, department_id)
- officers(id, rank, badge_number, person_id, department_id)
- article(id, code, description, fine_max, fine_min)
- violation(id, datetime, location, vehicle_id, officer_id, article_id, person_id)
- fine(id, violation_id, amount, issue_date, status)  — status: paid/unpaid/disputed

**Требования к данным:**
1. Минимум 15 строк в каждой таблице (кроме article — достаточно 10)
2. Российские имена, адреса, телефоны (+7...), регионы
3. Реалистичные связи между таблицами (внешние ключи согласованы)
4. Разнообразие статусов: права — expired/suspended, штрафы — paid/unpaid/disputed
5. Временной диапазон нарушений: 2024–2025 год
6. Несколько «интересных» случаев: несовершеннолетний водитель, просроченные права, повторный нарушитель
7. Номерные знаки в российском формате: А123АА77, М332СК716 и т.п.
8. Марки авто: смесь отечественных (Lada, УАЗ) и иномарок

**Формат вывода:**
Только SQL INSERT-выражения, без CREATE TABLE, без комментариев.
Порядок: persons → driving_license → departments → legal_entity → vehicle → registration → officers → article → violation → fine