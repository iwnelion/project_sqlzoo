-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962

-- 2. Give year of 'Citizen Kane'.
select yr from movie where title='Citizen Kane'

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies
--  include the words Star Trek in the title). Order results by year.
select id, title, yr from movie where title like '%Star Trek%' order by yr

-- 4. What id number does the actor 'Glenn Close' have?
select id from actor
where name='Glenn Close'

-- 5. What is the id of the film 'Casablanca'
select id from movie 
where title='Casablanca'

-- 6. Obtain the cast list for 'Casablanca'.
select name from actor a join casting c on c.actorid=a.id where movieid=11768

-- 7. Obtain the cast list for the film 'Alien'
select name from actor a join casting c on a.id=c.actorid join movie on movie.id=c.movieid 
where movie.title='Alien'

-- 8. List the films in which 'Harrison Ford' has appeared
select movie.title from movie
join casting on casting.movieid=movie.id 
join actor on actor.id=casting.actorid
where actor.name='Harrison Ford'

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. 
-- [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
select movie.title from movie
join casting on casting.movieid=movie.id 
join actor on actor.id=casting.actorid
where actor.name='Harrison Ford' and casting.ord>1

-- 10. List the films together with the leading star for all 1962 films.
select distinct movie.title, actor.name from movie
join casting on casting.movieid=movie.id 
join actor on actor.id=casting.actorid
where yr=1962 and casting.ord=1

-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies 
-- he made each year for any year in which he made more than 2 movies.
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
select movie.title, actor.name from movie
join casting on (casting.movieid=movie.id and casting.ord=1)
join actor on actor.id=casting.actorid where movie.id in (select movieid from casting 
where actorid in (select id from actor where name='Julie Andrews'))

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
select actor.name from actor 
join casting on casting.actorid=actor.id 
where casting.ord=1 
group by casting.actorid
having count(casting.actorid) >=15
order by actor.name

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
select movie.title, count(casting.actorid) as actorNum 
from movie
join casting on casting.movieid=movie.id
join actor on casting.actorid=actor.id
where movie.yr=1978
group by movie.title
order by actorNum desc, movie.title

-- 15. List all the people who have worked with 'Art Garfunkel'.
select actor.name from actor 
join casting on actor.id=casting.actorid
where casting.movieid in (select movieid from casting 
where actorid=(select id from actor where name='Art Garfunkel')) 
having actor.name!='Art Garfunkel'