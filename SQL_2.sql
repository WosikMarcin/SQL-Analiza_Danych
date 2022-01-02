1).Napisz zapytania, które wyświetlą informacje (sakila.rental) na podstawie poniższych kryteriów:
a) wypożyczeniach z roku 2005,
b) wypożyczeniach z dnia 2005-05-24,
c) wypożyczeniach po 2005-06-30,
d) wypożyczeniach w trakcie wakacji, tj. pomiędzy 2005-06-30,
a 2005-08-31 od pracownika Jon'a (sprawdź najpierw jaki ma staff_id w sakila.staff).'

a).
SELECT rental_date FROM sakila19_5.rental
WHERE rental_date BETWEEN '2005-01-01' AND '2005-05-31';
b).
SELECT rental_date FROM sakila19_5.rental
WHERE rental_date BETWEEN '2005-05-24 00:00:00' AND '2005-05-24 23:59:59';
c).
SELECT rental_date FROM sakila19_5.rental
WHERE rental_date >= '2005-06-30';
d).
SELECT rental_date, staff_id FROM sakila19_5.rental
WHERE rental_date BETWEEN '2005-06-30' AND '2005-08-31' AND staff_id = 2;

2). Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
a). wszystkich aktywnych klientów,
b). wszystkich aktywnych klientów albo tych, którzy zaczynają się od 'ANDRE'

a).
SELECT * FROM sakila19_5.customer
WHERE active = '1';
b).
SELECT first_name, active FROM sakila19_5.customer
WHERE active = '1' OR first_name LIKE 'ANDRE%';

3). Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
a). wszystkich nieaktywnych klientów ze store_id= 1
b). klientów, którzy mają adres email w innej domenie niż sakilacustomer.org. Czy istnieją tacy?
c). klientów o unikalnych wartościach w kolumnie create_date.

a).
SELECT first_name,last_name,active, store_id FROM sakila19_5.customer
WHERE active = '0' AND store_id = '1';
b).
SELECT first_name,last_name,email FROM sakila19_5.customer
WHERE email NOT LIKE '%sakilacustomer.org';
c).
SELECT DISTINCT(create_date) FROM sakila19_5.customer;

4) Zapoznaj się ze strukturą sakila.actor_analytics a następnie napisz kwerendy, które:
a). wyświetlą aktorów, którzy grali w ponad 25 filmach,
b). wyświetlą aktorów, którzy grali w ponad 20 filmach i ich średni rating przekracza 3.3,
c). wyświetlą aktorów, którzy grali w ponad 20 filmach i ich średni rating przekracza 3.3
lub wpływy z wypożyczeń (actor_payload) przekroczyły 2000.

a).
SELECT first_name,last_name,films_amount FROM sakila19_5.actor_analytics
WHERE films_amount > 25;
b).
SELECT first_name,last_name,films_amount,avg_film_rate FROM sakila19_5.actor_analytics
WHERE films_amount > 20 AND avg_film_rate > 3.3;
c).
SELECT first_name,last_name,films_amount,avg_film_rate,actor_payload FROM sakila19_5.actor_analytics
WHERE films_amount > 20 AND avg_film_rate > 3.3 OR actor_payload > 2000;

