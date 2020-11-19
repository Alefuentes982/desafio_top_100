CREATE DATABASE Peliculas

---creando la tabala pelicula
CREATE TABLE pelicula 
(id INT,
Pelicula VARCHAR(255),
Año_estreno INT,
Director VARCHAR(255),
PRIMARY KEY(id));

----creando tabla reparto
CREATE TABLE reparto 
(Film INT,
actor VARCHAR(255),
FOREIGN KEY(Film) REFERENCES pelicula(id));

---cargando archivos a tabla pelicula
copy pelicula(id,Pelicula,Año_estreno,Director) FROM '/home/ale/Escritorio/desafio latam/desafio latam G40/3 introduccion a las bases de datos/clase_2/ApoyoDesafío2-Top100/peliculas.csv' DELIMITER ',' CSV HEADER;  

---cargando archivos a tabla reparto
copy reparto(film,actor) FROM '/home/ale/Escritorio/desafio latam/desafio latam G40/3 introduccion a las bases de datos/clase_2/ApoyoDesafío2-Top100/reparto.csv' DELIMITER ',' CSV;  

----Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,
--año de estreno, director y todo el reparto

SELECT * FROM reparto JOIN pelicula ON pelicula.id=reparto.film
WHERE film=2;

---Listar los titulos de las películas donde actúe Harrison Ford

SELECT actor,pelicula FROM reparto JOIN pelicula ON pelicula.id=reparto.film
WHERE actor='Harrison Ford';

--- Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el
--top 100


SELECT director, count(*) as cantidad_de_films FROM pelicula 
GROUP BY director 
ORDER BY cantidad_de_films DESC
LIMIT 10;

---Indicar cuantos actores distintos hay
SELECT COUNT(distinct actor) FROM reparto;

--- Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por
--título de manera ascendente.
SELECT pelicula, año_estreno FROM pelicula WHERE año_estreno >= 1990 AND año_estreno <= 1999
ORDER BY año_estreno;

--- Listar el reparto de las películas lanzadas el año 2001
SELECT año_estreno, pelicula, actor FROM reparto JOIN pelicula ON pelicula.id=reparto.film
WHERE año_estreno = 2001;

---Listar los actores de la película más nueva
SELECT actor, pelicula, año_estreno FROM reparto JOIN PELICULA ON pelicula.id=reparto.film
WHERE año_estreno=(
   SELECT MAX (año_estreno)
   FROM pelicula
);








