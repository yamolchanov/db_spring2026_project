-- штрафы на рассмотрении
SELECT p.first_name, p.last_name, a.desc_text AS violation_type,
       v.violation_dt, v.location_text, f.amount,
       o.rank, o.badge_num, d.name AS department
FROM fine f
JOIN violation v ON f.violation_id = v.violation_id
JOIN persons p ON v.driver_id = p.person_id
JOIN article a ON v.article_id = a.article_id
JOIN officers o ON v.officer_id = o.officer_id
JOIN departments d ON o.dept_id = d.dept_id
WHERE f.status_text = 'disputed'
ORDER BY f.amount DESC;