CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address TEXT,
    join_date DATE
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    isbn VARCHAR(13),
    price DECIMAL(10, 2),
    available_copies INT
);
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    book_id INT NOT NULL,
    sale_date DATE,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    sale_id INT NOT NULL,
    payment_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id)
);
  
INSERT INTO Customers (name, email, phone, address, join_date)
VALUES
('Alice Brown', 'alice@example.com', '1234567890', '123 Maple St', '2024-01-10'),
('Bob Green', 'bob@example.com', '0987654321', '456 Birch St', '2024-02-20');
INSERT INTO Books (title, author, genre, isbn, price, available_copies)
VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', '9780743273565', 10.99, 10),
('1984', 'George Orwell', 'Dystopian', '9780451524935', 8.99, 5),
('Sapiens', 'Yuval Noah Harari', 'History', '9780062316097', 14.99, 7);
INSERT INTO Sales (customer_id, book_id, sale_date, quantity, total_price)
VALUES
(1, 1, '2024-12-01', 2, 21.98),
(2, 2, '2024-12-03', 1, 8.99);
INSERT INTO Payments (sale_id, payment_date, amount)
VALUES
(1, '2024-12-01', 21.98),
(2, '2024-12-03', 8.99);

Select* from customers
where join_date >= DATEADD(MONTH, -6, GETDATE());

Select* from books
where available_copies < 3;

Select SUM(total_price) As total_revenue From Sales;

SELECT b.title, s.quantity, s.sale_date
FROM Sales s
JOIN Books b ON s.book_id = b.book_id
JOIN Customers c ON s.customer_id = c.customer_id
WHERE c.name = 'Alice Brown';

SELECT b.title, SUM(s.quantity) AS total_sold
FROM Sales s
JOIN Books b ON s.book_id = b.book_id
GROUP BY b.title
ORDER BY total_sold DESC
LIMIT 1;

SELECT c.name, SUM(s.total_price) AS total_spent
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.name
HAVING SUM(s.total_price) > 20;