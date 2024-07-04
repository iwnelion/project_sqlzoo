-- 1. Modify it to show the matchid and player name for all goals scored by Germany. 
-- To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid='GER'

-- 2. Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2
  FROM game where id=1012

-- 3. The code below shows the player (from the goal) and stadium name (from the game table) f
-- or every goal scored. Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT player,teamid,stadium,mdate
  FROM game JOIN goal ON (game.id=goal.matchid)
where teamid='GER'

-- 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player
  FROM game JOIN goal ON (game.id=goal.matchid)
where player like 'Mario%'

-- 5. The table eteam gives details of every national team including the coach. You can JOIN goal to eteam
--  using the phrase goal JOIN eteam on teamid=id
SELECT player, teamid, coach, gtime
  FROM goal join eteam on teamid=id
 WHERE gtime<=10

-- 6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
select mdate, teamname
from game join eteam on (team1=eteam.id) 
where coach='Fernando Santos'

-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
select player from goal join game on (id=matchid) where stadium='National Stadium, Warsaw'

-- 8. Show the name of all players who scored a goal against Germany.
SELECT distinct player
  FROM game JOIN goal ON matchid = id 
    WHERE (goal.teamid!='GER') and (game.team1 = 'GER' OR game.team2 = 'GER')

-- 9. Show teamname and the total number of goals scored.
SELECT teamname, count(teamid)
  FROM eteam JOIN goal ON id=teamid
 group BY teamname

-- 10. Show the stadium and the number of goals scored in each stadium.
select stadium, count(stadium) from game join goal ON game.id = goal.matchid group by stadium

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid,mdate, count(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by matchid

-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
select matchid, mdate, count(teamid) from game join goal on game.id=goal.matchid where teamid='GER' group by matchid

-- 13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" 
-- which has not been explained in any previous exercises.
SELECT game.mdate,game.team1,SUM(CASE WHEN goal.teamid=team1 THEN 1 ELSE 0 END) score1,game.team2,
SUM(CASE WHEN goal.teamid = team2 THEN 1 ELSE 0 END) score2 FROM game LEFT JOIN goal ON 
matchid = id GROUP BY id ORDER BY game.mdate, goal.matchid, game.team1, game.team2;