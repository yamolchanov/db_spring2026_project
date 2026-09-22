-- сумма и кол-во штрафов по месяцам
SELECT TO_CHAR(f.date_text, 'YYYY-MM') AS month,
       COUNT(f.fine_id) AS fines_count,
       SUM(f.amount) AS total_amount,
       AVG(f.amount)::INT AS avg_amount
FROM fine f
GROUP BY TO_CHAR(f.date_text, 'YYYY-MM')
ORDER BY month;