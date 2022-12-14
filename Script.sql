USE [master]
GO
/****** Object:  Database [ShoppingDB]    Script Date: 11/11/2022 9:18:24 AM ******/
CREATE DATABASE [ShoppingDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ShoppingDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\ShoppingDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ShoppingDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\ShoppingDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ShoppingDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShoppingDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShoppingDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShoppingDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShoppingDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShoppingDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShoppingDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShoppingDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShoppingDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShoppingDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShoppingDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShoppingDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShoppingDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShoppingDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShoppingDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShoppingDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShoppingDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShoppingDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ShoppingDB] SET  MULTI_USER 
GO
ALTER DATABASE [ShoppingDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShoppingDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShoppingDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShoppingDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ShoppingDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ShoppingDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ShoppingDB', N'ON'
GO
ALTER DATABASE [ShoppingDB] SET QUERY_STORE = OFF
GO
USE [ShoppingDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 11/11/2022 9:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 11/11/2022 9:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](max) NOT NULL,
	[Unit] [nvarchar](max) NULL,
	[UnitPrice] [float] NOT NULL,
	[ShoppingListId] [int] NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingItems]    Script Date: 11/11/2022 9:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingItems](
	[ShoppingListItemId] [int] IDENTITY(1,1) NOT NULL,
	[ShoppingListId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_ShoppingItems] PRIMARY KEY CLUSTERED 
(
	[ShoppingListItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingLists]    Script Date: 11/11/2022 9:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingLists](
	[ShoppingListId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[UserId] [int] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ShoppingLists] PRIMARY KEY CLUSTERED 
(
	[ShoppingListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/11/2022 9:18:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20221107202206_init3', N'6.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20221107230408_in', N'6.0.10')
GO
SET IDENTITY_INSERT [dbo].[Items] ON 

INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1005, N'Granny Smith Apples', N'1kg', 5.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1006, N'Fresh tomatoes', N'500g', 5.9, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1007, N'Watermelon', N'Whole', 6.6, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1008, N'Cucumber', N'1 whole', 1.9, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1009, N'Red potato washed', N'1kg', 4, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1010, N'Red tipped bananas', N'1kg', 4.9, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1011, N'Red onion', N'1kg', 3.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1012, N'Carrots', N'1kg', 2, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1013, N'Iceburg Lettuce', N'1', 2.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1014, N'Helga''s Wholemeal', N'1', 3.7, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1015, N'Free range chicken', N'1kg', 7.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1016, N'Manning Valley 6-pk', N'6 eggs', 3.6, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1017, N'A2 light milk', N'1 litre', 2.9, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1018, N'Chobani Strawberry Yoghurt', N'1', 1.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1019, N'Lurpak Salted Blend', N'250g', 5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1020, N'Bega Farmers Tasty', N'250g', 4, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1021, N'Babybel Mini', N'100g', 4.2, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1022, N'Cobram EVOO', N'375ml', 8, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1023, N'Heinz Tomato Soup', N'535g', 2.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1024, N'John West Tuna can', N'95g', 1.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1025, N'Cadbury Dairy Milk', N'200g', 5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1026, N'Coca Cola', N'2 litre', 2.85, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1027, N'Smith''s Original Share Pack Crisps', N'170g', 3.29, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1028, N'Birds Eye Fish Fingers', N'375g', 4.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1029, N'Berri Orange Juice', N'2 litre', 6, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1030, N'Vegemite', N'380g', 6, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1031, N'Cheddar Shapes', N'175g', 2, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1032, N'Colgate Total Toothpaste Original', N'110g', 3.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1033, N'Milo Chocolate Malt', N'200g', 4, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1034, N'Weet Bix Saniatarium Organic', N'750g', 5.33, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1035, N'Lindt Excellence 70% Cocoa Block', N'100g', 4.25, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1036, N'Original Tim Tams Choclate', N'200g', 3.65, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1037, N'Philadelphia Original Cream Cheese', N'250g', 4.3, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1038, N'Moccana Classic Instant Medium Roast', N'100g', 6, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1039, N'Capilano Squeezable Honey', N'500g', 7.35, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1040, N'Nutella jar', N'400g', 4, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1041, N'Arnott''s Scotch Finger', N'250g', 2.85, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1042, N'South Cape Greek Feta', N'200g', 5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1043, N'Sacla Pasta Tomato Basil Sauce', N'420g', 4.5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1044, N'Primo English Ham', N'100g', 3, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1045, N'Primo Short cut rindless Bacon', N'175g', 5, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1046, N'Golden Circle Pineapple Pieces in natural juice', N'440g', 3.25, NULL)
INSERT [dbo].[Items] ([Id], [ItemName], [Unit], [UnitPrice], [ShoppingListId]) VALUES (1047, N'San Remo Linguine Pasta No 1', N'500g', 1.95, NULL)
SET IDENTITY_INSERT [dbo].[Items] OFF
GO
SET IDENTITY_INSERT [dbo].[ShoppingItems] ON 

INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2041, 2, 1005, NULL)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2042, 2, 1007, NULL)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2043, 2, 1009, NULL)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2049, 15, 1005, 1)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2050, 15, 1005, 1)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2052, 15, 1006, 3)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2053, 2014, 1005, 2)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2054, 2014, 1006, 3)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2055, 15, 1007, 3)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2058, 1015, 1005, 1)
INSERT [dbo].[ShoppingItems] ([ShoppingListItemId], [ShoppingListId], [ItemId], [Quantity]) VALUES (2059, 1015, 1007, 1)
SET IDENTITY_INSERT [dbo].[ShoppingItems] OFF
GO
SET IDENTITY_INSERT [dbo].[ShoppingLists] ON 

INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (1, N'test', 1, CAST(N'2022-11-08T09:05:52.3378654' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (2, N'testt', 1, CAST(N'2022-11-08T09:14:23.9272239' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (3, N'roshy', 1, CAST(N'2022-11-08T10:15:17.1276340' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (4, N'Hi', 1, CAST(N'2022-11-08T10:44:10.9740431' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (5, N'new', 1, CAST(N'2022-11-08T11:41:55.5844358' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (6, N'new123', 1, CAST(N'2022-11-08T11:42:37.0452568' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (7, N'HEYY', 1, CAST(N'2022-11-08T11:47:34.9142263' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (8, N'HEYY', 1, CAST(N'2022-11-08T11:47:34.9142190' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (9, N'HEYY', 1, CAST(N'2022-11-08T11:47:34.9142228' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (10, N'New List', 1, CAST(N'2022-11-08T16:27:03.9079975' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (11, N'test list', 1, CAST(N'2022-11-08T16:29:42.1015376' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (12, N'New Item', 1, CAST(N'2022-11-08T15:37:44.5384668' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (14, N'New Item1', 1, CAST(N'2022-11-08T17:31:23.0174208' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (15, N'new test12 -update', 3, CAST(N'2022-11-11T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (1012, N'my items', 1, CAST(N'2022-11-09T08:26:22.1912256' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (1013, N'test23', 1, CAST(N'2022-11-09T09:02:38.5085648' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (1014, N'test45', 1, CAST(N'2022-11-09T09:03:42.1474463' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (1015, N'New Item List', 3, CAST(N'2022-11-09T11:51:16.8958136' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (2013, N'newUsertest', 1, CAST(N'2022-11-09T18:49:12.1379452' AS DateTime2))
INSERT [dbo].[ShoppingLists] ([ShoppingListId], [Name], [UserId], [CreatedDate]) VALUES (2014, N'newList', 3, CAST(N'2022-11-11T09:03:42.5092378' AS DateTime2))
SET IDENTITY_INSERT [dbo].[ShoppingLists] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [Password]) VALUES (1, N'test', N'test')
INSERT [dbo].[Users] ([UserId], [UserName], [Password]) VALUES (3, N'hey', N'hey')
INSERT [dbo].[Users] ([UserId], [UserName], [Password]) VALUES (4, N'newuser', N'newUser')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_Items_ShoppingListId]    Script Date: 11/11/2022 9:18:25 AM ******/
CREATE NONCLUSTERED INDEX [IX_Items_ShoppingListId] ON [dbo].[Items]
(
	[ShoppingListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingItems_ItemId]    Script Date: 11/11/2022 9:18:25 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingItems_ItemId] ON [dbo].[ShoppingItems]
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingItems_ShoppingListId]    Script Date: 11/11/2022 9:18:25 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingItems_ShoppingListId] ON [dbo].[ShoppingItems]
(
	[ShoppingListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingLists_UserId]    Script Date: 11/11/2022 9:18:25 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingLists_UserId] ON [dbo].[ShoppingLists]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_ShoppingLists_ShoppingListId] FOREIGN KEY([ShoppingListId])
REFERENCES [dbo].[ShoppingLists] ([ShoppingListId])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_ShoppingLists_ShoppingListId]
GO
ALTER TABLE [dbo].[ShoppingItems]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingItems_Items_ItemId] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShoppingItems] CHECK CONSTRAINT [FK_ShoppingItems_Items_ItemId]
GO
ALTER TABLE [dbo].[ShoppingItems]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingItems_ShoppingLists_ShoppingListId] FOREIGN KEY([ShoppingListId])
REFERENCES [dbo].[ShoppingLists] ([ShoppingListId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShoppingItems] CHECK CONSTRAINT [FK_ShoppingItems_ShoppingLists_ShoppingListId]
GO
ALTER TABLE [dbo].[ShoppingLists]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingLists_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShoppingLists] CHECK CONSTRAINT [FK_ShoppingLists_Users_UserId]
GO
USE [master]
GO
ALTER DATABASE [ShoppingDB] SET  READ_WRITE 
GO
