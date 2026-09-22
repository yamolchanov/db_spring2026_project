CREATE OR REPLACE FUNCTION check_age()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.birth_date > CURRENT_DATE - INTERVAL '18 years' THEN
        RAISE EXCEPTION 'Водитель должен быть старше 18 лет';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_age
BEFORE INSERT OR UPDATE ON persons
FOR EACH ROW
EXECUTE FUNCTION check_age();