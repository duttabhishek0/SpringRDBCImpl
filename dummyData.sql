-- Create the `users` table
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(255) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL
);

-- Insert sample data into the `users` table
INSERT INTO users (name, email, password)
VALUES
    ('Alice', 'alice@example.com', 'password123'),
    ('Bob', 'bob@example.com', 'password456'),
    ('Charlie', 'charlie@example.com', 'password789');

-- Create the `products` table
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          description TEXT,
                          price NUMERIC(10, 2) NOT NULL
);

-- Insert sample data into the `products` table
INSERT INTO products (name, description, price)
VALUES
    ('Product 1', 'This is a description for product 1', 19.99),
    ('Product 2', 'This is a description for product 2', 29.99),
    ('Product 3', 'This is a description for product 3', 39.99);

-- Create the `orders` table
CREATE TABLE orders (
                        id SERIAL PRIMARY KEY,
                        user_id INTEGER NOT NULL REFERENCES users (id),
                        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create the `order_items` table
CREATE TABLE order_items (
                             id SERIAL PRIMARY KEY,
                             order_id INTEGER NOT NULL REFERENCES orders (id),
                             product_id INTEGER NOT NULL REFERENCES products (id),
                             quantity INTEGER NOT NULL DEFAULT 1,
                             price NUMERIC(10, 2) NOT NULL
);

-- Insert sample data into the `orders` table
INSERT INTO orders (user_id) VALUES (1), (2), (3);

-- Insert sample data into the `order_items` table
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
    (1, 1, 2, 39.98),
    (1, 2, 1, 29.99),
    (2, 2, 3, 89.97),
    (3, 1, 1, 19.99),
    (3, 3, 2, 79.98);
