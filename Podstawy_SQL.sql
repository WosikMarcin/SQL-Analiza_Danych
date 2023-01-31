--------------------------------------------------------TABELE---------------------------------------------------------
1). Utwórz tabele my_first_table a nastepnie:
a). dodaj kolumny first_col ( typ danych znakowy krótki tekst to 65 tys. znaków ) i second_col ( typ danych czasowy, data i czas w formacie CCYY-MM-DD hh:mm:ss )
b). dodaj kolumne email ( typ danych znakowy o dlugosci 50 )
c). usun kolumne second_col
d). usuń tabele my_first_table

a).
CREATE TABLE IF NOT EXISTS my_first_table(
first_col text,
second_col datetime
)
b). 
ALTER TABLE sakila.my_first_table
ADD email VARCHAR(50)
c).
ALTER TABLE my_first_table
DROP second_col
c). 
DROP TABLE my_first_table

2). Utwórz tabele actor_nick a nastepnie:
a). wypełnij tabele na podstawie zapytania, ktore ma wyswietlic wszystkie dane z sakila.actor gdzie first_name to Nick 
b). dodaj kolumne phone ( typ danych numeryczny zakres (-128,127) )
c). usun kolumne last_update
d). usuń tabele actor_nick

a).
CREATE TABLE IF NOT EXISTS actor_nick AS
SELECT * FROM sakila.actor
WHERE first_name = 'Nick'
b).
ALTER TABLE actor_nick
ADD phone TINYINT
c).
DROP TABLE actor_nick

3). Utwórz tabele tymczasowa tmp_actor_nick a nastepnie:
a). dodaj kolumny first_col ( typ danych znakowy, bardzo krótki tekst do 255 znaków )
i second_col ( typ danych czasowy, data i czas w formacie CCYY-MM-DD hh:mm:ss  )
b). dodaj kolumne EmployeeCode ( typ danych znakowy, znaki o określonej długości 3 ) uzywajac osobnej fukcji
c). usuń tabele tmp_actor_nick

a).
CREATE TEMPORARY TABLE tmp_actor_nick (
    first_col VARCHAR(255),
    second_col DATETIME
)
b).
ALTER TABLE tmp_actor_nick
ADD EmployeeCode CHAR(3)
c).
DROP TABLE tmp_actor_nick

4). Utwórz tabele tymczasowa tmp_actor_nick a nastepnie:
a). wypełnij tabele na podstawie zapytania, ktore ma wyswietlic wszystkie dane z sakila.actor gdzie first_name to Nick
b) dodaj kolumne BirthDate ( typ danych czasowy, rok zapisany jako CCYY lub YY ) uzywajac osobnej fukcji
c). usuń tabele actor_nick

a).
CREATE TEMPORARY TABLE tmp_actor_nick AS
SELECT * FROM sakila.actor WHERE first_name = 'Nick'
b).
ALTER TABLE tmp_actor_nick
ADD BirthDate year
c)
DROP TABLE tmp_actor_nick

5). Utwórz tabele students z:
a). kolumna id ( typ danych znakowy, bardzo mała całkowita (-128, 127) )
name, surname, email ( typ danych zankowy, znaki o zmiennej długości (50) )
b). dodaj kolumne classs_id ( typ danych znakowy, bardzo mała całkowita (-128, 127) ) uzywajac osobnej fukcji
c). dodaj dane do tabeli id = 10, name = Jacek, surname = Kowalski, email = jacek@gmail.com, class_id = 1
d). dodaj dane do tabeli name = Wojtek, email = wojtek@gmail.com
e). dodaj do tabeli dane id = 11, name = Marian, surname = Kowalski, email = marian@gmail.com, class_id = 1
                         id = 12, name = Jaroslaw, surname = Nowak, email = jn@gmail.com, class_id = 2
f). dodaj do tabeli dane name, surname, email na podstawie zapytania, ktore ma wyswietlic name, surname, email z sakila.customer z limitem zwroconych rekordów 5.
g). zaktualizuje wiersz, w ktorym id = 10 tak aby name bylo Grzesiek
h). usun wszystkich o imieniu Marian
i). usun kolumne class_id
j). usun tylko 2 pierwszych studentow bez nadanego id
k). wyszysc cala zawartosc tabeli 3 sposobami
l). usuń tabele students

a).
CREATE TABLE IF NOT EXISTS students (
    id TINYINT,
    name VARCHAR(50),
    surname VARCHAR(50),
    email VARCHAR(50)
)
b).
ALTER TABLE students 
ADD class_id TINYINT
c).
INSERT INTO students VALUES ( 10 , 'Jacek' , 'Kowalski' , 'jacek@gmail.com' , 1 )
d).
INSERT INTO students ( name, email ) VALUES ( 'Wojtek' , 'wojtek@gmail.com' )
e).
INSERT INTO students VALUES ( 11, 'Marian' , 'Kowalski' , 'marian@gmail.com' , 1 ),
                            ( 12, 'Jaroslaw' , 'Nowak' , 'jn@gmail.com' , 2 )
f).                    
INSERT INTO students ( name, surname, email )
SELECT first_name, last_name, email FROM sakila.customer
LIMIT 5
g).
UPDATE students
SET name = 'Grzesiek'
WHERE id=10;
h).
DELETE FROM students
WHERE name = 'Marian'
i). 
ALTER TABLE students
DROP class_id
j).
DELETE FROM students
WHERE id IS NULL
ORDER BY name
LIMIT 2
k). 
DELETE FROM students

DELETE FROM students
WHERE TRUE

TRUNCATE students
i).
DROP TABLE students

------------------------------------------------FILTROWANIE------------------------------------------------------------

1).Napisz zapytania, które wyświetlą informacje (sakila.rental) na podstawie poniższych kryteriów:
a) wypożyczeniach z roku 2005,
b) wypożyczeniach z dnia 2005-05-24,
c) wypożyczeniach po 2005-06-30,
d) wypożyczeniach w trakcie wakacji, tj. pomiędzy 2005-06-30,
a 2005-08-31 od pracownika Jon'a (sprawdź najpierw jaki ma staff_id w sakila.staff).'

a).
SELECT rental_date FROM sakila.rental
WHERE rental_date BETWEEN '2005-01-01 00:00:00' AND '2005-12-31 23:59:59'
b).
SELECT rental_date FROM sakila.rental
WHERE rental_date BETWEEN '2005-05-24 00:00:00' AND '2005-05-24 23:59:00'
c).
SELECT rental_date FROM sakila.rentaL
WHERE rental_date >= '2005-06-30 23:59:59'
d).
SELECT rental_date, staff_id FROM sakila.rental
WHERE (rental_date BETWEEN '2005-06-30 00:00:00' AND '2005-08-31 23:59:59') AND staff_id = 2

2). Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
a). wszystkich aktywnych klientów,
b). wszystkich aktywnych klientów albo tych, którzy zaczynają się od 'ANDRE'

a).
SELECT * FROM sakila.customer
WHERE active = 1
b).
SELECT * FROM sakila.customer
WHERE active = 1 XOR first_name LIKE 'ANDRE%'

3). Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
a). wszystkich nieaktywnych klientów ze store_id= 1
b). klientów, którzy mają adres email w innej domenie niż sakilacustomer.org. Czy istnieją tacy?
c). klientów o unikalnych wartościach w kolumnie create_date.

a).
SELECT first_name, last_name, active, store_id FROM sakila.customer
WHERE active = 0 AND store_id = 1 
b).
SELECT first_name, last_name, email FROM sakila.customer
WHERE email NOT LIKE '%sakilacustomer.org'
c).
SELECT DISTINCT create_date FROM sakila.customer;

4) Zapoznaj się ze strukturą sakila.actor_analytics a następnie napisz kwerendy, które:
a). wyświetlą aktorów, którzy grali w ponad 25 filmach,
b). wyświetlą aktorów, którzy grali w ponad 20 filmach i ich średni rating przekracza 3.3,
c). wyświetlą aktorów, którzy grali w ponad 20 filmach i ich średni rating przekracza 3.3
lub wpływy z wypożyczeń (actor_payload) przekroczyły 2000.

a).
SELECT first_name, last_name, films_amount FROM sakila.actor_analytics
WHERE films_amount > 25;
b).
SELECT first_name, last_name, films_amount, avg_film_rate FROM sakila.actor_analytics
WHERE films_amount > 20 AND avg_film_rate > 3.3;
c).
SELECT first_name, last_name, films_amount, avg_film_rate, actor_payload FROM sakila.actor_analytics
WHERE films_amount > 20 AND ( avg_film_rate > 3.3 OR actor_payload > 2000 );

----------------------------------------FORMATOWANIE DANYCH WYJSCIOWYCH-------------------------------------------------

1).Wyświetl dane z sakila.rental nadając aliasy dla kolumn według poniższych wymagań (użyj jednego zapytania, wyświetl na 4 spsoby) :

a).
- kolumny rental_id, inventory_id, customer_id pozostaw bez zmian,
- zmień kolumnę rental_date na date_of_rental,
- zmień kolumnę return_date na date_of_rental_return,
- kolumny wypisz w wybranej przez siebie kolejności

a).
SELECT rental_id, inventory_id, customer_id, rental_date AS date_of_rental,
        return_date AS date_of_rental_return FROM sakila.rental

SELECT rental_id, inventory_id, customer_id, rental_date AS "date_of_rental",
        return_date AS "date_of_rental_return" FROM sakila.rental                                                                                      
                                                                                      
SELECT rental_id, inventory_id, customer_id, rental_date date_of_rental,
        return_date date_of_rental_return FROM sakila.rental

SELECT rental_id, inventory_id, customer_id, rental_date "date_of_rental",
        return_date "date_of_rental_return" FROM sakila.rental

2).Wyświetl dane z sakila.rental ( dwoma sposobami ) tłumacząc przy tym nazwy kolumn z angielskiego na polski według poniższych wymagań :

a).rental_id - id wypożyczenia,
b).inventory_id - id przedmiotu,
c).rental_date - data wypożyczenia,
d).return_date - data zwrotu.

a).
SELECT rental_id "id wypożyczenia" FROM sakila19_5.rental;
SELECT rental_id AS "id wypożyczenia" FROM sakila19_5.rental;
b).
SELECT inventory_id "id przedmiotu" FROM sakila19_5.rental;
SELECT inventory_id AS "id przedmiotu" FROM sakila19_5.rental;
c).
SELECT rental_date "data wypożyczenia" FROM sakila19_5.rental;
SELECT rental_date AS "data wypożyczenia" FROM sakila19_5.rental;
d)
SELECT return_date "data zwrotu" FROM sakila19_5.rental;
SELECT return_date AS "data zwrotu" FROM sakila19_5.rental;

3).W tabeli sakila.payment znajdują się informacje o płatnościach dokonywanych przez klientów wypożyczalni DVD.
Napisz kwerendę, która wyświetli kolumnę payment_date w następujących formatach:

a).'rok_2 cyfry / miesiąc_numeryczny / dzień_miesiaca_numeryczny',
b).'rok_4 cyfry - nazwa_miesiąca - dzień_tygodnia_numeryczny',
c).'rok_4 cyfry - numer_tygodnia_roku',
d).'rok_2 cyfry / nazwa_miesiąca/dzień_nazwa_dnia_tygodnia',
e).'rok_4 cyfry / miesiąc_numeryczny / dzień_tygodnia_numeryczny'.

a).
SELECT DATE_FORMAT(payment_date,'%y/%m/%d') FROM sakila.payment
b).
SELECT DATE_FORMAT(payment_date,'%Y-%M-%w') FROM sakila.payment
c).
SELECT DATE_FORMAT(payment_date,'%Y-%v') FROM sakila.payment
d).
SELECT DATE_FORMAT(payment_date,'%y/%M/%W') FROM sakila.payment
e).
SELECT DATE_FORMAT(payment_date,'%Y/%m/%w') FROM sakila.payment

4).
Zapoznaj się z metodą GET_FORMAT(), która posiada predefiniowane formaty wybranych standardów wyświetlania dat
i sformatuj kolumnę payment_date z tabeli sakila.payment, zgodnie ze standardem USA.
Tak powstałą kolumnę nazwij payment_date_usa_formatted.
Wskazówka: użycie metody jest następujące - GET_FORMAT(DATE, NAZWA_FORMATU).

SELECT DATE_FORMAT(payment_date,GET_FORMAT(DATE,'USA')) FROM sakila19_5.payment;

5).
Używając sakila.film_list, napisz i wykonaj kwerendę, która:

a).zwróci najmniejszą wartość z kolumn price, length,
b).zwróci najmniejszą wartość z kolumn price, length, rating.
Jaka jest różnica pomiędzy wynikami podpunktu 1. oraz 2.? Skąd się ona bierze?

a).
SELECT LEAST(price,length) FROM sakila19_5.film_list;
b).
SELECT LEAST(price,length,rating) FROM sakila19_5.film_list;

6).Na podstawie sakila.film_list napisz i wykonaj kwerendę, która:

a).zwróci największą wartość z kolumn price, length,
b).zwróci największą wartość z kolumn price, length, rating.
Dodatkowo, obok wywołania samej funkcji, w wyniku wyświetl kolumny składowe,
które przekazujesz do funkcji, tj. np. price.

a).
SELECT GREATEST(price,length),price,length FROM sakila19_5.film_list;
b).
SELECT GREATEST(price,length,rating),price,length,rating FROM sakila19_5.film_list;

-----------------------------------------------UNION--------------------------------------------------------------------

1).Używając tabel:
   sakila.customer,
   sakila.actor,
   sakila.staff
Wyświetl wszystkie imiona osób bez powtórzeń (uzyj dwoch sposobow)

a).
SELECT first_name FROM sakila.customer
UNION 
SELECT first_name FROM sakila.actor
UNION
SELECT first_name FROM sakila.staff

b).
SELECT first_name FROM sakila.customer
UNION DISTINCT
SELECT first_name FROM sakila.actor
UNION DISTINCT
SELECT first_name FROM sakila.staff

2).Korzystając z własności, że UNION zwraca domyślnie zbiór, zmodyfikuj poniższą kwerendę tak,
aby zwracała kategorię filmów (category) bez powtórzeń (nie używaj tutaj klauzuli DISTINCT, uzyj dwoch sposobow):

a).
SELECT category FROM sakila19_5.nicer_but_slower_film_list
UNION
SELECT category FROM sakila19_5.nicer_but_slower_film_list;
b).
SELECT category FROM sakila19_5.nicer_but_slower_film_list
UNION DISTINCT
SELECT category FROM sakila19_5.nicer_but_slower_film_list;

3). Zakładając iż zbiór A to 'Kot', zbiór B to 'Pies', zbiór C to 'Kot' wyswietl sume zbiorow A,B,C zachowujac duplikaty.

SELECT 'Kot'
UNION ALL
SELECT 'Pies'
UNION ALL
SELECT 'Kot'

------------------------------------------------PODZAPYTANIA-------------------------------------------------------------

1).Używając danych zawartych w sakila.sales_by_store oraz sakila.sales_total znajdź te sklepy,
których całkowita sprzedaż przekracza połowę sprzedaży całkowitej wypożyczalni.

SELECT * FROM sakila19_5.sales_by_store
WHERE total_sales > ( SELECT total_sales/2 FROM sakila19_5.sales_total);

2)Zapoznaj się ze strukturą sakila.rating_analytics, która posiada zagregowane informacje dotyczące poszczególnych
ratingów filmowych oraz dla wszystkich filmów. Następnie wykonaj następujące działania:

a).Analizując tylko strukturę danych, zastanów się, który wiersz może wyznaczać statystyki dla wszystkich ratingów
(bez podziału na rating),
b).Znajdź te ratingi, które są wyższe od średniej wyznaczonej dla wszystkich filmów, bez podziału na rating,
c).Znajdź te ratingi, których średni czas wypożyczenia jest krótszy od średniej globalnej,
d).Używając podzapytania wyświetl statystyki dla rating_id = 3,
e).Używając podzapytania wyświetl statystyki dla rating_id = 3, 2, 5.
f). Napisz kwerendę, która powie, który rating cieszy się największą popularnością.
g). Napisz kwerendę, która odpowie, z którego ratingu filmy są średnio najkrótsze.

c).
SELECT * FROM sakila19_5.rating_analytics
WHERE avg_rental_duration < (SELECT AVG(avg_rental_duration) FROM sakila19_5.rating_analytics);
d).
SELECT * FROM sakila19_5.rating_analytics
WHERE rating = (SELECT rating FROM sakila19_5.rating WHERE id_rating = 3)
e).
SELECT * FROM sakila19_5.rating_analytics
WHERE rating IN (SELECT rating FROM sakila19_5.rating WHERE id_rating IN (3,2,5));
f)
SELECT rating,rentals FROM sakila19_5.rating_analytics
WHERE rentals = (SELECT max(rentals) FROM sakila19_5.rating_analytics);
g).
SELECT rating, avg_film_length FROM sakila19_5.rating_analytics
WHERE avg_film_length = (SELECT min(avg_film_length) FROM sakila19_5.rating_analytics);

4).Znajdź te wypożyczenia, dla których występują wpłaty czyli jest określone rental_id w sakila.payment.

SELECT * FROM sakila.rental
WHERE rental_id IN (SELECT rental_id FROM sakila.payment);

5).Znajdź wypożyczenia z sakila.rental przypisane do pracownika o imieniu Jon:

SELECT * FROM sakila.rental
WHERE staff_id = ( SELECT staff_id FROM sakila.staff WHERE first_nam e= 'Jon' )
