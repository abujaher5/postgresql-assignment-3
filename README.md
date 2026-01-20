
# 🚗 Vehicle Rental System (PostgreSQL)
### 📌 Project Overview

The Vehicle Rental System is a PostgreSQL-based relational database project that manages users, vehicles, and bookings.
It demonstrates real-world database concepts such as primary keys, foreign keys, constraints, joins, subqueries, and aggregation.

This project is designed for learning, practice, and interview preparation.

### 🗄️ Database Information

- Database: PostgreSQL

- Type: Relational Database

- Core Concepts Used:

- Primary Key

- Foreign Key

- CHECK constraints

- JOIN

- EXISTS

- GROUP BY & HAVING

### 📋 Tables Description
#### 1️⃣ Users Table

Stores system users and their roles.
```
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(50) UNIQUE,
  password VARCHAR(30),
  phoneNumber INT,
  role VARCHAR(20) CHECK (role IN ('ADMIN','CUSTOMER'))
);
```

#### Details:

- Each user has a unique email

- Role can be ADMIN or CUSTOMER

#### 2️⃣ Vehicles Table

Stores vehicle information available for rental.

```
CREATE TABLE vehicles (
  vehicle_id INT PRIMARY KEY,
  name VARCHAR(50),
  type VARCHAR(10) CHECK (type IN ('car','bike','truck')),
  model VARCHAR(50),
  registration_number VARCHAR(50) UNIQUE,
  rental_price DECIMAL(10,2),
  status VARCHAR(20) CHECK (status IN ('available','rented','maintenance'))
);
```


#### Details:

- Registration number must be unique

- Status controls vehicle availability

#### 3️⃣ Bookings Table

Stores booking records and links users with vehicles.

```
CREATE TABLE bookings (
  booking_id INT PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  vehicle_id INT REFERENCES vehicles(vehicle_id),
  start_date DATE,
  end_date DATE,
  status VARCHAR(20) CHECK (status IN ('completed','confirmed','pending')),
  total_cost DECIMAL(10,2)
);
```


#### Details:

- Uses foreign keys for relationships

- Each booking belongs to one user and one vehicle

## 🔗 Table Relationships (ERD)
```
🔗 ERD Link (DrawSQL):https://drawsql.app/teams/rasel-5/diagrams/vehicle-rental-system
```

#### Relationship Summary:

- One-to-Many: Users → Bookings

- Many-to-One: Bookings → Vehicles

- Logical One-to-One: Each booking connects exactly one user and one vehicle

- This ERD visually represents foreign key relationships and ensures proper relational database design.

## 🧪 Sample SQL Queries
#### 1️⃣ List all bookings with user and vehicle details
```
SELECT
  booking_id,
  users.name AS customer_name,
  vehicles.name AS vehicle_name,
  start_date,
  end_date,
  bookings.status AS status
FROM bookings
JOIN users ON bookings.user_id = users.user_id
JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id;
```

### 2️⃣ Find vehicles that have never been booked
``` 
SELECT *
FROM vehicles AS v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings AS b
  WHERE b.vehicle_id = v.vehicle_id
);
```

### 3️⃣ Find all available cars

```
SELECT *
FROM vehicles
WHERE status = 'available'
AND type = 'car';
```

### 4️⃣ Find vehicles with more than 2 bookings

```
SELECT
  v.name AS vehicle_name,
  COUNT(*) AS total_bookings
FROM bookings AS b
JOIN vehicles AS v ON b.vehicle_id = v.vehicle_id
GROUP BY v.name
HAVING COUNT(*) > 2;
```

## 🚀 How to Run the Project

- Create a PostgreSQL database

- Execute the CREATE TABLE queries

- Insert sample data

- Run the SQL queries to test functionality

### 🎯 Learning Outcomes

- Designing relational tables with constraints

- Maintaining data integrity using foreign keys

- Writing JOIN, EXISTS, and aggregate queries

- Understanding real-world ERD relationships

- Improving SQL querying and database modeling skills

### 👤 Author

 **Abu Jaher**   
 MERN Developer


