CREATE OR REPLACE FUNCTION sync_payment()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status_text = 'unpaid' AND NEW.status_text = 'paid' THEN
        NEW.date_text := NOW();
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_payment
BEFORE UPDATE ON fine
FOR EACH ROW
EXECUTE FUNCTION sync_payment();