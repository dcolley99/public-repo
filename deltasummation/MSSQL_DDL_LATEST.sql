USE [delta_exp]
GO
/****** Object:  Table [dbo].[controlRandom100k]    Script Date: 15/03/2022 11:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[controlRandom100k](
	[UQID] [bigint] NULL,
	[Category] [varchar](1) NULL,
	[DateTimeStamp] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[controlRandom10m]    Script Date: 15/03/2022 11:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[controlRandom10m](
	[UQID] [int] NULL,
	[Category] [varchar](1) NULL,
	[DateTimeStamp] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[controlRandom1m]    Script Date: 15/03/2022 11:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[controlRandom1m](
	[UQID] [bigint] NULL,
	[Category] [varchar](1) NULL,
	[DateTimeStamp] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[deltaRandom100k]    Script Date: 15/03/2022 11:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[deltaRandom100k](
	[UQID] [bigint] NULL,
	[Category] [varchar](1) NULL,
	[DateTimeIncrement] [real] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[deltaRandom10m]    Script Date: 15/03/2022 11:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[deltaRandom10m](
	[UQID] [int] NULL,
	[Category] [varchar](20) NULL,
	[DateTimeIncrement] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[deltaRandom1m]    Script Date: 15/03/2022 11:42:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[deltaRandom1m](
	[UQID] [bigint] NULL,
	[Category] [varchar](1) NULL,
	[DateTimeIncrement] [real] NULL
) ON [PRIMARY]
GO
