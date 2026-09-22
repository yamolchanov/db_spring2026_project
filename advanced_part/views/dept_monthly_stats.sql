CREATE MATERIALIZED VIEW dept_monthly_stats AS
SELECT
    d.dept_id,
    d.name AS dept_name,
    d.region,
    date_trunc('month', v.violation_dt)::date AS month_start,
    COUNT(DISTINCT v.violation_id) AS violations_count,
    COUNT(DISTINCT f.fine_id) AS fines_count,
    SUM(COALESCE(f.amount, 0)) AS total_fines_amount,
    AVG(COALESCE(f.amount, 0)) AS avg_fine_amount
FROM departments d
JOIN officers o ON o.dept_id = d.dept_id
JOIN violation v ON v.officer_id = o.officer_id
LEFT JOIN fine f ON f.violation_id = v.violation_id
GROUP BY d.dept_id, d.name, d.region, date_trunc('month', v.violation_dt)::date;
