-- водители без прав совершившие нарушения
SELECT p.first_name, p.last_name, dl.expiry_date, dl.status, v.violation_dt, v.location_text
FROM persons p
JOIN driving_license dl ON p.person_id = dl.person_id
JOIN violation v ON p.person_id = v.driver_id
WHERE dl.status IN ('expired', 'suspended')
ORDER BY v.violation_dt DESC;