-- in order to speed up the selection in queries 1, 3, 6, 11 as well joins for these queries
CREATE UNIQUE INDEX index_actor_id ON ACTOR (id);

-- in order to speed up the selection in query 5, 11 as well as for join of query 11
CREATE INDEX index_actor_fname ON ACTOR (fname);

-- in order to speed up the selection in query 5, 11 as well as for join of query 11
CREATE INDEX index_actor_lname ON ACTOR (lname);

-- in order to speed up the selection in query 5, 6
CREATE INDEX index_actor_gender ON ACTOR (gender);

-- in order to speed up the join and selection in queries 1, 2, 7, 8 and join in 9
CREATE UNIQUE INDEX index_movie_id ON MOVIE (id);

-- in order to speed up the selection and join for 2, 3, 5, 6, 8, 10
CREATE INDEX index_movie_year ON MOVIE (year);

-- in order to speed up the join for 2, 4 and selection for 4
CREATE UNIQUE INDEX index_directors_id ON DIRECTORS (id);

-- in order to speed up the join and selection for 1, 3, 5, 6, 7, 8, 9, 11
CREATE INDEX index_casts_pid ON CASTS (pid);

-- in order to speed up the join and selection for 1, 3, 5, 6, 7, 8, 9, 11
CREATE INDEX index_casts_mid ON CASTS (mid);

-- in order to speed up the having for 5, 6
CREATE INDEX index_casts_role ON CASTS (role);

