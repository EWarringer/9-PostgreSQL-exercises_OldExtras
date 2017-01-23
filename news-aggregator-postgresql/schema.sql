-- If you want to run this schema repeatedly you'll need to drop
-- the table before re-creating it. Note that you'll lose any
-- data if you drop and add a table:



-- Define your schema here:

CREATE TABLE articles (
  title VARCHAR(100),
  url VARCHAR(100),
  description VARCHAR(255)
);

CREATE UNIQUE INDEX site_index
ON articles(url);
