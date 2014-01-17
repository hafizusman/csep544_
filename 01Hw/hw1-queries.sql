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

-- QUERY to see that same actor acting in movies more than 100 years apart are actually documentaries/news/shorts of themselves
SELECT A.id, M.id, M.name, M.year, G.genre, C.role
FROM ACTOR AS A, CASTS AS C, MOVIE AS M, GENRE AS G
WHERE A.id=C.pid AND C.mid=M.id
	AND A.fname='Christian IX'
	AND M.id = G.mid;

----------------------------
--- Q C4
----------------------------
SELECT D.id, D.fname, D.lname, count(*) AS mcount
FROM DIRECTORS AS D, MOVIE_DIRECTORS AS MD, MOVIE AS M
WHERE D.id=MD.did
	AND MD.mid=M.id
GROUP BY D.id
HAVING COUNT (*) > 500
ORDER BY mcount DESC;
--- Returns 47 rows


----------------------------
--- Q C5
----------------------------

