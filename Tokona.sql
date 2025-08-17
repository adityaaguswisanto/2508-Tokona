-- Create Table User --
DROP TABLE dimension_users;
CREATE TABLE dimension_users (
    id SERIAL PRIMARY KEY,
    nik INT,
    name VARCHAR(50),
    username VARCHAR(50) NOT NULL UNIQUE,
	password TEXT NOT NULL,
	position VARCHAR(50),
	role INT,
	photo TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
SELECT * from dimension_users;

-- Create Table Attendance --
DROP TABLE fact_attendances;
CREATE TABLE fact_attendances (
    id SERIAL PRIMARY KEY,
    longitude FLOAT NOT NULL,
    latitude FLOAT NOT NULL,
    status INT NOT NULL,
    reason VARCHAR(100),
    user_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
SELECT * from fact_attendances;

-- Create Table Master Merchant --
DROP TABLE dimension_ms_merchants;
CREATE TABLE dimension_ms_merchants (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO dimension_ms_merchants (code, name, address)
VALUES
    ('M001', 'TOKO INDOJUNI', 'Jl. Merdeka No. 1, Jakarta'),
    ('M002', 'TOKO TINTIN', 'Jl. Sudirman No. 23, Bandung'),
    ('M003', 'TOKO WARASANGIT', 'Jl. Diponegoro No. 45, Surabaya');
SELECT * FROM dimension_ms_merchants;

-- Create Table Master Product --
DROP TABLE dimension_ms_products;
CREATE TABLE dimension_ms_products (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) NOT NULL,
    photo TEXT,
	name VARCHAR(50) NOT NULL,
	description VARCHAR(100) NOT NULL,
	price FLOAT NOT NULL,
	merchant_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO dimension_ms_products (code, photo, name, description, price, merchant_id)
VALUES
    ('P001', 'https://paxelmarket.co/wp-content/uploads/2022/11/WhatsApp-Image-2022-11-07-at-21.14.00-300x300.jpeg', 'Keripik Kentang Xie-xie 250mL', 'Keripik kentang renyah rasa asin gurih.', 15000, 1),
    ('P002', 'https://img.lazcdn.com/g/ff/kf/S3d96c248960145e7929e96c98df57568H.jpg_720x720q80.jpg', 'Biskuit Kelapa Ni-hao 100mL', 'Biskuit kelapa manis gurih cocok untuk camilan.', 10000, 2),
    ('P003', 'https://cdn-1.timesmedia.co.id/images/2022/04/28/Cokelat-kacang.jpg', 'Coklat Kacang Peng-you 50mL', 'Coklat dengan kacang renyah dalam kemasan kecil.', 12000, 3);
SELECT * FROM dimension_ms_products;

-- Create Table Merchant --
DROP TABLE fact_merchants;
CREATE TABLE fact_merchants (
    id SERIAL PRIMARY KEY,
    merchant_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO fact_merchants (merchant_id, user_id)
VALUES 
    (1, 2),
    (2, 3),
    (3, 2);
SELECT * FROM fact_merchants;

-- Create Table Product --
DROP TABLE fact_products;
CREATE TABLE fact_products (
    id SERIAL PRIMARY KEY,
    available INT NOT NULL,
    product_id INT NOT NULL,
    merchant_id INT NOT NULL,
    staff_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO fact_products (available, product_id, merchant_id, staff_id, user_id)
VALUES
    (0, 1, 1, 2, 1),
    (0, 1, 1, 3, 1),
    (0, 2, 1, 2, 1),
    (0, 2, 1, 3, 1),
    (0, 3, 1, 2, 1),
    (0, 3, 1, 3, 1);
SELECT * FROM fact_products;
UPDATE fact_products SET available = 0;

-- Create Table Promo --
DROP TABLE fact_promos;
CREATE TABLE fact_promos (
    id SERIAL PRIMARY KEY,
    price INT NOT NULL,
    discount INT NOT NULL,
    end_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    product_id INT NOT NULL,
    merchant_id INT NOT NULL,
    staff_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM fact_promos;