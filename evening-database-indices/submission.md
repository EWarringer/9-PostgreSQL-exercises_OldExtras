## **DATABASE INDICES**


### 1. Find all rows that have an ingredient `name` of `Brussels sprouts`.

###### _code:_

    SELECT * FROM ingredients
    WHERE name='Brussels sprouts';

* There are 1 Million files in the table `Ingredients` and when we run a query on it, it will take at least a few seconds to complete its search.

* An index is used to speed up the performance of queries. It does this by reducing the number of database data pages that have to be visited/scanned.
(*[Source](http://stackoverflow.com/questions/2955459/what-is-an-index-in-sql)*)
* As the reading [Database Indexes](https://learn.launchacademy.com/lessons/database-indexes) stated, we call the index on only the most frequently used column. In this case, that is the `name` column and the code looks like this:

    CREATE INDEX ON ingredients(name);

*Before Index*
![alt](http://i.imgur.com/qFgyjX6.png)
*After Index*
![alt](http://i.imgur.com/KJ5iEcQ.jpg)

### 2. Calculate the total count of rows of ingredients with a `name` of `Brussels sprouts`.

###### _code:_

    SELECT COUNT(*) FROM ingredients
    WHERE name='Brussels sprouts';

*Before Index
![alt](http://i.imgur.com/rllGqpM.png)
After Index *
![alt](http://i.imgur.com/XSmEJIi.jpg)

### 3. Find all `Brussels sprouts` ingredients having a unit type of `gallon(s)`.


###### _code:_

    SELECT name FROM ingredients
    WHERE name='Brussels sprouts' AND unit='gallon(s)';

*Before Index
![alt](http://i.imgur.com/SQK5prW.png)
After Index*
![alt](http://i.imgur.com/6OlSszc.jpg)


### 4. Find all rows that have a unit type of `gallon(s)`, a name of `Brussels sprouts` or has the letter `j` in it.

###### _code:_

    SELECT count(*) FROM ingredients
    WHERE unit='gallon(s)' OR name='Brussels sprouts'
    OR name LIKE '%j%';

*Before Index
![alt](http://i.imgur.com/1qU4Pwl.jpg)
After Index*
![alt](http://i.imgur.com/1xafcO2.png)

* The fourth query doesn't improve much, even after putting an index on the `name` column of the table. I searched for a solution but discovered that the index is slow because of our  `LIKE '%j%'` operator
(*[Source](http://www.brentozar.com/archive/2010/06/sargable-why-string-is-slow/)*)
