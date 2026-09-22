-- отчет работы департаментов по количеству инспекторов, нарушений и собранных штрафов
SELECT d.name AS department, d.region,
       COUNT(DISTINCT o.officer_id) AS officers_count,
       COUNT(DISTINCT v.violation_id) AS violations_count,
       SUM(f.amount) AS total_fines_collected
FROM departments d
LEFT JOIN officers o ON d.dept_id = o.dept_id
LEFT JOIN violation v ON o.officer_id = v.officer_id
LEFT JOIN fine f ON v.violation_id = f.violation_id
GROUP BY d.dept_id, d.name, d.region
ORDER BY total_fines_collected DESC NULLS LAST;