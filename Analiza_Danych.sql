------------------------------------------------------GRUPOWANIE--------------------------------------------------------
1).Zagreguj tabelę payment według następujących reguł:

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

2). Przygotuj raport wpłatowy na podstawie odpowiednich tabel z bazy sakila, który wyświetli następujące informacje:

imię klienta,
nazwisko klienta,
email klienta,
kwotę wpłat,
liczbę wpłat,
średnią kwotę wpłat,
datę ostatniej wpłaty.
Wynik zapytania zapisz w bazie używając widoku.

Sprawdz, czy Twoje zapytanie jest poprawne i napisz odpowiedną kwerendę (odpowiednie kwerendy).

3). Utwórz tabele tymczasową tmp_film_actors a także:
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

4).

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
