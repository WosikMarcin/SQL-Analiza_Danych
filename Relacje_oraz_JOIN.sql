------------------------------------------------------JOIN-------------------------------------------------------
1). Napisz złączenie, które połączy tabele rental oraz payment. Wyświetl tylko poniższe kolumny:

payment_id,
rental_id,
amount,
rental_date,
payment_date.
W tym zadaniu użyj INNER JOIN.
Pamiętaj o użyciu aliasów dla tabel w zapytaniu

a).
SELECT payment_id, r.rental_id, amount, rental_date, payment_date
FROM sakila.rental AS r
INNER JOIN sakila.payment AS p
ON r.rental_id = p.rental_id;

b).
SELECT payment_id, r.rental_id, amount, rental_date, payment_date
FROM sakila.rental AS r
INNER JOIN sakila.payment AS p USING (rental_id)

2). Napisz zapytanie, które połączy tabele rental oraz inventory oraz wyświetli poniższe kolumny:

inventory_id,
rental_id,
film_id.
Ponownie użyj INNER JOIN w celu połączenia.

a).
SELECT r.inventory_id, rental_id, film_id
FROM sakila.rental AS r
INNER JOIN sakila.inventory AS i
ON r.inventory_id = i.inventory_id

b).
SELECT r.inventory_id, rental_id, film_id
FROM sakila.rental AS r
INNER JOIN sakila.inventory AS i USING (inventory_id)

3). Napisz zapytanie, które połączy tabele film oraz inventory oraz wyświetli poniższe kolumny:

inventory_id,
film_id,
title,
description,
release_year.

a).
SELECT inventory_id, f.film_id, title, description, release_year
FROM sakila.film AS f
INNER JOIN sakila.inventory AS i
ON f.film_id = i.film_id;

b).
SELECT inventory_id, f.film_id, title, description
FROM sakila.film AS f
INNER JOIN sakila19_5.inventory AS i USING (film_id)

4). Używając kwerend i sposobu łączenia z poprzednich zadań napisz kwerendę,
które zwróci następujące informacje dot. wypożyczenia:

id wypożyczenia,
id filmu,
tytuł filmu,
opis filmu,
rating filmu,
ocenę wypożyczenia,
datę wypożyczenia,
datę płatności,
kwotę płatności.

a).
SELECT p.rental_id, i.film_id, title, description, rating, special_features, rental_date, payment_date, amount
FROM sakila.payment AS p
INNER JOIN sakila.rental AS r
ON p.rental_id = r.rental_id
INNER JOIN sakila.inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN sakila.film AS f
ON i.film_id = f.film_id

b).
SELECT p.rental_id, i.film_id, title, description, rating, special_features, rental_date, payment_date, amount
FROM sakila.payment AS p
INNER JOIN sakila.rental AS r USING (rental_id)
INNER JOIN sakila.inventory AS i USING (inventory_id)
INNER JOIN sakila.film AS f USING (film_id)

5). Używając tabel tasks.payment oraz sakila.rental znajdź te wypożyczenia (rental_date),
które nie zostały opłacone (nie posiadają płatności(AMOUNT)).

a). 
SELECT r.rental_date, amount FROM sakila.rental AS r
LEFT JOIN tasks.payment AS p
ON r.rental_id = p.rental_id
WHERE amount = '0'

b).
SELECT r.rental_id, amount FROM sakila.rental AS r
LEFT JOIN tasks.payment AS p USING (rental_id)
WHERE amount = 0;

-----------------------------------------------JOIN W MODYFIKACJACH DANYCH----------------------------------------------
1).
W tabeli tasks.city_country znajdują się trzy kolumny:

city,
country_id,
country.
W tym momencie kolumna country jest pusta, napisz odpowiednie zapytanie i uzupełnij ją używając UPDATE
Dodatkowo, po wykonaniu zapytania napisz kolejne, które sprawdzi, czy ta kolumna na pewno została uzupełniona.

UPDATE
tasks.city_country
SET country = 'POLAND'
WHERE country = ''

SELECT * FROM tasks.city_country

2).
Tabela tasks.films_to_be_cleaned jest kopią tabeli film.
a).
Chcemy z tasks.films_to_be_cleaned usunąć filmy, które spełniają następujące warunki:

category_id w (1, 5, 7, 9) - tabela sakila.film_category,
length jest krótszy niż 1 godzina - tabela tasks.films_to_be_cleaned,
rating nie jest NC-17 lub PG - tabela tasks.films_to_be_cleaned.
Zadanie wykonaj używając JOIN. 

b).
Po wykonaniu swojego zapytania napisz kolejne, które sprawdzi jego poprawność.

a).
DELETE ftbc
FROM tasks.films_to_be_cleaned AS ftbc
JOIN sakila.film_category AS fc ON ftbc.film_id = fc.film_id
WHERE category_id IN (1, 5, 7, 9) AND rating NOT IN ('NC-17','PG') AND length < 360

b).
SELECT category_id, rating, length
FROM tasks.films_to_be_cleaned AS ftbc
JOIN sakila.film_category AS fc ON ftbc.film_id = fc.film_id
WHERE category_id IN (1, 5, 7, 9) AND rating NOT IN ('NC-17','PG') AND length < 360

3).
Tabela tasks.california_payments jest pustą kopią tabeli sakila.payments. 
a).Napisz kwerendę, która uzupełni ją tylko o te płatności, które pochodzą od klientów posiadających adres z California.
b).Dodatkowo napisz zapytanie, które sprawdzi, że klienci, którzy są dostępni w tabeli tasks.california_payments, pochodzą tylko z tego obrębu.

a).
INSERT INTO tasks.california_payments(
    payment_id,
    customer_id,
    staff_id,
    rental_id,
    amount,
    payment_date,
    last_update
    )
SELECT
       p.payment_id,
       p.customer_id,
       p.staff_id,
       p.rental_id,
       p.amount,
       p.payment_date,
       p.last_update
FROM
    sakila.payment AS p
JOIN
    sakila.customer AS c USING (customer_id)
JOIN
    sakila.address AS a USING (address_id)
WHERE a.district = 'California';

b).
SELECT payment_id, p.customer_id, staff_id, rental_id, amount, payment_date, p.last_update, district
FROM tasks.california_payments p
JOIN sakila.customer c ON p.customer_id = c.customer_id
JOIN sakila.address a ON c.address_id = a.address_id
WHERE district = 'California';

4).
a). stwórz tabele examples.buildings a także
    dodaj kolumny: building_no ( typ danych numeryczny - całkowity (-2 10^9, 2 10^9), jest to klucz główny), building_name ( typ danych znakowy o zmiennej długości (255) ), 
    address ( typ danych znakowy o zmiennej długości (255) )
b). stwórz tabele examples.rooms a także
    dodaj kolumny: room_no ( typ danych numeryczny - całkowity (-2 10^9, 2 10^9)), room_name ( typ danych znakowy o zmiennej długości (255), ograniczenie NOT NULL), 
    building_no ( typ danych numeryczny - całkowity (-2 10^9, 2 10^9), ograniczenie NOT NULL, jest to klucz obcy )
    


a).
CREATE TABLE examples.buildings (
  building_no INT PRIMARY KEY,
  building_name VARCHAR(255),
  address VARCHAR(255)
);

b).
CREATE TABLE examples.rooms (
  room_no INT,
  room_name VARCHAR(255) NOT NULL,
  building_no INT NOT NULL,
  FOREIGN KEY (building_no)
  REFERENCES examples.buildings (building_no)   
  ON DELETE CASCADE 
);
