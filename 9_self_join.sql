-- 1. How many stops are in the database.
select count(*) from stops

-- 2. Find the id value for the stop 'Craiglockhart'
select id from stops where name='Craiglockhart'

-- 3. Give the id and the name for the stops on the '4' 'LRT' service.
select id, name from stops 
join route on stops.id=stop 
where num='4' and company='LRT'

-- 4. The query shown gives the number of routes that visit either London Road (149) or 
-- Craiglockhart (53). Run the query and notice the two services that link these stops have a 
-- count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*) 
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
having count(*)=2

-- 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, 
-- without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a 
JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop=(select id from stops where name='London Road')

-- 6. The query shown is similar to the previous one, however by joining two copies of the stops table we 
-- can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' 
-- and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a 
JOIN route b ON
  (a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name='London Road'

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
select distinct a.company, a.num from route a 
join route b on (a.company=b.company and a.num=b.num)
join stops stopa on (stopa.id=a.stop)
join stops stopb on (stopb.id=b.stop)
where stopa.name='Haymarket' and stopb.name='Leith'

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
select a.company, a.num from route a
join route b on (a.company=b.company) and (a.num=b.num)
join stops stopa on stopa.id=a.stop
join stops stopb on stopb.id=b.stop
where stopa.name='Craiglockhart' and stopb.name='Tollcross'

-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus,
--  including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
select stopb.name, a.company, a.num from route a 
join route b on (a.company=b.company and a.num=b.num)
join stops stopa on (stopa.id=a.stop)
join stops stopb on (stopb.id=b.stop)
where (a.company='LRT') and (stopa.name='Craiglockhart')

-- 10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.
select distinct bus1.num, bus1.company, t1stop.name transfer, bus2.num, bus2.company from route bus1
join route transfer1 on (bus1.num=transfer1.num) and (bus1.company=transfer1.company)
join route transfer2 on (transfer1.stop=transfer2.stop)
join route bus2 on (transfer2.num=bus2.num) and (transfer2.company=bus2.company)
join stops b1stop on (bus1.stop=b1stop.id)
join stops t1stop on (transfer1.stop=t1stop.id)
join stops t2stop on (transfer2.stop=t2stop.id)
join stops b2stop on (bus2.stop=b2stop.id)
where (b1stop.name='Craiglockhart') and (b2stop.name='Lochend')
order by bus1.num, transfer, bus2.num