CREATE OR REPLACE FUNCTION driver_summary(
    p_driver_id INT,
    p_date_from DATE,
    p_date_to DATE
)
RETURNS TABLE (
    driver_id INT,
    violations_count BIGINT,
    total_fines_amount NUMERIC,
    unpaid_fines_amount NUMERIC,
    unpaid_share NUMERIC
)
AS
$$
BEGIN
    RETURN QUERY
    SELECT
        v.driver_id,
        COUNT(v.violation_id) AS violations_count,
        COALESCE(SUM(f.amount), 0)::numeric AS total_fines_amount,
        COALESCE(SUM(CASE WHEN f.status_text = 'unpaid' THEN f.amount ELSE 0 END), 0)::numeric AS unpaid_fines_amount,
        CASE
            WHEN COALESCE(SUM(f.amount), 0) = 0 THEN 0
            ELSE ROUND(
                COALESCE(SUM(CASE WHEN f.status_text = 'unpaid' THEN f.amount ELSE 0 END), 0)::numeric
                / COALESCE(SUM(f.amount), 0)::numeric,
                4
            )
        END AS unpaid_share
    FROM violation v
    LEFT JOIN fine f ON f.violation_id = v.violation_id
    WHERE v.driver_id = p_driver_id
      AND v.violation_dt::date BETWEEN p_date_from AND p_date_to
    GROUP BY v.driver_id;
END;
$$ LANGUAGE plpgsql;
