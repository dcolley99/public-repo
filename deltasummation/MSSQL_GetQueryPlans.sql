-- QUERY PLANS, ALL TESTS 

-- 100K
dbcc freeproccache 
dbcc dropcleanbuffers 
SELECT MAX(DateTimeStamp) FROM controlRandom100k WHERE Category = 'E' 
SELECT SUM(DateTimeIncrement) FROM deltaRandom100k WHERE Category = 'E' 
dbcc freeproccache 
dbcc dropcleanbuffers 
SELECT MAX(DateTimeStamp) FROM controlRandom100k  
SELECT SUM(DateTimeIncrement) FROM deltaRandom100k  
dbcc freeproccache 
dbcc dropcleanbuffers 
INSERT INTO controlRandom100k 
	SELECT	( SELECT MAX(UQID) + 1 FROM controlRandom100k ) [UQID], 
			'F', 
			GETDATE()
dbcc freeproccache 
dbcc dropcleanbuffers 
;WITH nextval AS (
    SELECT	MAX(UQID) [m] FROM deltaRandom100k
), 
latestValue AS ( 
	SELECT	SUM(DateTimeIncrement) [s]
	FROM	deltaRandom100k d 
	WHERE	d.Category = 'F' ) 
INSERT INTO deltaRandom100k (UQID,Category,DateTimeIncrement)
SELECT	nextval.m + 1, 'F', latestValue.s + ABS(CHECKSUM(NEWID()) % 30 + 1) -- random time in 30s range
FROM	nextval, latestValue

-- 1M
dbcc freeproccache 
dbcc dropcleanbuffers 
SELECT MAX(DateTimeStamp) FROM controlRandom1m WHERE Category = 'E' 
SELECT SUM(DateTimeIncrement) FROM deltaRandom1m WHERE Category = 'E' 
dbcc freeproccache 
dbcc dropcleanbuffers 
SELECT MAX(DateTimeStamp) FROM controlRandom1m  
SELECT SUM(DateTimeIncrement) FROM deltaRandom1m  
dbcc freeproccache 
dbcc dropcleanbuffers 
INSERT INTO controlRandom1m 
	SELECT	( SELECT MAX(UQID) + 1 FROM controlRandom1m ) [UQID], 
			'F', 
			GETDATE()
dbcc freeproccache 
dbcc dropcleanbuffers 
;WITH nextval AS (
    SELECT	MAX(UQID) [m] FROM deltaRandom1m
), 
latestValue AS ( 
	SELECT	SUM(DateTimeIncrement) [s]
	FROM	deltaRandom1m d 
	WHERE	d.Category = 'F' ) 
INSERT INTO deltaRandom1m (UQID,Category,DateTimeIncrement)
SELECT	nextval.m + 1, 'F', latestValue.s + ABS(CHECKSUM(NEWID()) % 30 + 1) -- random time in 30s range
FROM	nextval, latestValue

-- 10M
dbcc freeproccache 
dbcc dropcleanbuffers 
SELECT MAX(DateTimeStamp) FROM controlRandom10m WHERE Category = 'E' 
SELECT SUM(DateTimeIncrement) FROM deltaRandom10m WHERE Category = 'E' 
dbcc freeproccache 
dbcc dropcleanbuffers 
SELECT MAX(DateTimeStamp) FROM controlRandom10m  
SELECT SUM(DateTimeIncrement) FROM deltaRandom10m  
dbcc freeproccache 
dbcc dropcleanbuffers 
INSERT INTO controlRandom10m 
	SELECT	( SELECT MAX(UQID) + 1 FROM controlRandom10m ) [UQID], 
			'F', 
			GETDATE()
dbcc freeproccache 
dbcc dropcleanbuffers 
;WITH nextval AS (
    SELECT	MAX(UQID) [m] FROM deltaRandom10m
), 
latestValue AS ( 
	SELECT	SUM(DateTimeIncrement) [s]
	FROM	deltaRandom10m d 
	WHERE	d.Category = 'F' ) 
INSERT INTO deltaRandom10m (UQID,Category,DateTimeIncrement)
SELECT	nextval.m + 1, 'F', latestValue.s + ABS(CHECKSUM(NEWID()) % 30 + 1) -- random time in 30s range
FROM	nextval, latestValue
