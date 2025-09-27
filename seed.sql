-- Usage: mysql -u justbook -pjustbook < seed_data.sql

CREATE DATABASE IF NOT EXISTS justbook;
USE justbook;

-- Optional cleanup if you want a fully fresh seed run.
-- SET FOREIGN_KEY_CHECKS = 0;
-- TRUNCATE TABLE bookings;
-- TRUNCATE TABLE movies;
-- SET FOREIGN_KEY_CHECKS = 1;

-- Ensure tables exist before inserting data
CREATE TABLE IF NOT EXISTS movies (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  rating VARCHAR(20) NOT NULL,
  available_seats INT NOT NULL
);

CREATE TABLE IF NOT EXISTS bookings (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  customer_name VARCHAR(255) NOT NULL,
  seats INT NOT NULL,
  movie_id BIGINT NOT NULL,
  CONSTRAINT fk_bookings_movie FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

-- Seed movies
INSERT INTO movies (title, description, rating, available_seats) VALUES
  ('Inception', 'Mind-bending thriller from Christopher Nolan', 'PG-13', 120),
  ('The Grand Budapest Hotel', 'Wes Anderson comedy set in a legendary hotel', 'R', 80),
  ('Black Panther', 'Marvel hero returns to Wakanda to claim the throne', 'PG-13', 150),
  ('Spider-Man: Across the Spider-Verse', 'Miles Morales joins forces with Spider-People across the multiverse', 'PG', 140),
  ('Past Lives', 'Childhood friends reconnect decades later in New York', 'PG-13', 60)
ON DUPLICATE KEY UPDATE
  description = VALUES(description),
  rating = VALUES(rating),
  available_seats = VALUES(available_seats);

-- Capture movie ids for reuse in bookings
SET @movie_inception_id := (SELECT id FROM movies WHERE title = 'Inception' ORDER BY id DESC LIMIT 1);
SET @movie_grand_budapest_id := (SELECT id FROM movies WHERE title = 'The Grand Budapest Hotel' ORDER BY id DESC LIMIT 1);
SET @movie_black_panther_id := (SELECT id FROM movies WHERE title = 'Black Panther' ORDER BY id DESC LIMIT 1);
SET @movie_spiderverse_id := (SELECT id FROM movies WHERE title = 'Spider-Man: Across the Spider-Verse' ORDER BY id DESC LIMIT 1);
SET @movie_past_lives_id := (SELECT id FROM movies WHERE title = 'Past Lives' ORDER BY id DESC LIMIT 1);

-- Seed bookings tied to the movies above
INSERT INTO bookings (customer_name, seats, movie_id)
SELECT * FROM (
  SELECT 'Alice Johnson' AS customer_name, 2 AS seats, @movie_inception_id AS movie_id
) AS t1 WHERE @movie_inception_id IS NOT NULL
UNION ALL
SELECT * FROM (
  SELECT 'Marcus Lee' AS customer_name, 4 AS seats, @movie_black_panther_id AS movie_id
) AS t2 WHERE @movie_black_panther_id IS NOT NULL
UNION ALL
SELECT * FROM (
  SELECT 'Priya Sharma' AS customer_name, 3 AS seats, @movie_spiderverse_id AS movie_id
) AS t3 WHERE @movie_spiderverse_id IS NOT NULL
UNION ALL
SELECT * FROM (
  SELECT 'Elena Garcia' AS customer_name, 2 AS seats, @movie_grand_budapest_id AS movie_id
) AS t4 WHERE @movie_grand_budapest_id IS NOT NULL
UNION ALL
SELECT * FROM (
  SELECT 'Noah Williams' AS customer_name, 1 AS seats, @movie_past_lives_id AS movie_id
) AS t5 WHERE @movie_past_lives_id IS NOT NULL
ON DUPLICATE KEY UPDATE
  seats = VALUES(seats),
  movie_id = VALUES(movie_id);