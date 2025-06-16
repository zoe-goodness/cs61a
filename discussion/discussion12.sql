-- question1
select name from pizzas where open < 13 order by name desc;
-- question2
select name, max(14 - open, 0) as duration from pizzas where close >= 14 order by duration desc;
-- question3
SELECT name || " closes at " || close AS status FROM pizzas, meals WHERE meal = 'snack' and close >= time;
-- question4
-- Two meals at the same place
  SELECT a.meal AS first, b.meal AS second, name
  FROM meals as a, meals as b, pizzas
  WHERE b.time - a.time > 6 and b.meal != a.meal and close >= b.time and open <= a.time;

