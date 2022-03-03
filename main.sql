CREATE DATABASE record_company;
USE record_company;
CREATE TABLE bands (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE albums (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    release_year INT,
    band_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (band_id)
        REFERENCES bands (id)
);

        INSERT INTO bands
            (name)
        VALUES
            ('Flume');

        INSERT INTO bands
            (name)
        VALUES
            ('Kaytranada'),
            ('Disclosure'),
            ('McSlambley');

SELECT 
    *
FROM
    bands;

SELECT 
    *
FROM
    bands
LIMIT 2;

SELECT 
    name
FROM
    bands;

SELECT 
    id AS 'ID', name AS 'Band Name'
FROM
    bands;

SELECT 
    *
FROM
    bands
ORDER BY name ASC;

        INSERT INTO albums
            (name, release_year, band_id)
        VALUES
            ('Skin', 2017, 1),
            ('Hello, my name is Flume', 2019, 1),
            ('Bubba', 2019, 2),
            ('99.9%', 2017, 2),
            ('Baby Steps', 2020, 4),
            ('Settle', 2013, 3);

SELECT 
    *
FROM
    albums;

SELECT 
    name
FROM
    albums;

SELECT DISTINCT
    name
FROM
    albums;

UPDATE albums 
SET 
    release_year = 2022
WHERE
    id = 5;

SELECT 
    *
FROM
    albums
WHERE
    release_year < 2020;

SELECT 
    *
FROM
    albums
WHERE
    name LIKE '%b%b%';

SELECT 
    *
FROM
    albums
WHERE
    release_year = 1984 AND band_id = 1;

SELECT 
    *
FROM
    albums
WHERE
    release_year BETWEEN 1900 AND 2018;

SELECT 
    *
FROM
    albums
WHERE
    release_year IS NULL;

DELETE FROM albums 
WHERE
    id > 6;

SELECT 
    *
FROM
    albums;

SELECT 
    *
FROM
    bands
        JOIN
    albums ON bands.id = albums.band_id;

SELECT 
    *
FROM
    albums
        INNER JOIN
    bands ON albums.band_id = bands.id;

SELECT 
    *
FROM
    bands
        LEFT JOIN
    albums ON bands.id = albums.band_id;

SELECT 
    *
FROM
    bands
        RIGHT JOIN
    albums ON bands.id = albums.band_id;

SELECT 
    AVG(release_year)
FROM
    albums;

SELECT 
    SUM(release_year)
FROM
    albums;

SELECT 
    band_id AS Band, COUNT(band_id) AS Albums
FROM
    albums
GROUP BY band_id;

SELECT 
    bands.name, COUNT(albums.id)
FROM
    bands
        LEFT JOIN
    albums ON bands.id = albums.band_id
GROUP BY bands.id;

SELECT 
    b.name AS band_name, COUNT(a.id) AS num_albums
FROM
    bands AS b
        LEFT JOIN
    albums AS a ON b.id = a.band_id
GROUP BY b.id;

SELECT 
    b.name AS band_name, COUNT(a.id) AS num_albums
FROM
    bands AS b
        LEFT JOIN
    albums AS a ON b.id = a.band_id
GROUP BY b.id
HAVING num_albums = 1;

SELECT 
    b.name AS band_name, COUNT(a.id) AS num_albums
FROM
    bands AS b
        LEFT JOIN
    albums AS a ON b.id = a.band_id
WHERE
    b.name = 'McSlambley'
GROUP BY b.id
HAVING num_albums = 1;

        DROP DATABASE record_company;

        CREATE DATABASE record_company;
        USE record_company;

CREATE TABLE bands (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE albums (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    release_year INT,
    band_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (band_id)
        REFERENCES bands (id)
);

SELECT 
    *
FROM
    albums;

CREATE TABLE songs (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    length FLOAT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (album_id)
        REFERENCES albums (id)
);

SELECT 
    *
FROM
    songs;

SELECT 
    *
FROM
    bands;

SELECT 
    name AS 'Band Name'
FROM
    bands;

SELECT 
    bands.name AS 'Band Name'
FROM
    bands;

-- #3
SELECT 
    *
FROM
    albums
WHERE
    release_year IS NOT NULL
ORDER BY release_year ASC
LIMIT 1;

-- #4
SELECT 
    bands.name AS 'Band Name', COUNT(albums.id) AS 'Albums'
FROM
    bands
        LEFT JOIN
    albums ON bands.id = albums.band_id
GROUP BY bands.name;

-- Actual
SELECT DISTINCT
    bands.name AS 'Band Name'
FROM
    bands
        JOIN
    albums ON bands.id = albums.band_id;

-- Or
SELECT 
    bands.name AS 'Band Name'
FROM
    bands
        JOIN
    albums ON bands.id = albums.band_id
GROUP BY albums.band_id
HAVING COUNT(albums.id) > 0;

-- #5
SELECT 
    bands.name AS 'Band Name'
FROM
    bands
        LEFT JOIN
    albums ON bands.id = albums.band_id
WHERE
    albums.id IS NULL
GROUP BY bands.name;
    
-- OR
SELECT 
    bands.name AS 'Band Name'
FROM
    bands
        LEFT JOIN
    albums ON bands.id = albums.band_id
GROUP BY albums.band_id
HAVING COUNT(albums.id) = 0;

-- #6
SELECT 
	albums.name as 'Name', 
	albums.release_year as 'Release Year',
    SUM(songs.length) as 'Duration'
FROM albums
JOIN songs ON songs.album_id = albums.id
GROUP BY songs.album_id
ORDER BY Duration DESC
LIMIT 1;

SELECT name FROM bands
UNION ALL
SELECT name FROM songs
ORDER BY name;

SELECT name
FROM songs
WHERE EXISTS
(SELECT name FROM songs WHERE name LIKE '%a');

-- #7 Update the Release year of the album with no release year
SELECT id FROM albums WHERE release_year IS NULL;

UPDATE albums
SET release_year = 1986
WHERE id = 4;

SELECT * from albums WHERE id = 4;

-- #8 Insert a record for your favorite Band and one of their Albums
SELECT * from bands;

INSERT INTO bands(name) VALUES('flume');

SELECT * FROM bands WHERE name = 'flume';

UPDATE bands 
SET name = 'Flume'
WHERE id = 8; 

SELECT * FROM albums; 

INSERT INTO albums(name, release_year, band_id)
VALUES('Skin', 2016, 8);

SELECT bands.name, albums.name
FROM bands
LEFT JOIN
	albums
    ON bands.id = albums.band_id
    ORDER BY bands.name;

-- 9 Delete the Band and Album you added in #8
DELETE FROM albums WHERE albums.band_id = 8;
SELECT * FROM albums;
DELETE FROM bands WHERE id = 8;
SELECT * FROM bands;
-- :(

-- 10. Get the Average Length of all Songs
SELECT length FROM songs;

SELECT AVG(length) as 'Average Song Duration' 
FROM songs;

-- 11. Select the longest Song off each Album
SELECT 
	albums.name as 'Album', 
	release_year as 'Release Year', 
	MAX(songs.length) as 'Duration'
FROM albums
JOIN songs ON albums.id = songs.album_id
GROUP BY songs.album_id;

-- 12. Get the number of Songs for each Band
SELECT bands.name as 'Band', COUNT(songs.id) as 'Number of Songs'
FROM bands
JOIN albums on bands.id = albums.band_id
JOIN songs ON albums.id = songs.album_id
GROUP BY albums.band_id;