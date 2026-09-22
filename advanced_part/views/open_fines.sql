CREATE VIEW open_fines AS
SELECT
    f.fine_id,
    f.status_text AS fine_status,
    f.date_text AS fine_date,
    v.location_text,
    p.first_name,
    p.last_name,
    r.number AS plate_number
FROM fine f
JOIN violation v ON v.violation_id = f.violation_id
JOIN article a ON a.article_id = v.article_id
JOIN persons p ON p.person_id = v.driver_id
JOIN vehicle veh ON veh.vehicle_id = v.vehicle_id
LEFT JOIN registration r ON r.vehicle_id = veh.vehicle_id
WHERE f.status_text IN ('unpaid', 'disputed');