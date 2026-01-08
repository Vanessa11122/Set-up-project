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

CREATE TABLE trips (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE,
    total_budget DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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



