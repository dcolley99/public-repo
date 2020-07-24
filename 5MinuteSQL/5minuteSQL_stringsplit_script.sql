USE FiveMinuteSQL 
GO 

DROP TABLE IF EXISTS dbo.Videos 
GO
CREATE TABLE dbo.Videos ( 
	VideoID INT IDENTITY(1,1) NOT NULL, 
	VideoName VARCHAR(255), 
	VideoTags VARCHAR(MAX), 
	CONSTRAINT pk_VideosID PRIMARY KEY (VideoID) ) 
GO 
INSERT INTO dbo.Videos 
VALUES	('Funny cat video', 'cat, miaow, funny, aww, cute'), 
		('Repairing a patio door', 'DIY, practical, repair, patio door, patio'), 
		('Songs about my cats', 'cat, music, song, funny'), 
		('UFO spotted near Doncaster', 'ufo, weird, strange, creepy, unexplained'), 
		('Citroen Saxo repair fail', 'DIY, funny, repair, fail') 
GO 

SELECT * FROM dbo.Videos 

-- Question:  How can we organise our videos by tags?  We want to end up with three tables - videos, tags, and a link table.
-- This puts us in third normal form.

-- First thing first - let's try string_split()... it's a table-valued function, so we use it like a data source.
-- In other words we select FROM it, we don't select it directly.  The default column is called 'value'.

SELECT	value 
FROM	string_split('a,b,c', ',')

-- How do we apply it to a table?  We use CROSS APPLY.  
-- This means take the function being cross-applied and apply it to every row in the source data set.
-- We will apply string_split() to every row in Videos, specifying the VideoTags column with a comma delimiter. 

SELECT	s.value
FROM	dbo.Videos v
CROSS	APPLY string_split(VideoTags, ',') s

-- So far, so good - we have a list of tags, but no videos associated with them.  
-- Let's fix that.

SELECT	v.VideoName, s.value 
FROM	dbo.Videos v 
CROSS	APPLY string_split(VideoTags, ',') s 

-- We notice that the string-split value has extra spaces - this is because of our 'a, b, c' format.
-- Let's fix it with a left TRIM and alias our second column, too.

SELECT	v.VideoName, LTRIM(s.value) [tag]
FROM	dbo.Videos v 
CROSS	APPLY string_split(VideoTags, ',') s 

-- Let's get a count of tags per video, and a count of videos per tag. 

SELECT	VideoName, COUNT(*) [tag_count]
FROM	(
	SELECT	v.VideoName, LTRIM(s.value) [tag]
	FROM	dbo.Videos v 
	CROSS	APPLY string_split(VideoTags, ',') s ) foo 
GROUP	BY VideoName 

SELECT	tag, COUNT(*) [video_count]
FROM	(
	SELECT	v.VideoName, LTRIM(s.value) [tag]
	FROM	dbo.Videos v 
	CROSS	APPLY string_split(VideoTags, ',') s ) foo 
GROUP	BY tag 

-- We can present summary views, too, using GROUP BY ROLLUP or GROUP BY CUBE.

SELECT	ISNULL(VideoName, 'All Videos') [VideoName], 
		ISNULL(tag, 'All Tags') [tag], 
		COUNT(*) [video_count]
FROM	(
	SELECT	v.VideoName, LTRIM(s.value) [tag]
	FROM	dbo.Videos v 
	CROSS	APPLY string_split(VideoTags, ',') s ) foo 
GROUP	BY CUBE (tag, VideoName)
ORDER	BY VideoName ASC 

-- Now let's get to business - let's create some tables to hold our new normalised view of the data...

DROP TABLE IF EXISTS dbo.Video 
DROP TABLE IF EXISTS dbo.Tag 
DROP TABLE IF EXISTS dbo.VideoTagLink 
GO
CREATE TABLE dbo.Video ( 
	VideoID INT IDENTITY(1,1) NOT NULL, 
	VideoName VARCHAR(255), 
	CONSTRAINT pk_VideoID PRIMARY KEY (VideoID) ) 
CREATE TABLE dbo.Tag ( 
	TagID INT IDENTITY(1,1) NOT NULL, 
	Tag VARCHAR(255), 
	CONSTRAINT pk_TagID PRIMARY KEY (TagID) ) 
CREATE TABLE VideoTagLink ( 
	VTLinkID INT IDENTITY(1,1) NOT NULL, 
	VideoID INT NOT NULL, 
	TagID INT NOT NULL, 
	DateAdded DATETIME DEFAULT GETDATE(),
	CONSTRAINT pk_VTLinkID PRIMARY KEY (VTLinkID), 
	CONSTRAINT fk_VideoID FOREIGN KEY (VideoID) REFERENCES dbo.Video (VideoID), 
	CONSTRAINT fk_TagID FOREIGN KEY (TagID) REFERENCES dbo.Tag (TagID) )
GO 

-- Let's take a look at the ERD... 

-- Now let's populate those tables from our string_split query. 

INSERT INTO dbo.Video ( VideoName ) 
	SELECT DISTINCT VideoName FROM dbo.Videos 
INSERT INTO dbo.Tag ( Tag ) 
	SELECT DISTINCT tag FROM (
		SELECT	LTRIM(s.value) [tag]
		FROM	dbo.Videos v 
		CROSS	APPLY string_split(VideoTags, ',') s ) foo 
INSERT INTO dbo.VideoTagLink (VideoID, TagID) 
	SELECT	v.VideoID, 
			t.TagID
	FROM	dbo.Video v 
	INNER	JOIN ( 
		SELECT	VideoName, LTRIM(s.value) [Tag] 
		FROM	dbo.Videos v 
		CROSS	APPLY string_split(VideoTags, ',') s ) ss 
	ON		v.VideoName = ss.VideoName 
	INNER	JOIN dbo.Tag t 
	ON		ss.Tag = t.Tag 
	ORDER	BY VideoID, TagID 

-- Now we can query which videos correspond to a given tag... 

SELECT	v.VideoName 
FROM	dbo.Video v 
INNER	JOIN dbo.VideoTagLink l ON v.VideoID = l.VideoID 
INNER	JOIN dbo.Tag t ON l.TagID = t.TagID 
WHERE	t.Tag = 'funny' 

-- And query which tags are associated with a video... 

SELECT	t.Tag  
FROM	dbo.Tag t  
INNER	JOIN dbo.VideoTagLink l ON t.TagID = l.TagID  
INNER	JOIN dbo.Video v ON l.VideoID = v.VideoID 
WHERE	v.VideoName = 'Songs about my cats' 


-- Thank you for watching!
