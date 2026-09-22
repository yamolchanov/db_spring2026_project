CREATE OR REPLACE PROCEDURE expire_licenses(
    date_of_check DATE
)
AS
$$
BEGIN
    IF date_of_check IS NULL THEN
        RAISE EXCEPTION 'Дата проверки не может быть NULL';
    END IF;

    UPDATE driving_license
    SET status_text = 'expired'
    WHERE expiry_date < date_of_check
    AND status_text IN ('active', 'suspended');
END;
$$ LANGUAGE plpgsql;