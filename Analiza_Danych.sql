--------------------------------------------------------TABELE---------------------------------------------------------
1). Utwórz tabele my_first_table a nastepnie:
a). dodaj kolumny first_col ( typ danych text ) i second_col ( typ danych datetime )
b). usuń tabele my_first_table

a).
CREATE TABLE IF NOT EXISTS my_first_table(
    first_col text,
    second_col datetime
)
b). DROP TABLE my_first_table

2). Utwórz tabele actor_nick a nastepnie:
a). wypełnij tabele na podstawie zapytania, ktore ma wyswietlic wszystkie dane z sakila.actor gdzie first_name to Nick 
b). usuń tabele actor_nick

CREATE TABLE IF NOT EXISTS actor_nick AS
SELECT * FROM sakila.actor
WHERE first_name = 'Nick'


------------------------------------------------------GRUPOWANIE--------------------------------------------------------
1).Zagreguj tabelę payment według następujących reguł:

a).wyznacz całkowitą kwotę wpływów wypożyczalni,
b).wyznacz całkowitą kwotę wpływów wypożyczalni w podziale na klientów (na razie nie pisz JOIN, użyj tylko customer_id),
c).wyznacz całkowitą kwotę wypożyczonych filmów w zależności od pracownika,
d).używając funkcji date_format wykonaj podpunkty 2. i 3. dodatkowo w rozbiciu na miesiące kalendarzowe
a wyniki posortuj malejąco według klucza: client_id/staff_id rosnąco, amount - malejąco.

a.
SELECT SUM(amount) FROM sakila19_5.payment
b).
SELECT SUM(amount) FROM sakila19_5.payment
GROUP BY customer_id
c).
SELECT COUNT(*) FROM sakila19_5.payment
GROUP BY staff_id

SELECT * FROM sakila19_5.payment
