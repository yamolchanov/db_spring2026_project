 -- топ нарушителей по сумме штрафов
SELECT p.first_name, p.last_name, COUNT(v.violation_id) AS violations, SUM(f.amount) AS total_fine
FROM persons p
JOIN violation v ON p.person_id = v.driver_id
JOIN fine f ON v.violation_id = f.violation_id
GROUP BY p.person_id, p.first_name, p.last_name
ORDER BY total_fine DESC;