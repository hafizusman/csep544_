----------------------------
--- Q C1
----------------------------
SELECT A.fname, A.lname
FROM ACTOR AS A, MOVIE AS M, CASTS AS C
WHERE A.id=C.pid AND M.id=C.mid AND M.name='Officer 444';
----------------------------
--- Returns 13 rows
----------------------------
