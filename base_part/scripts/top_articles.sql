-- топ статей по количеству нарушений
SELECT a.code, a.desc_text, COUNT(v.violation_id) AS count, a.min_fine, a.max_fine
FROM article a
LEFT JOIN violation v ON a.article_id = v.article_id
GROUP BY a.article_id, a.code, a.desc_text, a.min_fine, a.max_fine
ORDER BY count DESC;