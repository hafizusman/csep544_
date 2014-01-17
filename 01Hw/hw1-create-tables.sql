CREATE TABLE ACTOR(
	id integer PRIMARY KEY,
	fname text,
	lname text,
	gender char(1)
);
\copy ACTOR from C:\Users\Muhammad\Desktop\hw1\imdb\actor-ascii.txt with delimiter '|' csv quote E'\n'

CREATE TABLE MOVIE(
	id integer PRIMARY KEY,
	name text,
	year integer
);
\copy MOVIE from C:\Users\Muhammad\Desktop\hw1\imdb\movie-ascii.txt with delimiter '|' csv quote E'\n'

CREATE TABLE DIRECTORS(
	id integer PRIMARY KEY,
	fname text,
	lname text
);
\copy DIRECTORS from C:\Users\Muhammad\Desktop\hw1\imdb\directors-ascii.txt with delimiter '|' csv quote E'\n'

CREATE TABLE GENRE(
	mid integer,
	genre text
);
\copy GENRE from C:\Users\Muhammad\Desktop\hw1\imdb\genre-ascii.txt with delimiter '|' csv quote E'\n'

CREATE TABLE CASTS(
	pid integer REFERENCES ACTOR(id),
	mid integer REFERENCES MOVIE(id),
	role text
);
\copy CASTS from C:\Users\Muhammad\Desktop\hw1\imdb\casts-ascii.txt with delimiter '|' csv quote E'\n'

CREATE TABLE MOVIE_DIRECTORS(
	did integer REFERENCES DIRECTORS(id),
	mid integer REFERENCES MOVIE(id)
);
\copy MOVIE_DIRECTORS from C:\Users\Muhammad\Desktop\hw1\imdb\movie_directors-ascii.txt with delimiter '|' csv quote E'\n'
