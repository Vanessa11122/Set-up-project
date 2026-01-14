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
    land VARCHAR(100) NOT NULL,
    sterne INT DEFAULT 3,
    adresse VARCHAR(255),
    preis_pro_nacht DECIMAL(10, 2),
    FOREIGN KEY (reiseziel_id) REFERENCES reiseziele(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reiseziel_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    land VARCHAR(100) NOT NULL,
    kueche_typ VARCHAR(100),
    preis_niveau ENUM('€', '€€', '€€€', '€€€€'),
    bewertung DECIMAL(2, 1),
    FOREIGN KEY (reiseziel_id) REFERENCES reiseziele(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE sehenswuerdigkeiten (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    reiseziel_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    land VARCHAR(100) NOT NULL,
    beschreibung VARCHAR(255),
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
(19, 'Reykjavík', 'Frankreich', 'Nördlichste Hauptstadt, Tor zur Natur.'),
(20, 'Venedig', 'Italien', 'Einzigartige Lagunenstadt ohne Autos.'),
(21, 'Florenz', 'Italien', 'historische Stadt'),
(22, 'Nizza', 'Frankreich', 'Stadt am Meer');

-- 5. DATEN IN 'hotels' EINFÜGEN (Hier ist 'reiseziel_id' der Fremdschlüssel)
INSERT INTO hotels (reiseziel_id, name, sterne, preis_pro_nacht) VALUES
(1, 'Eiffel Rivera', 4, 185.00, 'Frankreich'), (1, 'Mercure gare de Lyon', 3, 90.00, 'Frankreich')
(2, 'Brandenburger Hof', 5, 220.00, 'Deutschland'), (2, 'Jugendherberge Berlin', 2, 40.00, 'Deutschland')
(3, 'Colosseo Suites', 4, 160.00, 'Italien'), (3, 'Hotel Marina di Paorelli', 4, 120.00, 'Italien')
(4, 'Madrid Central', 3, 110.00, 'Spanien'), (4, 'Holiday inn Madrid', 2, 100.00, 'Spanien')
(5, 'Hotel Sacher', 5, 450.00, 'Österreich'), (5, 'Hotel zum alten Rössle', 4, 170.00, 'Österreich')
(6, 'Prague Old Town', 4, 95.00, 'Tschechien'), (6, 'Hotel Karlova Prag', 5, 84.00, 'Tschechien')
(7, 'Alfama Blue', 3, 120.00, 'Portugal'), (7, 'Suites do Marque', 5, 320.00, 'Portugal')
(8, 'Canal House', 4, 210.00, 'Niederlande'), (8, 'Hotel sevenseven', 5, 340.00, 'Niederlande')
(9, 'The Thames View', 5, 350.00, 'UK'), (9, 'Grand hotel Soho', 4, 210.00, 'UK')
(10, 'Vasa Lodge', 4, 180.00, 'Schweden'), (10, 'hotel Frantz', 3, 130.00, 'Schweden')
(11, 'Acropolis Inn', 3, 85.00, 'Griechenland'), (11, 'Hotel Athena', 5, 340.00, 'Griechenland')
(12, 'Danube Grand', 4, 130.00, 'Ungarn'), (12, 'three corners avenue', 4, 320.00, 'Ungarn')
(13, 'Nordic Stay', 4, 190.00, 'Dänemark'), (13, 'Kanal huset', 3, 150.00, 'Dänemark')
(14, 'Rambla Suites', 4, 170.00, 'Spanien'), (14, 'St. Christophers Inn', 2, 100.00, 'Spanien')
(15, 'Shinjuku Prince', 4, 240.00, 'Japan'), (15, 'Hotel Indigo', 3, 170.00, 'Japan')
(16, 'Times Square Hotel', 5, 400.00, 'USA'), (16, 'Sheraton Brooklyn', 3, 200.00, 'USA')
(17, 'Table Mountain View', 4, 150.00, 'Südafrika'), (17, 'Taj cape town', 5, 130.00, 'Südafrika')
(18, 'Harbour Lodge', 5, 320.00, 'Australien'), (18, 'View sidney', 1, 123.00, 'Australien')
(19, 'Aurora Guesthouse', 3, 160.00, 'Island'), (19, 'Hotel Borg', 5, 300.00, 'Island')
(20, 'Laguna Palace', 4, 280.00, 'Italien'), (20, 'Hotel Torretta', 3, 200.00, 'Italien')



INSERT INTO restaurants (reiseziel_id, name, kueche_typ, preis_niveau, bewertung, land) VALUES
-- Reiseziel 1 – Frankreich
(1, 'Chez Marie', 'Französisch', '€€€', 4.4, 'Frankreich'),
(1, 'Café Parisien', 'Französisch', '€€', 4.2, 'Frankreich'),
(1, 'Le Bistro', 'Französisch', '€€€', 4.5, 'Frankreich'),

-- Reiseziel 2 – Deutschland
(2, 'Berlin Döner', 'Imbiss', '€', 4.3, 'Deutschland'),
(2, 'Street Bites', 'Fast Food', '€', 4.1, 'Deutschland'),
(2, 'Curry 36', 'Imbiss', '€', 4.2, 'Deutschland'),

-- Reiseziel 3 – Italien
(3, 'Trattoria Roma', 'Italienisch', '€€', 4.6, 'Italien'),
(3, 'Pasta Fresca', 'Italienisch', '€€€', 4.7, 'Italien'),
(3, 'Mamma Mia', 'Italienisch', '€€', 4.8, 'Italien'),

-- Reiseziel 4 – Spanien
(4, 'El Toro', 'Spanisch', '€€€', 4.5, 'Spanien'),
(4, 'Casa Tapas', 'Spanisch', '€€', 4.4, 'Spanien'),
(4, 'Tapas Bar', 'Spanisch', '€€', 4.6, 'Spanien'),

-- Reiseziel 5 – Österreich
(5, 'Gasthaus Mozart', 'Österreichisch', '€€', 4.3, 'Österreich'),
(5, 'Wiener Stube', 'Österreichisch', '€€€', 4.6, 'Österreich'),

-- Reiseziel 6 – Tschechien
(6, 'Prague Cellar', 'Böhmisch', '€€', 4.3, 'Tschechien'),
(6, 'Old Town Brewery', 'Tschechisch', '€€', 4.5, 'Tschechien'),
(6, 'U Fleků', 'Böhmisch', '€€', 4.4, 'Tschechien'),

-- Reiseziel 7 – Portugal
(7, 'Lisboa Seafood', 'Portugiesisch', '€€€', 4.7, 'Portugal'),
(7, 'Algarve Taste', 'Portugiesisch', '€€', 4.4, 'Portugal'),
(7, 'Bacalhau Grill', 'Portugiesisch', '€€€', 4.6, 'Portugal'),

-- Reiseziel 8 – Niederlande
(8, 'Dutch Delight', 'Holländisch', '€€', 4.2, 'Niederlande'),
(8, 'Canal Brunch', 'International', '€€', 4.3, 'Niederlande'),
(8, 'Pancake House', 'Holländisch', '€€', 4.3, 'Niederlande'),

-- Reiseziel 9 – UK
(9, 'The Crown', 'Britisch', '€€', 4.2, 'UK'),
(9, 'Fish & Chips Co.', 'Britisch', '€', 4.1, 'UK'),
(9, 'The Pub', 'Britisch', '€€', 4.1, 'UK'),

-- Reiseziel 10 – Schweden
(10, 'Nordic Bites', 'Schwedisch', '€€', 4.4, 'Schweden'),
(10, 'Stockholm Kitchen', 'Skandinavisch', '€€€', 4.6, 'Schweden'),
(10, 'Meatball Shop', 'Schwedisch', '€€', 4.5, 'Schweden'),

-- Reiseziel 11 – Griechenland
(11, 'Athena Grill', 'Griechisch', '€€', 4.6, 'Griechenland'),
(11, 'Santorini Taverna', 'Griechisch', '€€€', 4.8, 'Griechenland'),
(11, 'Olympos', 'Griechisch', '€€', 4.7, 'Griechenland'),

-- Reiseziel 12 – Ungarn
(12, 'Paprika Haus', 'Ungarisch', '€€', 4.3, 'Ungarn'),
(12, 'Danube Kitchen', 'Ungarisch', '€€€', 4.5, 'Ungarn'),
(12, 'Gulasch Bistro', 'Ungarisch', '€€', 4.4, 'Ungarn'),

-- Reiseziel 13 – Dänemark
(13, 'Nordic Table', 'Dänisch', '€€€', 4.5, 'Dänemark'),
(13, 'Copenhagen Eatery', 'Skandinavisch', '€€€', 4.7, 'Dänemark'),
(13, 'Hygge Kitchen', 'Dänisch', '€€€', 4.6, 'Dänemark'),

-- Reiseziel 14 – Spanien
(14, 'Valencia Rice', 'Spanisch', '€€€', 4.6, 'Spanien'),
(14, 'Costa Paella', 'Spanisch', '€€', 4.4, 'Spanien'),
(14, 'Paella Place', 'Spanisch', '€€€', 4.5, 'Spanien'),

-- Reiseziel 15 – Italien
(15, 'Tokyo Ramen', 'Japanisch', '€€', 4.6, 'Japan'),
(15, 'Sakura Fine Dining', 'Japanisch', '€€€€', 4.9, 'Japan'),
(15, 'Sushi Zen', 'Japanisch', '€€€€', 4.9, 'Japan'),

-- Reiseziel 16 – USA
(16, 'Burger Joint', 'Amerikanisch', '€', 4.4, 'USA'),
(16, 'Route 66 Diner', 'Amerikanisch', '€€', 4.5, 'USA'),
(16, 'Joe’s Pizza', 'Amerikanisch', '€', 4.7, 'USA'),

-- Reiseziel 17 – Südafrika
(17, 'Cape Town Braai', 'Südafrikanisch', '€€€', 4.5, 'Südafrika'),
(17, 'Savanna Kitchen', 'Afrikanisch', '€€', 4.3, 'Südafrika'),
(17, 'Safari Grill', 'Südafrikanisch', '€€€', 4.4, 'Südafrika'),

-- Reiseziel 18 – Australien
(18, 'City Lounge', 'Modern', '€€€', 4.3, 'Australien'),
(18, 'Urban Plate', 'Fusion', '€€€', 4.4, 'Australien'),
(18, 'Opera Cafe', 'Modern', '€€€', 4.2, 'Australien'),

-- Reiseziel 19 – Island
(19, 'Nordic Fire', 'Isländisch', '€€€', 4.6, 'Island'),
(19, 'Reykjavik Bistro', 'Nordisch', '€€€', 4.5, 'Island'),
(19, 'Lava Soup', 'Isländisch', '€€€', 4.5, 'Island'),

-- Reiseziel 20 – Italien
(20, 'Veneto Cucina', 'Italienisch', '€€€', 4.4, 'Italien'),
(20, 'Canal Grande', 'Italienisch', '€€', 4.3, 'Italien'),
(20, 'Trattoria Canal', 'Italienisch', '€€€', 4.3, 'Italien');


INSERT INTO sehenswuerdigkeiten (reiseziel_id, name, beschreibung) VALUES
-- 1 Paris
(1, 'Eiffelturm', 'Wahrzeichen von Paris mit Aussichtsplattform.'),
(1, 'Louvre', 'Berühmtes Kunstmuseum mit der Mona Lisa.'),
(1, 'Notre-Dame', 'Gotische Kathedrale auf der Île de la Cité.'),

-- 2 Berlin
(2, 'Brandenburger Tor', 'Historisches Symbol der deutschen Einheit.'),
(2, 'Berliner Mauer', 'Überreste der ehemaligen innerdeutschen Grenze.'),
(2, 'Museumsinsel', 'UNESCO-Welterbe mit mehreren Museen.'),

-- 3 Rom
(3, 'Kolosseum', 'Antikes Amphitheater aus der Römerzeit.'),
(3, 'Forum Romanum', 'Politisches Zentrum des antiken Roms.'),
(3, 'Vatikan', 'Kleinstaat mit Petersdom und Sixtinischer Kapelle.'),

-- 4 Madrid
(4, 'Prado Museum', 'Eines der bedeutendsten Kunstmuseen Europas.'),
(4, 'Plaza Mayor', 'Historischer Hauptplatz im Stadtzentrum.'),
(4, 'Königspalast', 'Offizielle Residenz der spanischen Könige.'),

-- 5 Wien
(5, 'Schloss Schönbrunn', 'Ehemalige Sommerresidenz der Habsburger.'),
(5, 'Stephansdom', 'Gotischer Dom im Herzen Wiens.'),
(5, 'Belvedere', 'Barockschloss mit Kunstsammlung.'),

-- 6 Prag
(6, 'Karlsbrücke', 'Berühmte Brücke mit Heiligenstatuen.'),
(6, 'Prager Burg', 'Größte geschlossene Burganlage der Welt.'),
(6, 'Altstädter Ring', 'Historischer Marktplatz mit Rathausuhr.'),

-- 7 Lissabon
(7, 'Torre de Belém', 'Historischer Verteidigungsturm am Tejo.'),
(7, 'Mosteiro dos Jerónimos', 'Kloster im manuelinischen Stil.'),
(7, 'Alfama', 'Ältestes Stadtviertel mit engen Gassen.'),

-- 8 Amsterdam
(8, 'Anne-Frank-Haus', 'Wohnhaus von Anne Frank im Zweiten Weltkrieg.'),
(8, 'Rijksmuseum', 'Nationalmuseum der Niederlande.'),
(8, 'Grachten', 'Typische Wasserkanäle der Stadt.'),

-- 9 London
(9, 'Big Ben', 'Berühmter Glockenturm am Parlament.'),
(9, 'Tower of London', 'Historische Festung an der Themse.'),
(9, 'Buckingham Palace', 'Offizielle Residenz des Königs.'),

-- 10 Stockholm
(10, 'Gamla Stan', 'Historische Altstadt Stockholms.'),
(10, 'Vasa-Museum', 'Museum mit einem Kriegsschiff aus dem 17. Jh.'),
(10, 'Schloss Drottningholm', 'Königliches Schloss mit Parkanlage.'),

-- 11 Athen
(11, 'Akropolis', 'Antike Tempelanlage auf einem Hügel.'),
(11, 'Parthenon', 'Berühmter Tempel der Athena.'),
(11, 'Agora', 'Zentraler Platz des antiken Athens.'),

-- 12 Budapest
(12, 'Parlament', 'Neogotisches Parlamentsgebäude an der Donau.'),
(12, 'Kettenbrücke', 'Berühmte Brücke zwischen Buda und Pest.'),
(12, 'Thermalbad Széchenyi', 'Großes historisches Thermalbad.'),

-- 13 Kopenhagen
(13, 'Nyhavn', 'Hafen mit bunten Häusern.'),
(13, 'Kleine Meerjungfrau', 'Berühmte Bronzestatue am Wasser.'),
(13, 'Tivoli', 'Historischer Vergnügungspark.'),

-- 14 Barcelona
(14, 'Sagrada Família', 'Unvollendete Basilika von Gaudí.'),
(14, 'Park Güell', 'Bunter Park mit Mosaiken.'),
(14, 'La Rambla', 'Belebte Flaniermeile.'),

-- 15 Tokio
(15, 'Shibuya Crossing', 'Weltbekannte Kreuzung.'),
(15, 'Meiji-Schrein', 'Shinto-Schrein im Stadtzentrum.'),
(15, 'Tokyo Tower', 'Aussichtsturm mit Stadtblick.'),

-- 16 New York
(16, 'Freiheitsstatue', 'Symbol für Freiheit und Einwanderung.'),
(16, 'Central Park', 'Großer Stadtpark in Manhattan.'),
(16, 'Times Square', 'Belebter Platz mit Leuchtreklamen.'),

-- 17 Kapstadt
(17, 'Tafelberg', 'Markanter Berg mit Seilbahn.'),
(17, 'Kap der Guten Hoffnung', 'Berühmte Landspitze.'),
(17, 'V&A Waterfront', 'Hafenviertel mit Shops und Restaurants.'),

-- 18 Sydney
(18, 'Opera House', 'Ikonisches Opernhaus am Hafen.'),
(18, 'Harbour Bridge', 'Große Stahlbogenbrücke.'),
(18, 'Bondi Beach', 'Beliebter Stadtstrand.'),

-- 19 Reykjavík
(19, 'Hallgrímskirkja', 'Moderne Kirche mit Aussichtsturm.'),
(19, 'Harpa', 'Konzerthaus mit Glasfassade.'),
(19, 'Sun Voyager', 'Skulptur am Meer.'),

-- 20 Venedig
(20, 'Markusplatz', 'Zentraler Platz von Venedig.'),
(20, 'Dogenpalast', 'Ehemaliger Regierungssitz.'),
(20, 'Canal Grande', 'Hauptwasserstraße der Stadt.');

