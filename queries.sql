


CREATE TABLE users (
  user_id int primary key,
  name varchar(50),
  email varchar(50) unique,
  password varchar(30),
  phoneNumber int ,
  role varchar(20) check (role in ('ADMIN','CUSTOMER'))  
)

CREATE TABLE vehicles (
  vehicle_id int primary key,
  name varchar(50), 
  type varchar(10) check (type in('car','bike','truck')),
  model varchar(50),
  registration_number varchar(50) unique,
  rental_price decimal(10,2),
 status varchar(20) check(status in ('available','rented','maintenance'))
)

CREATE TABLE bookings (
  booking_id int primary key,
  user_id int references users(user_id),
  vehicle_id int references vehicles(vehicle_id),
  start_date date,
  end_date date,
  status varchar(20) check (status in('completed','confirmed','pending')),
  total_cost decimal(10,2)
)

INSERT INTO users (user_id, name, email, password, phoneNumber, role)
VALUES
(1, 'Rahim Uddin', 'rahim@gmail.com', 'rahim123', 1711111111, 'ADMIN'),
(2, 'Karim Ahmed', 'karim@gmail.com', 'karim123', 1722222222, 'CUSTOMER'),
(3, 'Sara Khan', 'sara@gmail.com', 'sara123', 1733333333, 'CUSTOMER'),
(4, 'John Smith', 'john@gmail.com', 'john123', 1744444444, 'CUSTOMER'),
(5, 'Emma Brown', 'emma@gmail.com', 'emma123', 1755555555, 'ADMIN');



INSERT INTO vehicles (
  vehicle_id,
  name,
  type,
  model,
  registration_number,
  rental_price,
  status
)
VALUES
(1, 'Toyota Corolla', 'car', '2021', 'DHA-1234', 3500.00, 'available'),
(2, 'Honda Civic', 'car', '2022', 'DHA-5678', 4500.00, 'rented'),
(3, 'Yamaha R15', 'bike', '2020', 'CTG-4321', 1500.00, 'available'),
(4, 'Suzuki Gixxer', 'bike', '2019', 'SYL-8765', 1300.00, 'maintenance'),
(5, 'Tata Ace', 'truck', '2018', 'RAJ-9999', 6000.00, 'available'),
(6, 'Tata Ace1', 'truck', '2018', 'RAJ-99999', 6000.00, 'available'),
(7, 'Tata Ace1', 'truck', '2018', 'RAJ-999990', 6000.00, 'available');

INSERT INTO bookings (
  booking_id,
  user_id,
  vehicle_id,
  start_date,
  end_date,
  status,
  total_cost
)
VALUES
(1, 2, 1, '2023-06-01', '2023-06-03', 'completed', 7000.00),
(2, 3, 3, '2023-06-05', '2023-06-06', 'confirmed', 1500.00),
(3, 4, 2, '2023-06-10', '2023-06-12', 'pending', 9000.00),
(4, 5, 5, '2023-06-15', '2023-06-18', 'completed', 18000.00),
(5, 2, 4, '2023-06-20', '2023-06-21', 'confirmed', 1300.00),
(6, 2, 2, '2023-06-20', '2023-06-21', 'confirmed', 1300.00);


-- query 1 solution

SELECT booking_id, (users.name) as customer_name,(vehicles.name)as vehicle_name,start_date,end_date,(bookings.status) as status
FROM bookings
JOIN users
  ON bookings.user_id = users.user_id
JOIN vehicles
  ON bookings.vehicle_id = vehicles.vehicle_id;

-- query 2 solution

SELECT *
FROM vehicles as v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings as b
  WHERE b.vehicle_id = v.vehicle_id
);

-- query 3 solution

SELECT * FROM vehicles as v WHERE status='available' AND type='car';

-- query 4 solution

SELECT v.name as vehicle_name,count(*) as total_bookings FROM bookings as b JOIN vehicles as v on b.vehicle_id=v.vehicle_id
  GROUP BY v.name HAVING count(*)>2 


