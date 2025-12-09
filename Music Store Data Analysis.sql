CREATE DATABASE music_store;

USE music_store;

SELECT * FROM album2;

-- Who is the senior most employee based on job title?

SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1; 

-- Which countries have the most invoices?

SELECT billing_country, COUNT(total) FROM invoice
GROUP BY billing_country
ORDER BY COUNT(total) DESC;

-- What are top 3 values of total invoice?

SELECT total FROM invoice
ORDER BY total DESC
LIMIT 3;

-- Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoices totals. Return both the city name & sum of all invoice totals

SELECT billing_city, SUM(total) AS invoice_total FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC;

-- Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money

SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total 
FROM customer c
JOIN invoice i ON
c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total DESC
LIMIT 1;

-- Write a query to return the email, first name, last name, & Genre of all Rock Music listeners.
-- Return you list ordered alphabetically by email starting with alter

SELECT c.email, c.first_name, c.last_name  
FROM customer c 
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE track_id IN(
    SELECT track_id FROM track t
    JOIN genre g ON t.genre_id = g.genre_id
    WHERE g.name LIKE 'Rock'
)
ORDER BY c.email;

-- Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands

SELECT ar.artist_id, ar.name, COUNT(ar.artist_id) AS number_of_songs FROM track t 
JOIN album2 a ON t.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = "Rock"
GROUP BY a.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

-- Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

SELECT name, milliseconds FROM track
WHERE milliseconds > (
    SELECT AVG(milliseconds) AS avg_track_length
    FROM track)
ORDER BY milliseconds DESC;
