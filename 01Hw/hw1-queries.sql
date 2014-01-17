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

