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
Tabela tasks.films_to_be_cleaned jest kopią tabeli .
Chcemy z niej usunąć filmy, które spełniają następujące warunki:

film_category w (1, 5, 7, 9),
length jest krótszy niż 1 godzina,
rating nie jest NC-17 lub PG.
Zadanie wykonaj używając JOIN. Po wykonaniu swojego zapytania napisz kolejne, które sprawdzi jego poprawność.

DELETE c
FROM
          tasks.films_to_be_cleaned AS f
  INNER JOIN
          sakila.film_category AS c USING (film_id)
WHERE f.length < 1
AND rating NOT IN (NC-17,PG)
AND category_id IN (1,5,7,9)

SELECT * FROM tasks.films_to_be_cleaned
SELECT * FROM sakila.film_category

3).
Tabela jest pustą kopią tabeli . Napisz kwerendę, która uzupełni ją tylko o te płatności,
które pochodzą od klientów posiadających adres z .tasks.california_paymentssakila.paymentsCalifornia

Dodatkowo napisz zapytanie, które sprawdzi, że klienci, którzy są dostępni w tabeli ,
pochodzą tylko z tego obrębu.tasks.california_payments

