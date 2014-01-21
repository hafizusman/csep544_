----------------------------
--- Q C1
----------------------------
SELECT A.fname, A.lname
FROM ACTOR AS A, MOVIE AS M, CASTS AS C
WHERE A.id=C.pid AND M.id=C.mid AND M.name='Officer 444';
--- Returns 13 rows


----------------------------
--- Q C2
----------------------------
SELECT D.fname, D.lname, M.name, M.year
FROM GENRE AS G, MOVIE_DIRECTORS AS MD, DIRECTORS AS D, MOVIE AS M
WHERE G.genre='Film-Noir' 
	AND MD.mid=G.mid 
	AND MD.did=D.id AND M.id=MD.mid 
	AND (M.year%4)=0;
--- Returns 113 rows


----------------------------
--- Q C3
----------------------------
SELECT DISTINCT A.fname, A.lname
FROM ACTOR AS A, CASTS AS C1, MOVIE AS M1, CASTS AS C2, MOVIE AS M2
WHERE A.id=C1.pid AND C1.mid=M1.id
	AND A.id=C2.pid AND C2.mid=M2.id
	AND M1.year < 1900 AND M2.year > 2000;
--- Returns 48 rows
--- I ran the following query to see that these actors are actually famous people 
--- (usually) that have been shown up in documentaries (or other non-fiction genres) as 
--- themselves hence a new movie id is created for the movie even though they're not 
--- neccessarily acting in them alive

-- QUERY to see that same actor acting in movies more than 100 years apart are actually 
-- documentaries/news/shorts of themselves
SELECT A.id, M.id, M.name, M.year, G.genre, C.role
FROM ACTOR AS A, CASTS AS C, MOVIE AS M, GENRE AS G
WHERE A.id=C.pid AND C.mid=M.id
	AND A.fname='Christian IX'
	AND M.id = G.mid;


----------------------------
--- Q C4
----------------------------
SELECT D.fname, D.lname, count(*) AS mcount
FROM DIRECTORS AS D, MOVIE_DIRECTORS AS MD, MOVIE AS M
WHERE D.id=MD.did
	AND MD.mid=M.id
GROUP BY D.fname, D.lname
HAVING COUNT (*) > 500
ORDER BY mcount DESC;
--- Returns 47 rows


----------------------------
--- Q C5
----------------------------
SELECT A.fname, A.lname, M.name, COUNT(DISTINCT C.role) AS numroles
FROM ACTOR AS A
INNER JOIN CASTS AS C ON A.id=C.pid
INNER JOIN MOVIE AS M ON M.id=C.mid
WHERE M.year=2010
GROUP BY A.fname, A.lname, M.name
HAVING COUNT(DISTINCT C.role) > 4;
--- Returns 24 rows


----------------------------
--- Q C6
----------------------------
SELECT actorid, moviename, C1.role
FROM	(
	SELECT A.id AS actorid, C.mid AS movieid, M.name AS moviename, COUNT(DISTINCT C.role) AS numroles
	FROM ACTOR AS A
	INNER JOIN CASTS AS C ON A.id=C.pid
	INNER JOIN MOVIE AS M ON M.id=C.mid
	WHERE M.year=2010
	GROUP BY A.id, C.mid, M.name
	HAVING COUNT(DISTINCT C.role) > 4
	) AS Temp
INNER JOIN CASTS C1 ON Temp.actorid=C1.pid AND Temp.movieid=C1.mid;
--- Returns 137 rows


----------------------------
--- Q C7
----------------------------
SELECT M.year, COUNT(*)
FROM MOVIE AS M
WHERE NOT EXISTS
	(
	SELECT A.id
	FROM ACTOR AS A
	INNER JOIN CASTS AS C ON A.id=C.pid
	WHERE M.id=C.mid AND A.gender!='F'
	)
GROUP BY M.year;
--- Returns 129 rows


----------------------------
--- Q C8
----------------------------
SELECT Temp1.movieyear1, ((Temp1.female_actor_movies*100.0)/Temp2.total_movie_count) AS percentage, Temp2.total_movie_count
FROM 	(
	SELECT M.year AS movieyear1, COUNT(*) AS female_actor_movies
	FROM MOVIE AS M
	WHERE NOT EXISTS
		(
		SELECT A.id
		FROM ACTOR AS A
		INNER JOIN CASTS AS C ON A.id=C.pid
		WHERE M.id=C.mid AND A.gender!='F'
		)
	GROUP BY M.year
	) AS Temp1
INNER JOIN
	(
	SELECT M.year AS movieyear2, COUNT(*) AS total_movie_count
	FROM MOVIE AS M
	GROUP BY M.year
	) AS Temp2
	ON Temp1.movieyear1=Temp2.movieyear2
ORDER BY Temp1.movieyear1;
--- Returns 128 rows


----------------------------
--- Q C9
----------------------------
SELECT Temp.moviename, Temp.castcount
FROM	(
	SELECT C.mid AS movieid, M.name AS moviename, COUNT(DISTINCT C.pid) AS castcount
	FROM CASTS AS C
	INNER JOIN MOVIE AS M ON C.mid=M.id
	GROUP BY C.mid, M.name
	) AS Temp
WHERE Temp.castcount = 
	(
	SELECT MAX(CC.castcount2) 
	FROM 
		(
		SELECT COUNT(DISTINCT pid) AS castcount2
		FROM CASTS
		GROUP BY mid
		) AS CC
	);
--- Returns 1 row: "Around the World in Eighty Days";1298


----------------------------
--- Q C10
----------------------------
SELECT decadestartingyear, MAX(movies) AS moviesindecade
FROM	(
	SELECT yearlist.year AS decadestartingyear, SUM(yearcount.count_) AS movies
	FROM 	(
		SELECT DISTINCT year 
		FROM MOVIE
		) AS yearlist,   
		(
		SELECT year, COUNT(*) AS count_ 
		FROM MOVIE 
		GROUP BY year
		) AS yearcount
	WHERE yearcount.year >= yearlist.year AND yearcount.year < (yearlist.year + 10)
	GROUP BY yearlist.year
	ORDER BY SUM (yearcount.count_) DESC
	) AS Temp
WHERE	movies =(
		SELECT MAX (movies1)
		FROM	(
			SELECT yearlist.year AS decade, SUM(yearcount.count_) AS movies1
			FROM 	(
				SELECT DISTINCT year 
				FROM MOVIE
				) AS yearlist,   
				(
				SELECT year, COUNT(*) AS count_ 
				FROM MOVIE 
				GROUP BY year
				) AS yearcount
			WHERE yearcount.year >= yearlist.year AND yearcount.year < (yearlist.year + 10)
			GROUP BY yearlist.year
			ORDER BY SUM (yearcount.count_) DESC
			) AS Temp2
		)
GROUP BY decadestartingyear;
-- Returns 1 row: 2000;457481


----------------------------
--- Q C11
----------------------------
SELECT COUNT(*)
FROM	(
	SELECT A3.fname, A3.lname 
	FROM ACTOR AS A0, CASTS C0, CASTS C1, CASTS C2, CASTS C3, ACTOR A3
	WHERE 	A0.fname = 'Kevin' AND A0.lname = 'Bacon'
		AND C0.pid = A0.id AND C0.mid = C1.mid 
		AND C1.pid = C2.pid AND C2.mid = C3.mid 
		AND C3.pid = A3.id
		AND NOT (A3.fname = 'Kevin' AND A3.lname = 'Bacon')
		AND NOT	EXISTS
			(
			SELECT C1_.pid 
			FROM ACTOR AS A0_, CASTS AS C0_, CASTS AS C1_
			WHERE 	A0_.fname = 'Kevin' AND A0_.lname = 'Bacon'
				AND A0_.id = C0_.pid AND C0_.mid = C1_.mid 
				AND C1_.pid = A3.id
			)
	GROUP BY A3.id, A3.fname, A3.lname
	) AS k;
-- Returns 1 row: 521870