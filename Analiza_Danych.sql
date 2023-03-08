------------------------------------------------------GRUPOWANIE--------------------------------------------------------
1). Wyświetl liczbe wierszy w tabeli payment schemat sakila. Nadaj alias rows_amount liczbie wierszy. 

SELECT COUNT(*) AS rows_amount FROM sakila.payment;

2). Znajdź aktorów (actor_id), którzy są rozchwytywani tzn. określ w ilu filmach zagrali poszczególni aktorzy. Posortuj od największej liczby.

SELECT actor_id, COUNT(film_id) AS played_in FROM sakila.film_actor
GROUP BY actor_id
ORDER BY played_in DESC;

3). Znajdź aktorów (imię i nazwisko), którzy są rozchwytywani tzn. określ w ilu filmach zagrali poszczególni aktorzy. Posortuj od największej liczby.

SELECT first_name, last_name, COUNT(film_id) AS played_in FROM sakila.film_actor AS fa
INNER JOIN sakila.actor AS a USING(actor_id)
GROUP BY actor_id
ORDER BY played_in DESC;

4). Znajdź i wybierz tylko tych klientów (customer_id) z tabeli sakila payment, którzy zapłacili za wypożyczenie (amount) sumarycznie ponad 50. 
Nadaj alias dla sumy płatniosci jako total_payment. Posortuj wyniki malejąco.
Przypuśćmy, że cena za wypożyczenie (amount) zaczyna się od 1. 

SELECT customer_id, SUM(amount) AS total_payment FROM sakila.payment
WHERE amount >= 1
GROUP BY customer_id
HAVING SUM(amount) > 50
ORDER BY SUM(amount) ASC;

5). Zagreguj tabelę payment według następujących reguł:

a).wyznacz całkowitą kwotę wpływów wypożyczalni (wpływy - amount),
b).wyznacz całkowitą kwotę wpływów wypożyczalni (wpływy - amount) w podziale na klientów (staff_id) (na razie nie pisz JOIN, użyj tylko customer_id),
c).wyznacz całkowitą kwotę wypożyczonych filmów (rental_id) w zależności od pracownika (staff_id),
d).używając funkcji date_format wykonaj podpunkty 2. dodatkowo w rozbiciu na miesiące kalendarzowe
a wyniki posortuj malejąco według klucza: customer_id rosnąco, SUM(amount) - malejąco.
e).używając funkcji date_format wykonaj podpunkty 3. dodatkowo w rozbiciu na miesiące kalendarzowe
a wyniki posortuj malejąco według klucza: staff_id rosnąco, SUM(amount) - malejąco.

a).

SELECT SUM(amount) FROM sakila.payment

b). 

SELECT customer_id, SUM(amount) FROM sakila.payment
GROUP BY customer_id

c).

SELECT staff_id, SUM(rental_id) FROM sakila.payment
GROUP BY staff_id

d).

SELECT customer_id, SUM(amount), date_format(payment_date,'%Y-%m-01') FROM sakila.payment
GROUP BY customer_id, payment_date
ORDER BY customer_id ASC, SUM(amount) DESC;

e).

SELECT staff_id, SUM(rental_id), date_format(payment_date,'%Y-%m-01') FROM sakila.payment
GROUP BY staff_id, payment_date
ORDER BY staff_id ASC, amount DESC;
    
6). Przygotuj raport wpłatowy na podstawie odpowiednich tabel z bazy sakila, który wyświetli następujące informacje:

imię klienta,
nazwisko klienta,
email klienta,
kwotę wpłat,
liczbę wpłat,
średnią kwotę wpłat,
datę ostatniej wpłaty.
Wynik zapytania zapisz w bazie używając widoku. Nazwij go payment_report. 

CREATE OR REPLACE VIEW payment_report AS SELECT
first_name AS imie_klienta,
last_name AS nazwisko_klienta,
email AS email_klienta,
SUM(amount) AS kwota_wplat,
COUNT(amount) AS liczba_wplat,
AVG(amount) AS srednia_kwota_wplat,
MAX(payment_date) AS data_ostatniej_wplaty
FROM sakila.payment AS p INNER JOIN sakila.customer AS c USING(customer_id)
GROUP BY customer_id

7). Utwórz tabele tymczasową tmp_film_actors a także:
    napisz kwerendę, która zwróci następujące informacje:
    nazwę filmu,
    liczbę aktorów występujących w filmie.

a).
DROP TABLE IF EXISTS tmp_film_actors;

CREATE TEMPORARY TABLE tmp_film_actors AS
SELECT title, COUNT(actor_id) FROM sakila.film AS f
INNER JOIN film_actor AS fa USING(film_id)
GROUP BY film_id

8). 
a). Napisz zapytanie, które zwróci:
film_id - nadaj alias - id_filmu, tabela sakila.film_analytics
title - nadaj alias - tytul_filmu, tabela sakila.film_analytics
rental_id - nadaj alias - liczba_wypozyczen_filmu, tabela sakila.rental

Wyniki zapisz do tabeli tymczasowej, np. tmp_film_rentals. 

b). Wyświetl wyniki

a).
DROP TABLE IF EXISTS tmp_film_rentals;

CREATE TEMPORARY TABLE IF NOT EXISTS tmp_film_rentals AS
SELECT film_id AS id_filmu, title AS tytul_filmu, COUNT(rental_id) AS liczba_wypozyczen_filmu FROM film AS f
INNER JOIN sakila.inventory AS i USING(film_id) INNER JOIN sakila.rental AS r USING(inventory_id)
GROUP BY film_id;

b)

SELECT * FROM tmp_film_rentals

------------------------------------------------------DATETIME--------------------------------------------------------
1). Zwróć aktualny czas serwera.

SELECT NOW();

2). Dla daty 2021-06-01 wykonaj następujące polecenia:
a). dodaj 1 dzień do daty
b). dodaj 30 dni do daty
c). dodaj 1 miesiąc do daty
d). odetnij 15 dni od daty

a).

SELECT ADDDATE('2021-06-01', INTERVAL 1 DAY); 

b).

SELECT ADDDATE('2021-06-01', INTERVAL 30 DAY); 

c). 

SELECT ADDDATE('2021-06-01', INTERVAL 1 MONTH);

d).

SELECT ADDDATE('2021-06-01', INTERVAL -15 DAY);

3). Dla daty i czasu 2021-07-10 23:59:59 wykonaj następujące polecenia:

a). dodaj jedną sekunde
b). dodaj jedną godzinę, minutę, sekundę

a). SELECT ADDTIME('2021-07-10 23:59:59', '00:00:01')
b). SELECT ADDTIME('2021-07-10 23:59:59', '01:01:01')

4). Określa różnicę pomiędzy dwoma datami wyrażoną w dniach.

a). 2021-06-10 23:00:00 - 2021-06-01 23:00:00
b). 2021-06-10 23:00:00 - 2020-06-01
c). 2021-06-10 23:00:00 - 2021-06-01 22:00:00

a). SELECT DATEDIFF('2021-06-10 23:00:00', '2021-06-01 23:00:00');
b). SELECT DATEDIFF('2021-06-10 23:00:00', '2020-06-01');
c). SELECT DATEDIFF('2021-06-10 23:00:00', '2021-06-01 22:00:00');

5). Wyodrębnij z daty:

a). 2021-06-10 23:00:00, rok
b). 2021-06-10 23:00:00, dzień
c). 2021-06-10 23:00:00, który to tydzień
d). 2021-06-10 23:00:00, sekunde

a).
SELECT EXTRACT(YEAR FROM '2021-06-10 23:00:00');
b).
SELECT EXTRACT(DAY FROM '2021-06-10 23:00:00');
c)
SELECT EXTRACT(WEEK FROM '2021-06-10 23:00:00');
d).
SELECT EXTRACT(SECOND FROM '2021-06-10 23:00:00');
