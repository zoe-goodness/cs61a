CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child from parents, dogs as a,  dogs as b where child = a.name and parent = b.name order by b.height desc;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  select name, size from dogs, sizes where height > min and height <= max; 


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  select a.child as first, b.child as second from parents as a, parents as b where a.child < b.child and a.parent = b.parent;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  select "The two siblings, " || first || " and " || second || ", have the same size: " || a.size from siblings, size_of_dogs as a, size_of_dogs as b where first = a.name and second = b.name and a.size = b.size; 

-- create table temp as select fur, avg(height) as avg_height from dogs group by fur;
-- create table avg_dog_height as
-- select name, dogs.fur, height, avg_height from dogs, temp where dogs.fur = temp.fur;


create table avg_dog_height as select fur, avg(height) as avg_height from dogs group by fur;

create table temp as
select a.fur, a.avg_height from avg_dog_height as a, dogs as b where a.fur = b.fur group by b.fur having min(b.height) >= 0.7 * avg_height and max(b.height) <= 1.3 * avg_height;

-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  select b.fur, max(height) - min(height) as height_range from temp as a, dogs as b where a.fur = b.fur;

