/*
CREATE SEQUENCE UQIDAutoIncrement
	START 1
	INCREMENT 1;

CREATE TABLE "controlRandom10m" (
	"UQID" INTEGER NOT NULL PRIMARY KEY,
	"Category" VARCHAR(20) NOT NULL,
	"DateTimeStamp" TIMESTAMP NOT NULL
);

CREATE TABLE "category" ( 
	"CategoryID" INTEGER NOT NULL PRIMARY KEY, 
	"CategoryName" VARCHAR(255) NOT NULL 
	);

INSERT INTO "category" VALUES (1, 'A'); 
INSERT INTO "category" VALUES (2, 'B');
INSERT INTO "category" VALUES (3, 'C'); 
INSERT INTO "category" VALUES (4, 'D'); 
INSERT INTO "category" VALUES (5, 'E'); 
INSERT INTO "category" VALUES (6, 'F'); 
INSERT INTO "category" VALUES (7, 'G'); 
INSERT INTO "category" VALUES (8, 'H'); 
INSERT INTO "category" VALUES (9, 'I'); 
INSERT INTO "category" VALUES (10, 'J'); 

-- SELECT * FROM "category";
*/

ALTER SEQUENCE UQIDAutoIncrement RESTART WITH 1;

TRUNCATE TABLE "controlRandom100k";
TRUNCATE TABLE "controlRandom1m";
TRUNCATE TABLE "controlRandom10m";
TRUNCATE TABLE "deltaTestRandom100k";
TRUNCATE TABLE "deltaTestRandom1m";
TRUNCATE TABLE "deltaTestRandom10m";

INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID", 
				"c"."CategoryName", 
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c" 
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times
INSERT INTO "controlRandom10m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute 10 times

ALTER SEQUENCE UQIDAutoIncrement RESTART WITH 1;

/*
CREATE TABLE "controlRandom1m" (
	"UQID" INTEGER NOT NULL PRIMARY KEY,
	"Category" VARCHAR(20) NOT NULL,
	"DateTimeStamp" TIMESTAMP NOT NULL
);
*/

INSERT INTO "controlRandom1m" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 1000000 -- execute once

ALTER SEQUENCE UQIDAutoIncrement RESTART WITH 1;

/*
CREATE TABLE "controlRandom100k" (
	"UQID" INTEGER NOT NULL PRIMARY KEY,
	"Category" VARCHAR(20) NOT NULL,
	"DateTimeStamp" TIMESTAMP NOT NULL
);
*/

INSERT INTO "controlRandom100k" ("UQID", "Category", "DateTimeStamp")
	SELECT 	NEXTVAL('UQIDAutoIncrement') AS "UQID",
				"c"."CategoryName",
				NOW() + (RANDOM() * (INTERVAL '365 days')) AS "DateTimeStamp"
	FROM 		"category" AS "c"
	CROSS		JOIN pg_type t1 -- using this to generate large row counts
	CROSS	 	JOIN pg_type t2
	ORDER BY RANDOM() LIMIT 100000 -- execute once

/*
CREATE TABLE "deltaTestRandom10m" (
	"UQID" INTEGER NOT NULL PRIMARY KEY,
	"Category" VARCHAR(20) NOT NULL,
	"DateTimeIncrement" FLOAT -- difference in ms
); 

CREATE TABLE "deltaTestRandom1m" (
	"UQID" INTEGER NOT NULL PRIMARY KEY,
	"Category" VARCHAR(20) NOT NULL,
	"DateTimeIncrement" FLOAT -- difference in ms
);

CREATE TABLE "deltaTestRandom100k" (
	"UQID" INTEGER NOT NULL PRIMARY KEY,
	"Category" VARCHAR(20) NOT NULL,
	"DateTimeIncrement" FLOAT -- difference in ms
);
*/

-- calculate the diffs per category and insert into the deltaTestRandom10m table
-- A
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp", 
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) )) AS "diff"
FROM 	"controlRandom10m" 
WHERE "Category" = 'A' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- B
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'B' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- C
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'C' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- D
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'D' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- E
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'E' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- F
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'F' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- G
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'G' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- H
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'H' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- I
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'I' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- J
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom10m"
WHERE "Category" = 'J' )
INSERT INTO "deltaTestRandom10m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- Update the starting points (as epoch/bigint) for each A-I
UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'A'
    LIMIT 1 )
WHERE   "Category" = 'A'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'B'
    LIMIT 1 )
WHERE   "Category" = 'B'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'C'
    LIMIT 1 )
WHERE   "Category" = 'C'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'D'
    LIMIT 1 )
WHERE   "Category" = 'D'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'E'
    LIMIT 1 )
WHERE   "Category" = 'E'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'F'
    LIMIT 1 )
WHERE   "Category" = 'F'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'G'
    LIMIT 1 )
WHERE   "Category" = 'G'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'H'
    LIMIT 1 )
WHERE   "Category" = 'H'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'I'
    LIMIT 1 )
WHERE   "Category" = 'I'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom10m"
    WHERE "controlRandom10m"."Category" = 'J'
    LIMIT 1 )
WHERE   "Category" = 'J'
AND     "DateTimeIncrement" IS NULL;

SELECT COUNT(*) FROM "deltaTestRandom10m"

-- calculate the diffs per category and insert into the deltaTestRandom1m table
-- A
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'A' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- B
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'B' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- C
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'C' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- D
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'D' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- E
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'E' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- F
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'F' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- G
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'G' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- H
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'H' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- I
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'I' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- J
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom1m"
WHERE "Category" = 'J' )
INSERT INTO "deltaTestRandom1m" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- Update the starting points (as epoch/bigint) for each A-I
UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'A'
    LIMIT 1 )
WHERE   "Category" = 'A'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'B'
    LIMIT 1 )
WHERE   "Category" = 'B'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'C'
    LIMIT 1 )
WHERE   "Category" = 'C'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'D'
    LIMIT 1 )
WHERE   "Category" = 'D'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'E'
    LIMIT 1 )
WHERE   "Category" = 'E'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'F'
    LIMIT 1 )
WHERE   "Category" = 'F'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'G'
    LIMIT 1 )
WHERE   "Category" = 'G'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'H'
    LIMIT 1 )
WHERE   "Category" = 'H'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'I'
    LIMIT 1 )
WHERE   "Category" = 'I'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom1m"
    WHERE "controlRandom1m"."Category" = 'J'
    LIMIT 1 )
WHERE   "Category" = 'J'
AND     "DateTimeIncrement" IS NULL;

SELECT COUNT(*) FROM "deltaTestRandom1m"

-- calculate the diffs per category and insert into the deltaTestRandom100k table
-- A
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'A' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- B
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'B' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- C
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'C' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- D
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'D' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- E
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'E' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- F
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'F' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- G
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'G' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- H
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'H' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- I
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'I' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- J
;WITH src AS (
SELECT "UQID", "Category", "DateTimeStamp",
		LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID") AS "rowBefore",
		EXTRACT(EPOCH FROM ("DateTimeStamp" - (LAG("DateTimeStamp", 1, NULL) OVER ( ORDER BY "UQID")) ))  AS "diff"
FROM 	"controlRandom100k"
WHERE "Category" = 'J' )
INSERT INTO "deltaTestRandom100k" ("UQID", "Category", "DateTimeIncrement")
    SELECT  src."UQID", src."Category", src."diff" AS "DateTimeIncrement"
    FROM    src AS src

-- Update the starting points (as epoch/bigint) for each A-I
UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'A'
    LIMIT 1 )
WHERE   "Category" = 'A'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'B'
    LIMIT 1 )
WHERE   "Category" = 'B'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'C'
    LIMIT 1 )
WHERE   "Category" = 'C'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'D'
    LIMIT 1 )
WHERE   "Category" = 'D'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'E'
    LIMIT 1 )
WHERE   "Category" = 'E'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'F'
    LIMIT 1 )
WHERE   "Category" = 'F'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'G'
    LIMIT 1 )
WHERE   "Category" = 'G'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'H'
    LIMIT 1 )
WHERE   "Category" = 'H'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'I'
    LIMIT 1 )
WHERE   "Category" = 'I'
AND     "DateTimeIncrement" IS NULL;

UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = (
    SELECT EXTRACT(EPOCH FROM MIN("DateTimeStamp"))
    FROM "controlRandom100k"
    WHERE "controlRandom100k"."Category" = 'J'
    LIMIT 1 )
WHERE   "Category" = 'J'
AND     "DateTimeIncrement" IS NULL;

/*
 NO LONGER NEEDED

-- Divide all delta DateTimeInterval by 60 to convert to s, excluding the seed value
UPDATE "deltaTestRandom100k"
SET "DateTimeIncrement" = ("DateTimeIncrement" * 60.0)
WHERE "DateTimeIncrement" NOT IN (
    SELECT  "DateTimeIncrement" FROM (
                        SELECT "Category", MAX("DateTimeIncrement") AS "DateTimeIncrement"
                        FROM    "deltaTestRandom100k"
                        GROUP   BY "Category" ) AS "x"
    );

UPDATE "deltaTestRandom1m"
SET "DateTimeIncrement" = ("DateTimeIncrement" * 60.0)
WHERE "DateTimeIncrement" NOT IN (
    SELECT  "DateTimeIncrement" FROM (
                        SELECT "Category", MAX("DateTimeIncrement") AS "DateTimeIncrement"
                        FROM    "deltaTestRandom1m"
                        GROUP   BY "Category" ) AS "x"
    );
UPDATE "deltaTestRandom10m"
SET "DateTimeIncrement" = ("DateTimeIncrement" * 60.0)
WHERE "DateTimeIncrement" NOT IN (
    SELECT  "DateTimeIncrement" FROM (
                        SELECT "Category", MAX("DateTimeIncrement") AS "DateTimeIncrement"
                        FROM    "deltaTestRandom10m"
                        GROUP   BY "Category" ) AS "x"
    );
*/


SELECT *
FROM "deltaTestRandom100k"
INNER JOIN "controlRandom100k" ON "deltaTestRandom100k"."UQID" = "controlRandom100k"."UQID"
WHERE "deltaTestRandom100k"."Category" = 'A' ORDER BY "deltaTestRandom100k"."UQID" LIMIT 100;

SELECT * FROM "deltaTestRandom100k" WHERE "Category" = 'A' ORDER BY "UQID" LIMIT 1
