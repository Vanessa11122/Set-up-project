-- 1. ALTE TABELLEN LÖSCHEN (Um Fehler bei der Neu-Erstellung zu vermeiden

-- 2. UNABHÄNGIGE TABELLEN ERSTELLEN
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(250) NOT NULL UNIQUE,
    password VARCHAR(250) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE reiseziele (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    land VARCHAR(100) NOT NULL,
    beschreibung TEXT,
    währung VARCHAR(10) DEFAULT 'EUR'
) ENGINE=InnoDB;

-- 3. ABHÄNGIGE TABELLEN ERSTELLEN (Diese brauchen 'users' oder 'reiseziele')
CREATE TABLE todos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content VARCHAR(100),
    due DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE user_reisen (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    reiseziel_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (reiseziel_id) REFERENCES reiseziele(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE hotels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reiseziel_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    sterne INT DEFAULT 3,
    adresse VARCHAR(255),
    preis_pro_nacht DECIMAL(10, 2),
    FOREIGN KEY (reiseziel_id) REFERENCES reiseziele(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reiseziel_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    kueche_typ VARCHAR(100),
    preis_niveau ENUM('€', '€€', '€€€', '€€€€'),
    bewertung DECIMAL(2, 1),
    FOREIGN KEY (reiseziel_id) REFERENCES reiseziele(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. DATEN IN 'reiseziele' EINFÜGEN
-- WICHTIG: Die Spalte heißt 'id', NICHT 'reiseziel_id'
INSERT INTO reiseziele (id, name, land, beschreibung) VALUES
(1, 'Paris', 'Frankreich', 'Stadt der Liebe mit dem Eiffelturm.'),
(2, 'Berlin', 'Deutschland', 'Historische Hauptstadt mit viel Kultur.'),
(3, 'Rom', 'Italien', 'Die ewige Stadt mit dem Kolosseum.'),
(4, 'Madrid', 'Spanien', 'Bekannt für Kunstmuseen und Lebensfreude.'),
(5, 'Wien', 'Österreich', 'Kaiserlicher Charme und Kaffeehauskultur.'),
(6, 'Prag', 'Tschechien', 'Die goldene Stadt an der Moldau.'),
(7, 'Lissabon', 'Portugal', 'Hügelige Stadt an der Atlantikküste.'),
(8, 'Amsterdam', 'Niederlande', 'Berühmt für Grachten und Fahrräder.'),
(9, 'London', 'Großbritannien', 'Metropole an der Themse mit Weltruhm.'),
(10, 'Stockholm', 'Schweden', 'Venedig des Nordens auf 14 Inseln.'),
(11, 'Athen', 'Griechenland', 'Wiege der Demokratie und Antike.'),
(12, 'Budapest', 'Ungarn', 'Perle an der Donau mit Thermalbädern.'),
(13, 'Kopenhagen', 'Dänemark', 'Modernes Design und Hygge-Lebensgefühl.'),
(14, 'Barcelona', 'Spanien', 'Gaudí-Architektur und Mittelmeerflair.'),
(15, 'Tokio', 'Japan', 'Futuristische Megacity und Tradition.'),
(16, 'New York', 'USA', 'Die Stadt, die niemals schläft.'),
(17, 'Kapstadt', 'Südafrika', 'Schönheit am Fuße des Tafelbergs.'),
(18, 'Sydney', 'Australien', 'Hafenmetropole mit dem Opera House.'),
(19, 'Reykjavík', 'Island', 'Nördlichste Hauptstadt, Tor zur Natur.'),
(20, 'Venedig', 'Italien', 'Einzigartige Lagunenstadt ohne Autos.');

-- 5. DATEN IN 'hotels' EINFÜGEN (Hier ist 'reiseziel_id' der Fremdschlüssel)
INSERT INTO hotels (reiseziel_id, name, sterne, preis_pro_nacht) VALUES
(1, 'Eiffel Rivera', 4, 185.00), (1, 'Mercure gare de Lyon', 3, 90.00)
(2, 'Brandenburger Hof', 5, 220.00), (2, 'Jugendherberge Berlin, 2, 40.00)
(3, 'Colosseo Suites', 4, 160.00), (3, 'Hotel Marina di Paorelli', 4, 120.00)
(4, 'Madrid Central', 3, 110.00), (4, 'Holiday inn Madrid', 2, 100.00)
(5, 'Hotel Sacher', 5, 450.00), (5, 'Hotel zum alten Rössle', 4, 170.00)
(6, 'Prague Old Town', 4, 95.00), (6, 'Hotel Karlova Prag', 5, 84.00)
(7, 'Alfama Blue', 3, 120.00), (7, 'Suites do Marque', 5, 320.00)
(8, 'Canal House', 4, 210.00), (8, 'Hotel sevenseven', 5, 340.00)
(9, 'The Thames View', 5, 350.00), (9, 'Grand hotel Soho', 4, 210.00)
(10, 'Vasa Lodge', 4, 180.00), (10, 'hotel Frantz', 3, 130.00)
(11, 'Acropolis Inn', 3, 85.00), (11, 'Hotel Athena', 5, 340.00)
(12, 'Danube Grand', 4, 130.00), (12, 'three corners avenue', 4, 320.00)
(13, 'Nordic Stay', 4, 190.00), (13, 'Kanal huset', 3, 150.00)
(14, 'Rambla Suites', 4, 170.00), (14, 'St. Christophers Inn', 2, 100.00)
(15, 'Shinjuku Prince', 4, 240.00), (15, 'Hotel Indigo', 3, 170.00)
(16, 'Times Square Hotel', 5, 400.00), (16, 'Sheraton Brooklyn', 3, 200.00
(17, 'Table Mountain View', 4, 150.00), (17,'Taj cape town', 5, 130.00)
(18, 'Harbour Lodge', 5, 320.00), (18, 'View sidney', 1, 123.00)
(19, 'Aurora Guesthouse', 3, 160.00), (19, 'Hotel Borg', 5, 300.00)
(20, 'Laguna Palace', 4, 280.00), (20, 'Hotel Torretta, 3, 200.00) 

-- 6. DATEN IN 'restaurants' EINFÜGEN
INSERT INTO restaurants (reiseziel_id, name, kueche_typ, preis_niveau, bewertung) VALUES
(1, 'Le Bistro', 'Französisch', '€€€', 4.5), (2, 'Curry 36', 'Imbiss', '€', 4.2),
(3, 'Mamma Mia', 'Italienisch', '€€', 4.8), (4, 'Tapas Bar', 'Spanisch', '€€', 4.6),
(5, 'Figlmüller', 'Österreichisch', '€€€', 4.7), (6, 'U Fleků', 'Böhmisch', '€€', 4.4),
(7, 'Bacalhau Grill', 'Portugiesisch', '€€€', 4.6), (8, 'Pancake House', 'Holländisch', '€€', 4.3),
(9, 'The Pub', 'Britisch', '€€', 4.1), (10, 'Meatball Shop', 'Schwedisch', '€€', 4.5),
(11, 'Olympos', 'Griechisch', '€€', 4.7), (12, 'Gulasch Bistro', 'Ungarisch', '€€', 4.4),
(13, 'Hygge Kitchen', 'Dänisch', '€€€', 4.6), (14, 'Paella Place', 'Spanisch', '€€€', 4.5),
(15, 'Sushi Zen', 'Japanisch', '€€€€', 4.9), (16, 'Joe’s Pizza', 'Amerikanisch', '€', 4.7),
(17, 'Safari Grill', 'Südafrikanisch', '€€€', 4.4), (18, 'Opera Cafe', 'Modern', '€€€', 4.2),
(19, 'Lava Soup', 'Isländisch', '€€€', 4.5), (20, 'Trattoria Canal', 'Italienisch', '€€€', 4.3);
