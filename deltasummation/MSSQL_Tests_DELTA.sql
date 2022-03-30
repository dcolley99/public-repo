
-- TEST 1: MSSQL, 100K, SELECT WITH PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

SELECT	DATEADD(SECOND, SUM(d.DateTimeIncrement), '1970-01-01 00:00:00')  
FROM	deltaRandom100k d
WHERE	Category = 'E'
GO

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE ('SELECT%DATEADD%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO

SELECT @@ROWCOUNT 

select * from results 


-- TEST 2: MSSQL, 100K, SELECT WITHOUT PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

SELECT	TOP 1 DATEADD(SECOND, SUM(d.DateTimeIncrement), '1970-01-01 00:00:00') s
FROM	deltaRandom100k d
GROUP	BY d.Category 
ORDER	BY s DESC

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE ('SELECT%DATEADD%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO

select * from results 

-- TEST 3: MSSQL, 100K, INSERTION, NO PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

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

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE (';WITH%INSERT%INTO%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO

SELECT * FROM results  


-- TEST 4: MSSQL, 1M, SELECT WITH PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

SELECT	DATEADD(SECOND, SUM(d.DateTimeIncrement), '1970-01-01 00:00:00')  
FROM	deltaRandom1m d
WHERE	Category = 'E'
GO

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE ('SELECT%DATEADD%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO

SELECT @@ROWCOUNT 

select * from results where TestNo is null 


-- TEST 5: MSSQL, 1M, SELECT WITHOUT PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

SELECT	TOP 1 DATEADD(SECOND, SUM(d.DateTimeIncrement), '1970-01-01 00:00:00') s
FROM	deltaRandom1m d
GROUP	BY d.Category 
ORDER	BY s DESC

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE ('SELECT%DATEADD%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO

select * from results where testno is null 


-- TEST 6: MSSQL, 1M, INSERTION, NO PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

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

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE (';WITH%INSERT%INTO%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO

SELECT * FROM results  


-- TEST 7: MSSQL, 10M, SELECT WITH PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

SELECT	DATEADD(SECOND, SUM(d.DateTimeIncrement), '1970-01-01 00:00:00')  
FROM	deltaRandom10m d
WHERE	Category = 'E'
GO

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE ('SELECT%DATEADD%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO

select * from results where testno is null 



-- TEST 8: MSSQL, 10M, SELECT WITHOUT PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

SELECT	TOP 1 DATEADD(SECOND, SUM(d.DateTimeIncrement), '1970-01-01 00:00:00') s
FROM	deltaRandom10m d
GROUP	BY d.Category 
ORDER	BY s DESC

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE ('SELECT%DATEADD%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO

select * from results where testno is null 


-- TEST 9: MSSQL, 10M, INSERTION, NO PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS 
GO

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

INSERT INTO results 
SELECT	TOP 1  
		NULL, GETDATE(), s.last_execution_time,
		t.[text], q.query_plan, 
		s.last_elapsed_time, s.last_grant_kb, s.last_logical_reads, s.last_physical_reads, s.last_logical_writes, 
		s.last_worker_time, s.last_used_grant_kb, s.last_ideal_grant_kb
FROM	sys.dm_exec_query_stats s 
CROSS	APPLY sys.dm_exec_sql_text (s.sql_handle) t 
CROSS	APPLY sys.dm_exec_query_plan (s.plan_handle) q
WHERE	t.text LIKE (';WITH%INSERT%INTO%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 
GO


