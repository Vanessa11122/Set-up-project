

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(250) NOT NULL UNIQUE,
    password VARCHAR(250) NOT NULL
);

CREATE TABLE todos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content VARCHAR(100),
    due DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE destinations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    country VARCHAR(255),
    description TEXT
) ENGINE=InnoDB;


CREATE TABLE trip_budgets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    category ENUM('hotel','transport','sightseeing','restaurant') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (trip_id) REFERENCES trips(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE hotels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    name VARCHAR(255),
    price_per_night DECIMAL(10,2),
    nights INT,
    FOREIGN KEY (trip_id) REFERENCES trips(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE transports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    type ENUM('flight','train','car','bus') NOT NULL,
    provider VARCHAR(255),
    price DECIMAL(10,2),
    FOREIGN KEY (trip_id) REFERENCES trips(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE sights (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    name VARCHAR(255),
    entrance_fee DECIMAL(10,2),
    visit_date DATE,
    FOREIGN KEY (trip_id) REFERENCES trips(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,
    name VARCHAR(255),
    estimated_cost DECIMAL(10,2),
    visit_date DATE,
    FOREIGN KEY (trip_id) REFERENCES trips(id) ON DELETE CASCADE
) ENGINE=InnoDB;


INSERT INTO destinations (name, country) VALUES
('Paris','Frankreich'),
('Rom','Italien'),
('Berlin','Deutschland'),
('Madrid','Spanien'),
('London','Vereinigtes Königreich'),
('Wien','Österreich'),
('Prag','Tschechien'),
('Amsterdam','Niederlande'),
('Lissabon','Portugal'),
('Budapest','Ungarn');

-- HOTELS (mehrere Optionen pro Trip / 20)
INSERT INTO hotels (trip_id, name, price_per_night, nights) VALUES
(1,'Paris Budget Hotel',90,6),
(1,'Paris Luxury Stay',180,6),
(2,'Rome City Inn',95,5),
(2,'Rome Boutique Hotel',140,5),
(3,'Berlin Hostel',45,4),
(3,'Berlin Business Hotel',120,4),
(4,'Madrid Central',100,7),
(4,'Madrid Palace Hotel',170,7),
(5,'London Economy',110,5),
(5,'London Premium',220,5),
(6,'Vienna Guesthouse',70,5),
(6,'Vienna Grand',160,5),
(7,'Prague Pension',60,4),
(7,'Prague Riverside Hotel',130,4),
(8,'Amsterdam Budget',95,5),
(8,'Amsterdam Canal Hotel',190,5),
(9,'Lisbon Hostel',50,6),
(9,'Lisbon Ocean View',150,6),
(10,'Budapest Budget',65,5),
(10,'Budapest Spa Hotel',140,5);

-- TRANSPORTS (mehrere Optionen / 20)
INSERT INTO transports (trip_id, type, provider, price) VALUES
(1,'flight','Air France',350),
(1,'train','SNCF',120),
(2,'flight','Lufthansa',280),
(2,'train','Trenitalia',90),
(3,'train','DB',120),
(3,'bus','Flixbus',45),
(4,'flight','Iberia',300),
(4,'bus','ALSA',60),
(5,'flight','British Airways',400),
(5,'train','Eurostar',250),
(6,'train','ÖBB',90),
(6,'car','RentalCars',200),
(7,'bus','RegioJet',40),
(7,'train','ČD',60),
(8,'flight','KLM',320),
(8,'train','NS',50),
(9,'flight','TAP',260),
(9,'bus','Rede Expressos',55),
(10,'train','MÁV',70),
(10,'bus','Volánbusz',35);

-- SIGHTS (mehrere Optionen / 20)
INSERT INTO sights (trip_id, name, entrance_fee, visit_date) VALUES
(1,'Eiffelturm',25,'2026-04-02'),
(1,'Montmartre',0,'2026-04-03'),
(2,'Kolosseum',18,'2026-05-11'),
(2,'Vatikanische Museen',20,'2026-05-12'),
(3,'Brandenburger Tor',0,'2026-06-02'),
(3,'Reichstag',0,'2026-06-03'),
(4,'Prado Museum',15,'2026-06-12'),
(4,'Royal Palace',14,'2026-06-13'),
(5,'London Eye',30,'2026-07-02'),
(5,'British Museum',0,'2026-07-03'),
(6,'Schloss Schönbrunn',22,'2026-07-16'),
(6,'Stephansdom',6,'2026-07-17'),
(7,'Karlsbrücke',0,'2026-08-02'),
(7,'Prager Burg',16,'2026-08-03'),
(8,'Anne Frank Haus',16,'2026-08-11'),
(8,'Rijksmuseum',20,'2026-08-12'),
(9,'Torre de Belém',8,'2026-09-02'),
(9,'Mosteiro dos Jerónimos',10,'2026-09-03'),
(10,'Parlament',10,'2026-09-16'),
(10,'Thermalbad Széchenyi',20,'2026-09-17');

-- RESTAURANTS (mehrere Optionen / 20)
INSERT INTO restaurants (trip_id, name, estimated_cost, visit_date) VALUES
(1,'Le Bistro',45,'2026-04-02'),
(1,'Street Crepes',15,'2026-04-03'),
(2,'La Trattoria',40,'2026-05-11'),
(2,'Pizza al Taglio',12,'2026-05-12'),
(3,'Curry 36',15,'2026-06-02'),
(3,'Burger Lokal',18,'2026-06-03'),
(4,'Tapas Bar',30,'2026-06-12'),
(4,'Mercado Food Hall',20,'2026-06-13'),
(5,'Pub Central',35,'2026-07-02'),
(5,'Fish & Chips Shop',18,'2026-07-03'),
(6,'Gasthaus Wien',28,'2026-07-16'),
(6,'Cafe Central',22,'2026-07-17'),
(7,'Prague Grill',22,'2026-08-02'),
(7,'Local Dumplings',14,'2026-08-03'),
(8,'Canal Cafe',32,'2026-08-11'),
(8,'Street Fries',10,'2026-08-12'),
(9,'Seafood House',38,'2026-09-02'),
(9,'Pasteis de Nata Cafe',8,'2026-09-03'),
(10,'Hungarian Bistro',25,'2026-09-16'),
(10,'Goulash Stand',12,'2026-09-17');


