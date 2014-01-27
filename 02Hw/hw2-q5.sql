SELECT * FROM SALES; -- 426 rows

SELECT DISTINCT name FROM SALES; -- 36 rows
SELECT DISTINCT discount FROM SALES; -- 3 rows
SELECT DISTINCT month FROM SALES; -- 12 rows
SELECT DISTINCT price FROM SALES; -- 9 rows

----------------------------------------------------------------
-- Q4 part ii
--
-- Queries used to determine functional dependencies
-- I first created a list of all possible sets of 
-- attributes and ran a query similar to the ones below
-- for all of them.
----------------------------------------------------------------
SELECT MAX(A)
FROM	(
	SELECT name, count(DISTINCT month) AS A
	FROM SALES
	GROUP BY name
	) B
; -- name is not FD month

SELECT MAX(A)
FROM	(
	SELECT name, count(DISTINCT price) AS A
	FROM SALES
	GROUP BY name
	) B
; -- name->price


SELECT MAX(A)
FROM	(
	SELECT month, count(DISTINCT discount) AS A
	FROM SALES
	GROUP BY month
	) B
; -- month->discount

----------------------------------------------------------------
-- Q4 part iii
--
----------------------------------------------------------------
