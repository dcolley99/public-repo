TRUNCATE TABLE results 

-- TEST 1: MSSQL, 100K, SELECT WITH PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO

-- This comment represents some minor change. 


SELECT  MAX(DateTimeStamp)
FROM    controlRandom100k
WHERE   Category = 'E'
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
WHERE	t.text LIKE ('SELECT%MAX%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 


-- TEST 2: MSSQL, 100K, SELECT WITHOUT PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO 

SELECT  MAX(DateTimeStamp)
FROM    controlRandom100k
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
WHERE	t.text LIKE ('SELECT%MAX%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 

DELETE FROM results WHERE UQID = 22 
DBCC CHECKIDENT('results', reseed, 21)

-- TEST 3: MSSQL, 100K, INSERTION, NO PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO 

;WITH nextval AS (
    SELECT MAX(UQID) + 1 AS MAXUQID FROM controlRandom100k 
)
INSERT INTO controlRandom100k (UQID,Category,DateTimeStamp)
SELECT MAXUQID, 'F', DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 31536000, GETDATE())
FROM nextval
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
WHERE	t.text LIKE ('%INSERT%controlRandom%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 

select * from results 




-- TEST 4: MSSQL, 1M, SELECT WITH PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO 

SELECT  MAX(DateTimeStamp)
FROM    controlRandom1m
WHERE   Category = 'E'
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
WHERE	t.text LIKE ('SELECT%MAX%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 

select * from results 


-- TEST 5: MSSQL, 1M, SELECT WITHOUT PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO 

SELECT  MAX(DateTimeStamp)
FROM    controlRandom1m
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
WHERE	t.text LIKE ('SELECT%MAX%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 

select * from results 


-- TEST 6: MSSQL, 1M, INSERTION, NO PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO 

;WITH nextval AS (
    SELECT MAX(UQID) + 1 AS MAXUQID FROM controlRandom1m 
)
INSERT INTO controlRandom1m (UQID,Category,DateTimeStamp)
SELECT MAXUQID, 'F', DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 31536000, GETDATE())
FROM nextval
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
WHERE	t.text LIKE ('%INSERT%controlRandom%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 

select * from results 


-- TEST 7: MSSQL, 10M, SELECT WITH PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO 

SELECT  MAX(DateTimeStamp)
FROM    controlRandom10m
WHERE   Category = 'E'
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
WHERE	t.text LIKE ('SELECT%MAX%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 

select * from results 


-- TEST 8: MSSQL, 10M, SELECT WITHOUT PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO 

SELECT  MAX(DateTimeStamp)
FROM    controlRandom10m
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
WHERE	t.text LIKE ('SELECT%MAX%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 

select * from results 


-- TEST 9: MSSQL, 10M, INSERTION, NO PREDICATES
DBCC FREEPROCCACHE 
DBCC DROPCLEANBUFFERS
GO 

;WITH nextval AS (
    SELECT MAX(UQID) + 1 AS MAXUQID FROM controlRandom10m 
)
INSERT INTO controlRandom10m (UQID,Category,DateTimeStamp)
SELECT MAXUQID, 'F', DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 31536000, GETDATE())
FROM nextval
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
WHERE	t.text LIKE ('%INSERT%controlRandom%')
AND		t.text NOT LIKE ('SELECT%t.text%') 
ORDER	BY s.last_execution_time DESC 

SELECT @@ROWCOUNT 

select * from results 


UPDATE results 
SET TestNo = 'C' + CAST(UQID AS VARCHAR(2)) 

-- results extraction
;WITH src AS (
SELECT	UQID, TestNo, CreationDate, ExecutionDateTime, SQLText, QueryPlan, 
		CAST(REPLACE(SUBSTRING(CAST(QueryPlan AS NVARCHAR(MAX)), PATINDEX('%StatementSubtreeCost%', CAST(QueryPlan AS NVARCHAR(MAX))) + 22, 7),'"','') AS FLOAT) [TotalSubtreeCost], 
		--CAST(SUBSTRING(CAST(QueryPlan AS NVARCHAR(MAX)), PATINDEX('%StatementSubtreeCost%', CAST(QueryPlan AS NVARCHAR(MAX))) + 22, 7) AS FLOAT) [TotalSubtreeCost], 
		ElapsedTime, GrantKB, LogicalReads, PhysicalReads, LogicalWrites, 
		WorkerTime, UsedGrantKB, IdealGrantKB 
FROM	results ) 

SELECT	src.UQID,
		src.WorkerTime / 1000.0 [WorkerTimeMS], 
		((src.LogicalReads + src.PhysicalReads) * 8192.0) / 1024.0 [I/O (Reads) (KB)], 
		CASE	WHEN src.GrantKB > src.UsedGrantKB THEN src.GrantKB 
				WHEN src.GrantKB = src.UsedGrantKB THEN src.GrantKB 
				WHEN src.GrantKB < src.UsedGrantKB THEN src.UsedGrantKB
		END [Memory Grant (KB)], 
		src.TotalSubtreeCost, 
		src.ElapsedTime / 1000.0 [ElapsedTimeMS]
FROM	src src
ORDER	BY UQID ASC 

-- YOU ARE HERE.
-- DO THE DELTAS, THEN WORK OUT HOW THE HELL TO DO THIS IN POSTGRES.
