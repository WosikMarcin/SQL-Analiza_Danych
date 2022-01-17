1). Napisz złączenie, które połączy tabele rental oraz payment. Wyświetl tylko poniższe kolumny:

payment_id,
rental_id,
amount,
rental_date,
payment_date.
W tym zadaniu użyj INNER JOIN.
Pamiętaj o użyciu aliasów dla tabel w zapytaniu

SELECT payment_id,r.rental_id,amount,rental_date,payment_date
FROM sakila19_5.rental AS r
INNER JOIN sakila19_5.payment AS p
ON r.rental_id = p.rental_id;

2). Napisz zapytanie, które połączy tabele rental oraz inventory oraz wyświetli poniższe kolumny:

inventory_id,
rental_id,
film_id.
Ponownie użyj INNER JOIN w celu połączenia.

SELECT r.inventory_id,rental_id,film_id
FROM sakila19_5.rental AS r
INNER JOIN sakila19_5.inventory AS i
ON r.inventory_id = i.inventory_id;

3). Napisz zapytanie, które połączy tabele film oraz inventory oraz wyświetli poniższe kolumny:

inventory_id,
film_id,
title,
description,
release_year.

SELECT inventory_id,f.film_id,title,description
FROM sakila19_5.film AS f
INNER JOIN sakila19_5.inventory AS i
ON f.film_id = i.film_id;

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

SELECT p.rental_id,i.film_id,title,description,rating,special_features,rental_date,payment_date,amount
FROM sakila19_5.payment AS p
INNER JOIN sakila19_5.rental AS r
ON p.rental_id = r.rental_id
INNER JOIN sakila19_5.inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN sakila19_5.film AS f
ON i.film_id = f.film_id

5). Używając tabel tasks.payment oraz sakila.rental znajdź te wypożyczenia,
które nie zostały opłacone (nie posiadają płatności).

