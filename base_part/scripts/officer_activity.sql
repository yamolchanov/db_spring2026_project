-- активность инспекторов по количеству штрафов
SELECT d.name AS department, d.region,
       o.rank, o.badge_num,
       COUNT(v.violation_id) AS violations_recorded
FROM officers o
JOIN departments d ON o.dept_id = d.dept_id
LEFT JOIN violation v ON o.officer_id = v.officer_id
GROUP BY d.name, d.region, o.officer_id, o.rank, o.badge_num
ORDER BY violations_recorded DESC;