SELECT * FROM fine WHERE status_text = 'unpaid';

UPDATE fine
SET status_text = 'paid'
WHERE violation_id = 2;

SELECT * FROM fine WHERE violation_id = 2;
