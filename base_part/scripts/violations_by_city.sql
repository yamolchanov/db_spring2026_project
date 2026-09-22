-- кол-во нарушений па городу))
SELECT v.location_text, COUNT(v.violation_id) AS total_violations,
       SUM(f.amount) AS total_fines_amount
FROM violation v
JOIN fine f ON v.violation_id = f.violation_id
GROUP BY v.location_text
ORDER BY total_violations DESC;