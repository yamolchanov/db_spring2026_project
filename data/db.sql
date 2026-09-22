CREATE TABLE departments (
    dept_id     SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    region      VARCHAR(255),
    address     VARCHAR(255)
);

CREATE TABLE persons (
    person_id       SERIAL PRIMARY KEY,
    first_name      VARCHAR(255) NOT NULL,
    last_name       VARCHAR(255) NOT NULL,
    birth_date      DATE NOT NULL,
    passport_series VARCHAR(10) UNIQUE NOT NULL CHECK (passport_series ~ '^\d{10}$'),
    address         VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL CHECK (phone ~ '^\+7\d{10}$')
);

CREATE TABLE driving_license (
    person_id   INTEGER NOT NULL REFERENCES persons(person_id),
    license_id  SERIAL PRIMARY KEY,
    expiry_date DATE NOT NULL,
    categories  VARCHAR(50) NOT NULL,
    status      VARCHAR(20) NOT NULL CHECK (status IN ('active', 'expired', 'suspended'))
);

CREATE TABLE legal_entity (
    entity_id   SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    address     VARCHAR(255) NOT NULL,
    phone       VARCHAR(20) NOT NULL CHECK (phone ~ '^\+7\d{10}$')
);

CREATE TABLE vehicle (
    vehicle_id  SERIAL PRIMARY KEY,
    vin         VARCHAR(17) NOT NULL UNIQUE,
    brand       VARCHAR(100),
    model       VARCHAR(100),
    year        INTEGER NOT NULL,
    color       VARCHAR(50) NOT NULL,
    category    VARCHAR(50) NOT NULL,
    owner_id    INTEGER NOT NULL REFERENCES persons(person_id),
    drivers_id  INTEGER REFERENCES persons(person_id)
);

CREATE TABLE registration (
    reg_id      SERIAL PRIMARY KEY,
    vehicle_id  INTEGER NOT NULL REFERENCES vehicle(vehicle_id),
    number      VARCHAR(20) NOT NULL UNIQUE,
    dept_id     INTEGER NOT NULL REFERENCES departments(dept_id)
);

CREATE TABLE officers (
    officer_id  SERIAL PRIMARY KEY,
    rank        VARCHAR(100) NOT NULL,
    badge_num   INTEGER NOT NULL UNIQUE,
    dept_id     INTEGER REFERENCES departments(dept_id),
    vehicle_id  INTEGER REFERENCES vehicle(vehicle_id)
);

CREATE TABLE article (
    article_id  SERIAL PRIMARY KEY,
    code        INTEGER NOT NULL UNIQUE,
    desc_text VARCHAR(100) NOT NULL,
    max_fine    INTEGER NOT NULL,
    min_fine    INTEGER NOT NULL,
    CHECK (min_fine <= max_fine)
);

CREATE TABLE violation (
    violation_id    SERIAL PRIMARY KEY,
    violation_dt    TIMESTAMPTZ NOT NULL,
    location_text        VARCHAR(255),
    article_id      INTEGER REFERENCES article(article_id),
    vehicle_id      INTEGER REFERENCES vehicle(vehicle_id),
    driver_id       INTEGER NOT NULL REFERENCES persons(person_id),
    officer_id      INTEGER NOT NULL REFERENCES officers(officer_id)
);

CREATE TABLE fine (
    violation_id    INTEGER NOT NULL REFERENCES violation(violation_id),
    fine_id         SERIAL PRIMARY KEY,
    amount          INTEGER NOT NULL CHECK (amount >= 0),
    date_text            TIMESTAMPTZ,
    status_text VARCHAR(50) NOT NULL CHECK (status_text IN ('paid', 'unpaid', 'disputed'))
);