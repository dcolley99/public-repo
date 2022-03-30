SELECT  c.*, r.*
FROM	controlRandom100k c 
INNER	JOIN deltaRandom100k r ON c.UQID = r.UQID 
WHERE c.Category = 'A' 
ORDER BY c.UQID 

UPDATE	r
SET		r.DateTimeIncrement = DATEDIFF(S, '1970-01-01 00:00:00', c.DateTimeStamp) 
FROM	controlRandom100k c 
INNER	JOIN deltaRandom100k r ON c.UQID = r.UQID 
WHERE c.Category = 'A' 
AND	  c.uqid = 7



WITH src AS (
select sum(datetimeincrement) x from deltaRandom100k where category = 'A' )

select  dateadd(S, x, '1970-01-01 00:00:00') 
FROM src 

select	max(DateTimeStamp) 
FROM	controlRandom100k c 
where	c.Category = 'A' 

