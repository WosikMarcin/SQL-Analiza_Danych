1).Napisz zapytania, które wyświetlą informacje (sakila.rental) na podstawie poniższych kryteriów:
- wypożyczeniach z roku 2005,
- wypożyczeniach z dnia 2005-05-24,
- wypożyczeniach po 2005-06-30,
- wypożyczeniach w trakcie wakacji, tj. pomiędzy 2005-06-30,
a 2005-08-31 od pracownika Jon'a (sprawdź najpierw jaki ma staff_id w sakila.staff).

2). Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
- wszystkich aktywnych klientów,
- wszystkich aktywnych klientów albo tych, którzy zaczynają się od 'ANDRE'.

3). Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
- wszystkich nieaktywnych klientów ze store_id= 1
- klientów, którzy mają adres email w innej domenie niż sakilacustomer.org. Czy istnieją tacy?
- klientów o unikalnych wartościach w kolumnie create_date.

4) Zapoznaj się ze strukturą sakila.actor_analytics a następnie napisz kwerendy, które:
- wyświetlą aktorów, którzy grali w ponad 25 filmach,
- wyświetlą aktorów, którzy grali w ponad 20 filmach i ich średni rating przekracza 3.3,
- wyświetlą aktorów, którzy grali w ponad 20 filmach i ich średni rating przekracza 3.3
lub wpływy z wypożyczeń (actor_payload) przekroczyły 2000.