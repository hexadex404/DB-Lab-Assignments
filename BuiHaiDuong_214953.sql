--1
CREATE DATABASE db_214953

CREATE TABLE customer(
CustomerID VARCHAR(4) NOT NULL PRIMARY KEY,
Name VARCHAR(32),
Gender CHAR(1),
CHECK (Gender='F' OR Gender='M')
);

CREATE TABLE owner(
OwnerID VARCHAR(4) NOT NULL PRIMARY KEY,
Name VARCHAR(32)
);

CREATE TABLE room(
RoomID VARCHAR(4) NOT NULL PRIMARY KEY,
OwnerID VARCHAR(4),
City VARCHAR(16),
Price_per_day INT,
FOREIGN KEY (OwnerID) REFERENCES owner(OwnerID)
);

CREATE TABLE booking(
CustomerID VARCHAR(4) NOT NULL,
RoomID VARCHAR(4) NOT NULL,
Start_date DATE NOT NULL,
End_date DATE NOT NULL,
PRIMARY KEY (CustomerID, RoomID, Start_date),
FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID),
FOREIGN KEY (RoomID) REFERENCES room(roomID)
);

INSERT INTO customer VALUES
	('C1', 'Nguyen Manh', 'M'),
	('C2', 'Nguyen Minh', 'M'),
	('C3', 'Nguyen Van', 'F'),
	('C4', 'Nguyen Phuong', 'F'),
	('C5', 'Nguyen Bao', 'F');

INSERT INTO owner VALUES
	('O1', 'Tran Manh'),
	('O2', 'Tran Minh'),
	('O3', 'Tran Van'),
	('O4', 'Tran Phuong'),
	('O5', 'Tran Bao');
	
INSERT INTO room VALUES
	('R1', 'O1', 'Ha Noi', 200),
	('R2', 'O1', 'Ho Chi Minh', 300),
	('R3', 'O3', 'Ha Noi', 100),
	('R4', 'O4', 'Ho Chi Minh', 200),
	('R5', 'O5', 'Da Nang', 400);
	
INSERT INTO booking VALUES
	('C1', 'R1', '2020-10-10', '2020-10-15'),
	('C2', 'R3', '2020-12-30', '2021-01-05'),
	('C3', 'R5', '2020-1-10', '2020-1-12'),
	('C4', 'R5', '2020-1-13', '2020-1-20'),
	('C5', 'R4', '2021-5-10', '2021-5-20'),
	('C1', 'R4', '2021-8-10', '2021-8-15'),
	('C1', 'R1', '2021-10-10', '2021-10-15'),
	('C4', 'R2', '2021-10-10', '2021-10-15');

--2
SELECT OwnerID, City, COUNT(*) num_rooms
FROM room
GROUP BY city
ORDER BY num_rooms DESC;

--3
SELECT RoomID, City, Price_per_day
FROM room
WHERE RoomID NOT IN (
	SELECT RoomID
	FROM booking
	WHERE CustomerID NOT IN (
		SELECT CustomerID
		FROM customer
		WHERE Gender = 'M'
	)
);

--4
SELECT r.*
FROM room r
INNER JOIN (
  SELECT RoomID, COUNT(*) AS rent_count
  FROM booking
  GROUP BY RoomID
) b ON r.RoomID = b.RoomID
WHERE b.rent_count = (
  SELECT MAX(rent_count)
  FROM (
    SELECT COUNT(*) AS rent_count
    FROM booking
    GROUP BY RoomID
  ) AS counts
);

--5
SELECT o.OwnerID, o.Name AS OwnerName, SUM(JULIANDAY(b.End_date) - JULIANDAY(b.Start_date)) * r.Price_per_day AS Revenue
FROM owner o
INNER JOIN room r ON o.OwnerID = r.OwnerID
INNER JOIN booking b ON r.RoomID = b.RoomID
WHERE EXTRACT(YEAR FROM b.End_date) = 2021
GROUP BY o.OwnerID, o.Name
ORDER BY Revenue DESC;

--6
SELECT c.*, COUNT(b.RoomID) AS rent_count
FROM customer c
INNER JOIN booking b ON c.CustomerID = b.CustomerID
INNER JOIN (
    SELECT RoomID, MAX(Price_per_day) AS Max_Price
    FROM room
    GROUP BY RoomID
) AS max_price ON b.RoomID = max_price.RoomID
INNER JOIN room ON b.RoomID = room.RoomID
WHERE max_price.Max_Price = room.Price_per_day
GROUP BY c.CustomerID
HAVING COUNT(b.RoomID) >= 2
ORDER BY max_price.Max_Price DESC, rent_count DESC
LIMIT 1;

--7
SELECT o.*
FROM owner o
INNER JOIN room r ON o.OwnerID = r.OwnerID
WHERE r.City = 'Ha Noi'
GROUP BY o.OwnerID
HAVING COUNT(r.RoomID) = (
  SELECT MAX(room_count)
  FROM (
    SELECT COUNT(r2.RoomID) AS room_count
    FROM owner o2
    INNER JOIN room r2 ON o2.OwnerID = r2.OwnerID
    WHERE r2.City = 'Ha Noi'
    GROUP BY o2.OwnerID
  ) AS counts
);

--8
SELECT o.*
FROM owner o
LEFT JOIN (
  SELECT DISTINCT r.OwnerId
  FROM booking b
  INNER JOIN room r ON b.RoomID = r.RoomId
  WHERE b.End_date >= '2021-10-01' AND b.End_date <= '2021-12-31'
) AS t ON o.OwnerID = t.OwnerID
WHERE t.OwnerID IS NULL;

--9
SELECT r.*
FROM room r
INNER JOIN booking b ON r.RoomID = b.RoomID
INNER JOIN customer c ON b.CustomerID = c.CustomerID
WHERE c.Gender = 'M'
GROUP BY r.RoomID
HAVING COUNT(*) > 3;