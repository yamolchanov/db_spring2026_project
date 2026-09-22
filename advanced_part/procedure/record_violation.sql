CREATE OR REPLACE PROCEDURE record_violation(
    p_violation_dt TIMESTAMPTZ,
    p_location TEXT,
    p_article_code INT,
    p_vehicle_number TEXT,
    p_driver_passport TEXT,
    p_officer_id INT,
    p_fine_amount NUMERIC
)
AS
$$
DECLARE
    v_violation_id INT;
    v_vehicle_id INT;
    v_driver_id INT;
    v_min_fine NUMERIC;
    v_max_fine NUMERIC;
    v_article_id INT;
BEGIN
    SELECT a.article_id, a.min_fine, a.max_fine
    INTO v_article_id, v_min_fine, v_max_fine
    FROM article a
    WHERE a.code = p_article_code;

    IF v_article_id IS NULL THEN
        RAISE EXCEPTION 'Статья не найдена по code: %', p_article_code;
    END IF;

    IF p_fine_amount < v_min_fine OR p_fine_amount > v_max_fine THEN
        RAISE EXCEPTION 'Сумма штрафа % вне диапазона [% - %]',
            p_fine_amount, v_min_fine, v_max_fine;
    END IF;

    SELECT v.vehicle_id
    INTO v_vehicle_id
    FROM vehicle v
    JOIN registration r ON r.vehicle_id = v.vehicle_id
    WHERE r.number = p_vehicle_number;

    IF v_vehicle_id IS NULL THEN
        RAISE EXCEPTION 'Автомобиль не найден: %', p_vehicle_number;
    END IF;

    SELECT p.person_id
    INTO v_driver_id
    FROM persons p
    WHERE p.passport_series = p_driver_passport;

    IF v_driver_id IS NULL THEN
        RAISE EXCEPTION 'Водитель не найден: %', p_driver_passport;
    END IF;

    INSERT INTO violation (
        violation_dt,
        location_text,
        article_id,
        vehicle_id,
        driver_id,
        officer_id
    )
    VALUES (
        p_violation_dt,
        p_location,
        v_article_id,
        v_vehicle_id,
        v_driver_id,
        p_officer_id
    )
    RETURNING violation_id INTO v_violation_id;

    INSERT INTO fine (
        violation_id,
        amount,
        date_text,
        status_text
    )
    VALUES (
        v_violation_id,
        p_fine_amount,
        p_violation_dt,
        'unpaid'
    );

END;
$$ LANGUAGE plpgsql;