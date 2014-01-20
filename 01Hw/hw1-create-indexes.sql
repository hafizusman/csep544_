CREATE UNIQUE INDEX index_actor_id ON ACTOR (id);
CREATE UNIQUE INDEX index_movie_id ON MOVIE (id);
CREATE UNIQUE INDEX index_directors_id ON DIRECTORS (id);
CREATE INDEX index_movie_year ON MOVIE (year);
CREATE INDEX index_casts_pid ON CASTS (pid);
CREATE INDEX index_casts_mid ON CASTS (mid);
CREATE INDEX index_casts_role ON CASTS (role);
