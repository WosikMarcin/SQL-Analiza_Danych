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

4). Zagreguj tabelę payment według następujących reguł:

a).wyznacz całkowitą kwotę wpływów wypożyczalni (wpływy - amount),
b).wyznacz całkowitą kwotę wpływów wypożyczalni (wpływy - amount) w podziale na klientów (staff_id) (na razie nie pisz JOIN, użyj tylko customer_id),
c).wyznacz całkowitą kwotę wypożyczonych filmów (rental_id) w zależności od pracownika (staff_id),
d).używając funkcji date_format wykonaj podpunkty 2. i 3. dodatkowo w rozbiciu na miesiące kalendarzowe
a wyniki posortuj malejąco według klucza: staff_id rosnąco, amount - malejąco.

a).

SELECT SUM(amount) FROM sakila.payment

b). 

SELECT customer_id, SUM(amount) FROM sakila.payment
GROUP BY customer_id

c).

SELECT staff_id, COUNT(rental_id) FROM sakila.payment
GROUP BY staff_id

5). Przygotuj raport wpłatowy na podstawie odpowiednich tabel z bazy sakila, który wyświetli następujące informacje:

imię klienta,
nazwisko klienta,
email klienta,
kwotę wpłat,
liczbę wpłat,
średnią kwotę wpłat,
datę ostatniej wpłaty.
Wynik zapytania zapisz w bazie używając widoku.

Sprawdz, czy Twoje zapytanie jest poprawne i napisz odpowiedną kwerendę (odpowiednie kwerendy).

6). Utwórz tabele tymczasową tmp_film_actors a także:
a). napisz kwerendę, która zwróci następujące informacje:
    nazwę filmu,
    liczbę aktorów występujących w filmie.
b). dodatkowo napisz zapytanie, którym zweryfikujesz swoją kwerendę

a).

CREATE TEMPORARY TABLE tmp_film_actors AS
SELECT title, COUNT(actor_id) FROM sakila.film
JOIN film_actor AS fa USING(film_id)
GROUP BY film_id

b).

SELECT * FROM tmp_film_actors

7).

a). Napisz zapytanie, które zwróci:
film_id - alias id filmu, tabela sakila.film_analytics
title - alias tytuł filmu, tabela sakila.film_analytics
rentals - alias liczbę wypożyczeń filmu, tabela sakila.film_analytics

Wyniki zapisz do tabeli tymczasowej, np. tmp_film_rentals.

b). dodatkowo napisz kwerendę, którą zweryfikujesz swoje rozwiązanie.

a).

CREATE TEMPORARY TABLE tmp_film_rentals AS
SELECT film_id AS id_filmu, title AS tytuł_filmu, rentals AS liczbe_wypozyczen_filmu FROM sakila.film_analytics

b).

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
