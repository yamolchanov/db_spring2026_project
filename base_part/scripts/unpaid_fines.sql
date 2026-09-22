-- неоплаченные штрафы с контактами водителя и госномером автомобиля
SELECT p.first_name, p.last_name, p.phone,
       vh.brand, vh.model, r.number AS plate,
       f.amount, f.date_text, f.status_text
FROM fine f
JOIN violation v ON f.violation_id = v.violation_id
JOIN persons p ON v.driver_id = p.person_id
JOIN vehicle vh ON v.vehicle_id = vh.vehicle_id
JOIN registration r ON vh.vehicle_id = r.vehicle_id
WHERE f.status_text = 'unpaid'
ORDER BY f.amount DESC;