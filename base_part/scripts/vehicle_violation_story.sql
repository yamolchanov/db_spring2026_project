-- история штрафов на аппарате
SELECT vh.brand, vh.model, vh.year, vh.color, r.number AS plate,
       COUNT(v.violation_id) AS total_violations,
       SUM(f.amount) AS total_fines
FROM vehicle vh
JOIN registration r ON vh.vehicle_id = r.vehicle_id
LEFT JOIN violation v ON vh.vehicle_id = v.vehicle_id
LEFT JOIN fine f ON v.violation_id = f.violation_id
GROUP BY vh.vehicle_id, vh.brand, vh.model, vh.year, vh.color, r.number
ORDER BY total_violations DESC;