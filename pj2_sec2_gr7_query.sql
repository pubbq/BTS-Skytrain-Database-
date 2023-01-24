USE btsskytrain ;
-- 1 List of all passengers' ages.
SELECT CURDATE() AS Today,Psg_ID AS `Passenger ID`, Psg_BD AS `Passenger's Date of Birth`, ( YEAR(CURDATE()) - YEAR(Psg_BD) ) AS Age
FROM passenger 
ORDER BY ( YEAR(CURDATE()) - YEAR(Psg_BD) ) ASC ;
-- 2 List of the passenger ID of passengers who can purchase a student rabbit card.
SELECT Psg_ID AS `Passenger's ID`, ( YEAR(CURDATE()) - YEAR(Psg_BD) ) AS `Age under 23`
FROM passenger 
WHERE ( YEAR(CURDATE()) - YEAR(Psg_BD) ) < 23 
ORDER BY ( YEAR(CURDATE()) - YEAR(Psg_BD) ) ASC ;
-- 3 List of orders that were made in the year between 2020 to 2022.
SELECT Order_No, YEAR(Order_DateTime) AS `Year`,DATE(Order_DateTime) AS `Date`, TIME(Order_DateTime) AS `Time`
FROM setorder
WHERE YEAR (Order_DateTime) >= 2020 AND YEAR(Order_DateTime) <= 2022 
ORDER BY YEAR(Order_DateTime) ASC ;
-- 4 List of the ticket IDs of the Rabbit card that have the balance on their ticket.
SELECT Ticket_ID AS `Ticket ID`, balance AS Balance
FROM ticket
WHERE balance > 0 
ORDER BY balance ASC ; 
-- 5 List of the ticket IDs that have an expiration year before 2022.
SELECT Ticket_ID AS `Ticket ID`, YEAR(Expiration_Date) AS `Year`,Expiration_Date AS `Expiration Date`
FROM ticket
WHERE YEAR(Expiration_Date) < 2022 
ORDER BY YEAR(Expiration_Date) DESC ;
-- 6 List of the orders that have the ticket quantity equals to 1.
SELECT Order_No AS `Order No`, Ticket_Quantity AS `Ticket Quantity`, Date(Inv_Datetime) AS `Date`
FROM invoice inv
INNER JOIN invoiceline invl ON inv.INV_No = invl.INV_No
WHERE Ticket_Quantity = 1 ;
-- 7 List of the orders of passengers that purchased Rabbit cards.
SELECT o.Order_No AS `Order No`, m.Psg_ID AS `Passenger ID`, t.Ticket_Type AS `Ticket type`
FROM setorder o
INNER JOIN make m ON m.Order_No = o.Order_No
INNER JOIN ticket t ON t.Order_No = o.Order_No
WHERE Ticket_Type = "Rabbit card" 
ORDER BY o.Order_No ASC ;
-- 8 The total number of orders that passengers purchased was the Rabbit card and Single journey ticket.
SELECT COUNT(Order_No) AS `Number of order`, Ticket_Type AS `Ticket type`
FROM invoice inv 
INNER JOIN invoiceline invl ON inv.INV_No = invl.INV_No
GROUP BY Ticket_Type 
ORDER BY COUNT(Order_No) ASC ;
-- 9 List of the order IDs that have the highest total Price in each year.
SELECT YEAR(o.Order_DateTime) AS Year, o.Order_No AS 'Order ID', MAX(TotalPrice) AS `The highest total price` 
FROM setorder o
INNER JOIN invoice inv ON inv.Order_No = o.Order_No
GROUP BY YEAR(o.Order_DateTime)
ORDER BY YEAR(o.Order_DateTime) ASC ;
-- 10 The date and amount of cases that the passenger went to the destination "Siam".
SELECT DATE(o.Order_DateTime) AS `Date`, COUNT(t.Order_No) AS `Amount` ,Destination
FROM ticket t
INNER JOIN setorder o ON o.Order_No = t.Order_No
INNER JOIN singlejourneyticket s ON s.Ticket_ID = t.Ticket_ID
WHERE s.Destination = "Siam" 
GROUP BY DATE(o.Order_DateTime) ;
-- 11 List of the ticket sellers that are open.
SELECT Staff_ID AS "Staff ID", Counter_ID AS "Counter ID", CONCAT(FirstName," ", LastName) AS "Full Name"
FROM ticketseller
WHERE Tk_Status = "O" ;
-- 12 The number of Cash payments and QR Code payments that were made before 2020.
SELECT Pm_Method AS "Payment Method", COUNT(Pm_ID) AS "Total of payment before 2020"
FROM payment
WHERE YEAR(Pm_DateTime) < "2020"
GROUP BY Pm_Method ;
-- 13 List of the top 10 invoices that have the highest value of the total price.
SELECT Inv_No AS "Invoice ID", TotalPrice AS "Total Price", Inv_DateTime AS "Invoice Date-Time", Order_No AS "Order Number"
FROM invoice
ORDER BY TotalPrice DESC
LIMIT 10 ;
-- 14 The average price that people paid for tickets in 2021.
SELECT YEAR(Inv_DateTime) AS "Year", ROUND(AVG(TotalPrice), 2) AS "Average price"
FROM invoice
WHERE YEAR(Inv_DateTime) = "2021";
-- 15 The total number of orders that were made in 2018 to 2022.
SELECT YEAR(Order_DateTime) AS "Year",COUNT(Order_No) AS "Total number of order"
FROM setorder
WHERE YEAR(Order_DateTime) <= "2022" AND YEAR(Order_DateTime) >= "2018"
GROUP BY YEAR(Order_DateTime)
ORDER BY YEAR(Order_DateTime) ASC ;
-- 16 List of the passengers who have the Student Rabbit Card.
SELECT Psg_ID AS "Passenger ID", t.Ticket_ID AS "Student Ticket ID", Balance
FROM make m
LEFT OUTER JOIN ticket t ON m.Order_No = t.Order_No
INNER JOIN rabbitcard r ON t.Ticket_ID = r.Ticket_ID
WHERE Card_Type = "Student" ;
-- 17 List of the passengers who have the Adult Rabbit Card. 
SELECT Psg_ID AS "Passenger ID", t.Ticket_ID AS "Adult Ticket ID", Balance
FROM make m
LEFT OUTER JOIN ticket t ON m.Order_No = t.Order_No
INNER JOIN rabbitcard r ON t.Ticket_ID = r.Ticket_ID
WHERE Card_Type = "Adult" ;
-- 18 List of the passengers who have the Senior Rabbit Card.
SELECT Psg_ID AS "Passenger ID", t.Ticket_ID AS "Senior Ticket ID", Balance
FROM make m
LEFT OUTER JOIN ticket t ON m.Order_No = t.Order_No
INNER JOIN rabbitcard r ON t.Ticket_ID = r.Ticket_ID
WHERE Card_Type = "Senior" ;
-- 19 List of the top 5 order numbers that bought the highest quantity of Single Journey Tickets.
SELECT m.Order_No AS "Order ID", COUNT(Ticket_Quantity) AS "Ticket Quantity", SUM(Ticket_Price*Ticket_Quantity) AS "Ticket Price"
FROM make m
LEFT OUTER JOIN invoice i ON m.Order_No = i.Order_No
LEFT OUTER JOIN invoiceline il ON i.INV_No = il.INV_No
WHERE Ticket_Type = "Single Journey"
GROUP BY m.Order_No
ORDER BY COUNT(Ticket_Quantity) DESC
LIMIT 5 ;
-- 20 List of the total of the orders that were made and the total money paid in each year.
SELECT YEAR(Order_DateTime) AS "Year", COUNT(i.Order_No) AS "Total number of Order", SUM(TotalPrice) AS "Total number of income from orders"
FROM setorder s
LEFT OUTER JOIN invoice i ON s.Order_No = i.Order_No
GROUP BY YEAR(Order_DateTime)
ORDER BY YEAR(Order_DateTime) ASC ;
-- 21 List of the passenger ID of passengers who can purchase a senior rabbit card.
SELECT Psg_ID AS `Passenger's ID`, (YEAR(CURDATE()) - YEAR(Psg_BD)) AS `Age more than 60`
FROM passenger
WHERE ( YEAR(CURDATE()) - YEAR(Psg_BD) ) >= 60
ORDER BY ( YEAR(CURDATE()) - YEAR(Psg_BD) ) ASC ;
-- 22 List of the passengers who are the students.
SELECT Psg_ID AS `Passenger ID`, Psg_Occupation AS `Passenger Occupation`
FROM passenger 
WHERE Psg_Occupation = "Student" 
ORDER BY Psg_ID ASC ;
-- 23 List of all the ticket sellers who sold tickets.
SELECT DISTINCT t.Staff_ID AS "Staff ID", CONCAT(FirstName," ", LastName) AS "Full Name"
FROM ticket t
INNER JOIN ticketseller ts ON t.Staff_ID = ts.Staff_ID ;
-- 24 List of all passenger’ IDs who were born before 2000-01-01.
SELECT Psg_BD AS "Passenger's Date of Birth", Psg_ID AS `Passenger ID`
FROM passenger 
WHERE Psg_BD < "2000-01-01"
ORDER BY Psg_BD ASC ;
-- 25 List of all the tickets that have an expiration date after 2019.
SELECT YEAR(Expiration_Date) AS "Expiration Year", Ticket_ID AS "Ticket ID"
FROM ticket 
WHERE YEAR(Expiration_Date)  > "2019"
ORDER BY YEAR(Expiration_Date) ;
-- 26 List of passengers who are older than the average of all passenger ages.
SELECT Psg_ID AS `Passenger ID`, Psg_BD AS "Passenger's Date of Birth", ( YEAR(CURDATE()) - YEAR(Psg_BD) ) AS Age
FROM passenger 
WHERE ( YEAR(CURDATE()) - YEAR(Psg_BD) ) > (SELECT AVG((YEAR(CURDATE()) - YEAR(Psg_BD))) 
											FROM passenger)
ORDER BY ( YEAR(CURDATE()) - YEAR(Psg_BD) ) ASC ;
-- 27 List of all the passenger's IDs that purchased the single journey ticket.
SELECT o.Order_No AS `Order No`, m.Psg_ID AS `Passenger ID`, t.Ticket_Type AS `Ticket type`
FROM setorder o
INNER JOIN make m ON m.Order_No = o.Order_No
INNER JOIN ticket t ON t.Order_No = o.Order_No
WHERE Ticket_Type = "Single Journey" 
ORDER BY o.Order_No ASC ;
-- 28 List the orders that have a higher total price than the average total price of all orders.
SELECT m.Order_No AS "Order ID", TotalPrice AS "Total Price"
FROM make m
LEFT OUTER JOIN invoice i ON m.Order_No = i.Order_No
WHERE TotalPrice > (SELECT AVG(TotalPrice)
					FROM invoice)
ORDER BY TotalPrice DESC;
-- 29 The range of ticket quantity that was purchased each year.
SELECT YEAR(Inv_DateTime) AS Year, CONCAT("[ ",MIN(Ticket_Quantity)," , ",MAX(Ticket_Quantity)," ]") AS `Quantity range`
FROM invoice i 
INNER JOIN invoiceline il ON i.INV_No = il.INV_No
GROUP BY YEAR(Inv_DateTime)
ORDER BY YEAR(Inv_DateTime) ASC ;
-- 30 List the top 5 invoices that contain the highest ticket quantities.
SELECT DISTINCT il.INV_No AS "Invoice No" ,SUM(Ticket_Quantity) AS "Ticket Quantity"
FROM invoiceline il
LEFT OUTER JOIN invoice i ON il.INV_No = i.INV_No
GROUP BY il.INV_No
ORDER BY SUM(Ticket_Quantity) DESC
LIMIT 5 ;
-- 31 List the most popular occupation among the passengers.
SELECT Psg_Occupation AS "Occupation", COUNT(Psg_Occupation) AS "Total of passengers"
FROM passenger
GROUP BY Psg_Occupation
ORDER BY COUNT(Psg_Occupation) DESC
LIMIT 1 ;
-- 32 List of the ticket sellers that are close.
SELECT Staff_ID AS "Staff ID", Counter_ID AS "Counter ID", CONCAT(FirstName," ", LastName) AS "Full Name"
FROM ticketseller
WHERE Tk_Status = "C" ;
-- 33 List of the total number of orders that were made between 6.00 AM to 10.00 AM.
SELECT CONCAT(HOUR(Order_DateTime),":00") AS "Time", COUNT(Order_No) AS "Total of order"
FROM setorder
WHERE HOUR(Order_DateTime) BETWEEN "06:00:00" AND "10:00:00"
GROUP BY HOUR(Order_DateTime)
ORDER BY HOUR(Order_DateTime) ASC ;
-- 34 The average total price of all orders.
SELECT ROUND(AVG(TotalPrice),2) AS "Average total price"
FROM invoice ;
-- 35 List of the top 5 invoices that have the lowest value of the total price.
SELECT Inv_No AS "Invoice ID", TotalPrice AS "Total Price", Inv_DateTime AS "Invoice Date-Time", Order_No AS "Order Number"
FROM invoice
ORDER BY TotalPrice ASC
LIMIT 5 ;
-- 36 List of the invoices that showed the purchase history of only Single Journey Ticket but not Rabbit Card.
SELECT DISTINCT il.INV_No AS "Invoice No", Inv_DateTime AS "Invoice Date-Time"
FROM invoiceline il
RIGHT OUTER JOIN invoice i ON il.INV_No = i.INV_No
WHERE  il.INV_No NOT IN (SELECT il.INV_No
						FROM invoiceline il
						LEFT OUTER JOIN invoice i ON il.INV_No = i.INV_No
						WHERE Ticket_Type = "Rabbit card") ;
-- 37 List the invoices that showed the purchase history of only Rabbit Card but not Single Journey Ticket.
SELECT DISTINCT il.INV_No AS "Invoice No", Inv_DateTime AS "Invoice Date-Time"
FROM invoiceline il
RIGHT OUTER JOIN invoice i ON il.INV_No = i.INV_No
WHERE il.INV_No NOT IN (SELECT il.INV_No
						FROM invoiceline il
						LEFT OUTER JOIN invoice i ON il.INV_No = i.INV_No
						WHERE Ticket_Type = "Single Journey") ;
-- 38 List of the top 3 ticket sellers who sold the most tickets.
SELECT CONCAT(FirstName," ",LastName) AS `Staff Name`, t.Staff_ID AS 'Staff ID', COUNT(Ticket_ID) AS `Number of ticket`
FROM ticket t
INNER JOIN ticketseller ts ON t.Staff_ID = ts.Staff_ID
GROUP BY t.Staff_ID 
ORDER BY COUNT(Ticket_ID) DESC
LIMIT 3 ;
-- 39 List of the average quantity of ticket that was purchased each year.
SELECT YEAR(Order_DateTime) AS "Year", ROUND(AVG(Ticket_Quantity)) AS "Average Ticket Quantity"
FROM setorder s
LEFT OUTER JOIN invoice i ON s.Order_No = i.Order_No
LEFT OUTER JOIN invoiceline il ON i.INV_No = il.INV_No
GROUP BY YEAR(Order_DateTime)
ORDER BY YEAR(Order_DateTime) ASC ;
-- 40 List of the top 5 order numbers that bought the highest quantity of the Rabbit card.
SELECT m.Order_No AS "Order ID", Ticket_Quantity AS "Ticket Quantity", Subtotal_Price AS "Ticket Price"
FROM make m
INNER JOIN invoice i ON m.Order_No = i.Order_No
LEFT OUTER JOIN invoiceline il ON i.INV_No = il.INV_No
WHERE Ticket_Type = "Rabbit card"
GROUP BY i.Order_No
ORDER BY Ticket_Quantity DESC
LIMIT 5 ;
