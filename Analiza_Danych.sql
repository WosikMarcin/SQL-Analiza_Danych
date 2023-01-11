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
