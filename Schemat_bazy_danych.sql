USE [master]
GO
/****** Object:  Database [multiagencja_ubezpieczeniowa]    Script Date: 26.08.2022 11:43:42 ******/
CREATE DATABASE [multiagencja_ubezpieczeniowa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'multiagencja_ubezpieczeniowa', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\multiagencja_ubezpieczeniowa.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'multiagencja_ubezpieczeniowa_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\multiagencja_ubezpieczeniowa_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [multiagencja_ubezpieczeniowa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET ARITHABORT OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET  ENABLE_BROKER 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET RECOVERY FULL 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET  MULTI_USER 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'multiagencja_ubezpieczeniowa', N'ON'
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET QUERY_STORE = ON
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 60, INTERVAL_LENGTH_MINUTES = 1, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = ALL, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  User [Piotr_Góral]    Script Date: 26.08.2022 11:43:43 ******/
CREATE USER [Piotr_Góral] FOR LOGIN [Piotr_Góral] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Neoangin]    Script Date: 26.08.2022 11:43:43 ******/
CREATE USER [Neoangin] FOR LOGIN [Neoangin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Marian_Kibic]    Script Date: 26.08.2022 11:43:43 ******/
CREATE USER [Marian_Kibic] FOR LOGIN [Marian_Kibic] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Łukasz_Kabaczek]    Script Date: 26.08.2022 11:43:43 ******/
CREATE USER [Łukasz_Kabaczek] FOR LOGIN [Łukasz_Kabaczek] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Beata_Malina]    Script Date: 26.08.2022 11:43:43 ******/
CREATE USER [Beata_Malina] FOR LOGIN [Beata_Malina] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Artur_Maki]    Script Date: 26.08.2022 11:43:43 ******/
CREATE USER [Artur_Maki] FOR LOGIN [Artur_Maki] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [Sprzedawcy]    Script Date: 26.08.2022 11:43:43 ******/
CREATE ROLE [Sprzedawcy]
GO
/****** Object:  DatabaseRole [Administracja]    Script Date: 26.08.2022 11:43:43 ******/
CREATE ROLE [Administracja]
GO
ALTER ROLE [Sprzedawcy] ADD MEMBER [Piotr_Góral]
GO
ALTER ROLE [Sprzedawcy] ADD MEMBER [Neoangin]
GO
ALTER ROLE [Sprzedawcy] ADD MEMBER [Marian_Kibic]
GO
ALTER ROLE [Sprzedawcy] ADD MEMBER [Łukasz_Kabaczek]
GO
ALTER ROLE [Administracja] ADD MEMBER [Beata_Malina]
GO
ALTER ROLE [Sprzedawcy] ADD MEMBER [Artur_Maki]
GO
/****** Object:  Schema [adresy]    Script Date: 26.08.2022 11:43:43 ******/
CREATE SCHEMA [adresy]
GO
/****** Object:  Schema [biuro]    Script Date: 26.08.2022 11:43:43 ******/
CREATE SCHEMA [biuro]
GO
/****** Object:  Schema [finanse]    Script Date: 26.08.2022 11:43:43 ******/
CREATE SCHEMA [finanse]
GO
/****** Object:  Schema [pracownicy]    Script Date: 26.08.2022 11:43:43 ******/
CREATE SCHEMA [pracownicy]
GO
/****** Object:  Schema [sprzedaż]    Script Date: 26.08.2022 11:43:43 ******/
CREATE SCHEMA [sprzedaż]
GO
/****** Object:  UserDefinedTableType [sprzedaż].[raty]    Script Date: 26.08.2022 11:43:43 ******/
CREATE TYPE [sprzedaż].[raty] AS TABLE(
	[id_raty] [int] IDENTITY(1,1) NOT NULL,
	[id] [int] NULL,
	[rata] [money] NULL,
	[data] [date] NULL,
	PRIMARY KEY CLUSTERED 
(
	[id_raty] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedFunction [finanse].[wylicz_inkaso]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   function [finanse].[wylicz_inkaso]
(
@polecenie as varchar(10),
@id_pracownika as smallint,
@data_od as date = null,
@data_do as date = null
)
returns decimal(10,2)
as
begin
	set @data_od = ISNULL(@data_od, getdate())
	set @data_do = ISNULL(@data_do, getdate())
		declare @x as decimal(10,2)
			if @polecenie = 'suma'
				begin
					set @x = (
								  select SUM(składka) as suma_inkaso 
									from sprzedaż.polisy
								   where data_wpisania_polisy between @data_od and @data_do
									 and id_pracownika = @id_pracownika 
								group by id_pracownika
	                          )
				end
			if @polecenie = 'średnia'
				begin
					set @x = (
								  select avg(składka) as suma_inkaso 
									from sprzedaż.polisy
								   where data_wpisania_polisy between @data_od and @data_do
									 and id_pracownika = @id_pracownika 
								group by id_pracownika
					         )
				 end
			if @polecenie = 'ilość'
				begin
					set @x = (
								  select count(składka) as suma_inkaso 
									from sprzedaż.polisy
								   where data_wpisania_polisy between @data_od and @data_do
									 and id_pracownika = @id_pracownika 
								group by id_pracownika
					         )
				 end
return @x
end 




GO
/****** Object:  UserDefinedFunction [finanse].[wyświetl_sprzedaż]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   function [finanse].[wyświetl_sprzedaż]
(
	@nr_polisy as varchar(20) 
)
/*
Tzw funkcja multistatement za pośrednictwem której chcem uzyskać informację o wszystkich polisach 
oraz kwestiach związanych z płątnościami. Dane uzyskane po zastosoowaniu zagnieżdzonej pętli while
*/
returns @obliczenia table 
(
  nr_raty int 
, termin_płatności date
, kwota decimal(6,2)
)
as begin
declare @min_id_polisy as int 
declare @max_id_polisy as int 
select  @min_id_polisy = min(id_polisy) 
	  , @max_id_polisy = max(id_polisy) 
  from  sprzedaż.polisy

declare @i as int = @min_id_polisy
declare @raty as int = 1
  while @i <= @max_id_polisy
--- pętla nr 1
	   begin
			declare @termin_pierwszej_raty as date = 
													(
													  select termin_pierwszej_raty 
														from sprzedaż.polisy
													   where id_polisy = @i
													)
			declare @ilość_rat as int = (
										 select (datediff(MONTH,początek_ubezpieczenia,koniec_ubezpieczenia)+1)/raty 
										   from sprzedaż.polisy
										  where id_polisy = @i
										 )
--- pętla nr 2
			   while @raty <= (select raty from sprzedaż.polisy
								where id_polisy = @i)
								begin 
										insert into @obliczenia
										select @raty as nr_raty
											 , @termin_pierwszej_raty as termin_płatności
											 , cast(składka/raty as decimal (6,2)) as kwota
										  from sprzedaż.polisy
										 where id_polisy = @i
										   and nr_polisy = @nr_polisy
					set @raty +=1
					set @termin_pierwszej_raty = dateadd(month,@ilość_rat,@termin_pierwszej_raty)				
								end
							set @raty = 1		   
				   set @i +=1
			 end
	Return
end


GO
/****** Object:  Table [adresy].[miejscowości]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [adresy].[miejscowości](
	[id_miejscowości] [int] IDENTITY(1,1) NOT NULL,
	[nazwa_miejscowości] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_miejscowości] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [adresy].[kody_pocztowe]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [adresy].[kody_pocztowe](
	[id_kodu_pocztowego] [smallint] IDENTITY(1,1) NOT NULL,
	[kod_pocztowy] [char](6) NOT NULL,
	[id_miejscowości] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_kodu_pocztowego] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [adresy].[ulice]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [adresy].[ulice](
	[id_ulicy] [int] IDENTITY(1,1) NOT NULL,
	[nazwa_ulicy] [varchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ulicy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [adresy].[adresy]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [adresy].[adresy](
	[id_adresu] [int] IDENTITY(1,1) NOT NULL,
	[id_kodu_pocztowego] [smallint] NOT NULL,
	[id_ulicy] [int] NULL,
	[nr_budynku] [varchar](4) NOT NULL,
	[nr_pomieszczenia] [varchar](4) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_adresu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [adresy].[viewspis]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    view [adresy].[viewspis] 
WITH SCHEMABINDING 
as	
	   select aa.id_adresu
	        , akp.kod_pocztowy
			, au.nazwa_ulicy
			, am.nazwa_miejscowości
			, aa.nr_budynku
			, aa.nr_pomieszczenia
		 from adresy.adresy         as aa
   inner join adresy.kody_pocztowe  as akp 
           on aa.id_kodu_pocztowego = akp.id_kodu_pocztowego
   inner join adresy.ulice          as au
           on au.id_ulicy           = aa.id_ulicy
   inner join adresy.miejscowości   as am
           on am.id_miejscowości    = akp.id_miejscowości
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [adresy_pełne]    Script Date: 26.08.2022 11:43:43 ******/
CREATE UNIQUE CLUSTERED INDEX [adresy_pełne] ON [adresy].[viewspis]
(
	[id_adresu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[pracownicy]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[pracownicy](
	[id_pracownika] [smallint] IDENTITY(1,1) NOT NULL,
	[nr_tel_służbowy] [int] NULL,
	[email_służbowy] [varchar](30) NULL,
	[nr_konta_bankowego] [varchar](26) NULL,
	[nazwa_banku] [varchar](20) NULL,
	[id_adresu_korespondencyjnego] [int] NULL,
	[uwagi] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[partnerzy]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[partnerzy](
	[id_pracownika] [smallint] NOT NULL,
	[nazwa] [varchar](30) NULL,
	[nip] [int] NULL,
	[regon] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[szczegóły_umowy]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[szczegóły_umowy](
	[id_szczegółu] [int] IDENTITY(1,1) NOT NULL,
	[id_umowy] [int] NOT NULL,
	[nr_aneksu] [varchar](10) NULL,
	[pensja] [decimal](7, 2) NULL,
	[id_stanowiska] [smallint] NULL,
	[id_placówki] [smallint] NULL,
	[początek] [date] NOT NULL,
	[koniec] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_szczegółu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[stanowiska]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[stanowiska](
	[id_stanowiska] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwa_stanowiska] [varchar](50) NULL,
	[id_stanowiska_przełożonego] [smallint] NULL,
	[id_działu] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_stanowiska] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[placówki]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[placówki](
	[id_placówki] [smallint] IDENTITY(1,1) NOT NULL,
	[id_adresu] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_placówki] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[umowy]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[umowy](
	[id_umowy] [int] IDENTITY(1,1) NOT NULL,
	[nr_umowy] [varchar](10) NOT NULL,
	[id_pracownika] [smallint] NOT NULL,
	[id_rodz_umowy] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_umowy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[zatrudnieni]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[zatrudnieni](
	[id_pracownika] [smallint] NOT NULL,
	[imię] [varchar](20) NOT NULL,
	[nazwisko] [varchar](30) NOT NULL,
	[pesel] [varchar](11) NULL,
	[nr_tel_prywatny] [int] NULL,
	[email_prywatny] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [biuro].[view_pracownicy_nazwa]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create     view [biuro].[view_pracownicy_nazwa] as
with obliczenia as
			(
				select prac.id_pracownika
					 , part.nazwa as pracownik
					 , prac.nr_tel_służbowy
					 , prac.email_służbowy
				  from pracownicy.pracownicy as prac
			inner join pracownicy.partnerzy  as part
					on prac.id_pracownika = part.id_pracownika
			 union all
				select  prac.id_pracownika
					  ,	concat(part.imię,' ',part.nazwisko)
					  , prac.nr_tel_służbowy
					  , prac.email_służbowy 
				  from pracownicy.pracownicy  as prac
			inner join pracownicy.zatrudnieni as part
					on prac.id_pracownika = part.id_pracownika
			)
				select o.id_pracownika
				     , pu.nr_umowy
					 , o.pracownik
				     , o.nr_tel_służbowy
					 , o.email_służbowy
					 , ps.nazwa_stanowiska
					 , psu.id_placówki
					 , isnull(av.kod_pocztowy,'-') as kod_pocztowy
					 , isnull(av.nazwa_miejscowości,'-') as nazwa_miejscowości
					 , isnull(av.nazwa_ulicy,'-') as nazwa_ulicy
				     , isnull(av.nr_budynku,'-') as nr_budynku
				     , isnull(av.nr_pomieszczenia,'-') as nr_pomieszczenia
					 , psu.pensja
					 , psu.początek
					 , psu.koniec
				  from obliczenia as o
				  inner join pracownicy.umowy as pu 
			        on pu.id_pracownika = o.id_pracownika
			inner join pracownicy.szczegóły_umowy as psu
			        on psu.id_umowy = pu.id_umowy
			inner join pracownicy.stanowiska as ps
			        on ps.id_stanowiska = psu.id_stanowiska
			left join pracownicy.placówki as pp
					on pp.id_placówki = psu.id_placówki
			left join [adresy].[viewspis] as av WITH (NOEXPAND) 
					on av.id_adresu = pp.id_adresu
					where psu.id_szczegółu = 
										  (
											 select MAX(psu2.id_szczegółu) 
											   from pracownicy.szczegóły_umowy as psu2
											  where psu2.id_umowy = pu.id_umowy    
										  )
GO
/****** Object:  Table [sprzedaż].[klienci]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[klienci](
	[id_klienta] [int] IDENTITY(1,1) NOT NULL,
	[nr_tel] [int] NULL,
	[email] [varchar](30) NULL,
	[uwagi] [varchar](50) NULL,
	[id_adresu] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_klienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sprzedaż].[klienci_indywidualni]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[klienci_indywidualni](
	[id_klienta] [int] NOT NULL,
	[imię] [varchar](20) NOT NULL,
	[nazwisko] [varchar](30) NOT NULL,
	[pesel] [varchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_klienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sprzedaż].[klienci_biznesowi]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[klienci_biznesowi](
	[id_klienta] [int] NOT NULL,
	[Nazwa] [varchar](30) NOT NULL,
	[Nip] [int] NOT NULL,
	[Regon] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_klienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_pokaż_klientów]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create       view [dbo].[view_pokaż_klientów] as
		    select sk.id_klienta
				 , CONCAT(ski.imię,' ',ski.nazwisko) as klient
				 , ski.pesel as [Regon/Pesel]
				 , '-' as Nip
				 , avs.id_adresu
				 , avs.kod_pocztowy
				 , avs.nazwa_ulicy
				 , avs.nazwa_miejscowości
				 , avs.nr_budynku
				 , avs.nr_pomieszczenia
				 , sk.nr_tel
				 , sk.email
				 , sk.uwagi
			  from sprzedaż.klienci as sk
        inner join adresy.viewspis  as avs WITH (NOEXPAND) 
                on avs.id_adresu = sk.id_adresu
        inner join sprzedaż.klienci_indywidualni as ski
                on sk.id_klienta = ski.id_klienta
		union all
		   select skb.id_klienta
				, skb.nazwa
				, cast(skb.regon as varchar(11))
				, skb.Nip
				, avs.id_adresu
				, avs.kod_pocztowy
				, avs.nazwa_ulicy
				, avs.nazwa_miejscowości
				, avs.nr_budynku
				, avs.nr_pomieszczenia
				, sk.nr_tel
				, sk.email
				, sk.uwagi
			from sprzedaż.klienci as sk
      inner join adresy.viewspis  as avs WITH (NOEXPAND) 
              on avs.id_adresu = sk.id_adresu 
      inner join sprzedaż.klienci_biznesowi as skb
              on sk.id_klienta = skb.id_klienta
GO
/****** Object:  Table [finanse].[stawki_prowizyjne]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [finanse].[stawki_prowizyjne](
	[id_pracownika] [smallint] NOT NULL,
	[id_produktu] [smallint] NOT NULL,
	[prowizja] [decimal](4, 2) NOT NULL,
	[od_kiedy] [date] NOT NULL,
	[do_kiedy] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [finanse].[prowizja]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   function [finanse].[prowizja]
( 
 @id_pracownika smallint
,@id_produktu smallint
,@data_wpisania_polisy date
)
RETURNS TABLE AS RETURN
	Select prowizja
		 , od_kiedy
		 , do_kiedy
	from finanse.stawki_prowizyjne
   where id_pracownika = @id_pracownika
     and id_produktu = @id_produktu
	 and @data_wpisania_polisy between od_kiedy and do_kiedy 
GO
/****** Object:  View [pracownicy].[view_placówki]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   view [pracownicy].[view_placówki] as
		   select pp.id_placówki
				, ads.id_adresu
	            , ads.kod_pocztowy
			    , ads.nazwa_ulicy
			    , ads.nazwa_miejscowości
			    , ads.nr_budynku
			    , ads.nr_pomieszczenia
		     from adresy.viewspis as ads
	   inner join pracownicy.placówki as pp
		       on pp.id_adresu = ads.id_adresu
GO
/****** Object:  Table [biuro].[środki_trwałe]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biuro].[środki_trwałe](
	[id_środka_trwałego] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwa_środka_trwałego] [varchar](30) NOT NULL,
	[sygnatura] [varchar](10) NOT NULL,
	[rok_produkcji] [date] NOT NULL,
	[data_zakupy] [date] NOT NULL,
	[cenna_zakupu] [decimal](8, 2) NOT NULL,
	[sztuk] [int] NULL,
	[uwagi] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_środka_trwałego] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pomocnicza_prowizja]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pomocnicza_prowizja](
	[polecenie] [varchar](6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sprzedaż_TU_osoby_kontaktowe]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sprzedaż_TU_osoby_kontaktowe](
	[id_osoby_kontaktowej] [smallint] IDENTITY(1,1) NOT NULL,
	[imię] [varchar](20) NOT NULL,
	[nazwisko] [varchar](30) NOT NULL,
	[dział] [varchar](20) NULL,
	[id_stanowiska] [smallint] NULL,
	[nr_tel] [int] NULL,
	[email] [varchar](30) NULL,
	[id_tu] [smallint] NULL,
	[uwagii] [varchar](30) NULL,
	[id_regionu_tu] [smallint] NULL,
	[status] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_osoby_kontaktowej] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wagi]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wagi](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[waga] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[działy]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[działy](
	[id_działu] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwa_działu] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_działu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[placówki_środki_trwałe]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[placówki_środki_trwałe](
	[id_placówki] [smallint] NOT NULL,
	[id_środka_trwałego] [smallint] NOT NULL,
	[data_przekazania] [date] NOT NULL,
	[data_zwrócenia] [date] NOT NULL,
	[uwagi] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[pracownicy_środki_trwałe]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[pracownicy_środki_trwałe](
	[id_pracownika] [smallint] NOT NULL,
	[id_środka_trwałego] [smallint] NOT NULL,
	[data_przekazania] [date] NOT NULL,
	[data_zwrócenia] [date] NOT NULL,
	[uwagi] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [pracownicy].[rodzaje_umów]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pracownicy].[rodzaje_umów](
	[id_rodz_umowy] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwa_umowy] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_rodz_umowy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sprzedaż].[loginy]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[loginy](
	[id_loginu] [int] IDENTITY(1,1) NOT NULL,
	[id_pracownika] [smallint] NOT NULL,
	[id_tu] [smallint] NOT NULL,
	[login] [varchar](20) NULL,
	[data_przyznania] [date] NOT NULL,
	[data_zakończenia] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_loginu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sprzedaż].[oddział_regionalny_TU]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[oddział_regionalny_TU](
	[id_regionu_tu] [smallint] IDENTITY(1,1) NOT NULL,
	[id_tu] [smallint] NULL,
	[nazwa_tu] [varchar](30) NOT NULL,
	[miejscowość] [varchar](30) NOT NULL,
	[ulica] [varchar](20) NOT NULL,
	[nr_budynku] [varchar](5) NULL,
	[rr_lokalu] [varchar](5) NULL,
	[kod_pocztowy] [varchar](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_regionu_tu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sprzedaż].[polisy]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[polisy](
	[id_polisy] [bigint] IDENTITY(1,1) NOT NULL,
	[nr_polisy] [varchar](20) NOT NULL,
	[id_klienta] [int] NOT NULL,
	[id_pracownika] [smallint] NOT NULL,
	[id_produktu] [smallint] NOT NULL,
	[data_wystawienia_polisy] [date] NOT NULL,
	[data_wpisania_polisy] [date] NOT NULL,
	[początek_ubezpieczenia] [date] NOT NULL,
	[koniec_ubezpieczenia] [date] NOT NULL,
	[id_statusu] [smallint] NOT NULL,
	[składka] [decimal](9, 2) NOT NULL,
	[raty] [smallint] NOT NULL,
	[termin_pierwszej_raty] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_polisy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sprzedaż].[produkty]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[produkty](
	[id_produktu] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwa_produktu] [varchar](50) NOT NULL,
	[id_tu] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_produktu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sprzedaż].[status]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[status](
	[id_statusu] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwa_statusu] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_statusu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sprzedaż].[towarzystwa_ubezpieczeniowe]    Script Date: 26.08.2022 11:43:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sprzedaż].[towarzystwa_ubezpieczeniowe](
	[id_tu] [smallint] IDENTITY(1,1) NOT NULL,
	[nazwa_tu] [varchar](30) NOT NULL,
	[miejscowość] [varchar](30) NOT NULL,
	[ulica] [varchar](20) NOT NULL,
	[nr_budynku] [varchar](5) NULL,
	[rr_lokalu] [varchar](5) NULL,
	[kod_pocztowy] [varchar](6) NOT NULL,
	[regon] [int] NULL,
	[nip] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nazwa]    Script Date: 26.08.2022 11:43:43 ******/
CREATE NONCLUSTERED INDEX [idx_nazwa] ON [pracownicy].[partnerzy]
(
	[nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [id_umowy]    Script Date: 26.08.2022 11:43:43 ******/
CREATE NONCLUSTERED INDEX [id_umowy] ON [pracownicy].[szczegóły_umowy]
(
	[id_umowy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_imie_nazwisko]    Script Date: 26.08.2022 11:43:43 ******/
CREATE NONCLUSTERED INDEX [idx_imie_nazwisko] ON [pracownicy].[zatrudnieni]
(
	[nazwisko] ASC,
	[imię] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_nazwa]    Script Date: 26.08.2022 11:43:43 ******/
CREATE NONCLUSTERED INDEX [idx_nazwa] ON [sprzedaż].[klienci_biznesowi]
(
	[Nazwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_imie_nazwisko_K]    Script Date: 26.08.2022 11:43:43 ******/
CREATE NONCLUSTERED INDEX [idx_imie_nazwisko_K] ON [sprzedaż].[klienci_indywidualni]
(
	[nazwisko] ASC,
	[imię] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [adresy].[adresy]  WITH CHECK ADD  CONSTRAINT [adresy_id_kodu_pocztowego] FOREIGN KEY([id_kodu_pocztowego])
REFERENCES [adresy].[kody_pocztowe] ([id_kodu_pocztowego])
GO
ALTER TABLE [adresy].[adresy] CHECK CONSTRAINT [adresy_id_kodu_pocztowego]
GO
ALTER TABLE [adresy].[adresy]  WITH CHECK ADD  CONSTRAINT [adresy_id_ulicy] FOREIGN KEY([id_ulicy])
REFERENCES [adresy].[ulice] ([id_ulicy])
GO
ALTER TABLE [adresy].[adresy] CHECK CONSTRAINT [adresy_id_ulicy]
GO
ALTER TABLE [adresy].[kody_pocztowe]  WITH CHECK ADD  CONSTRAINT [id_miejsc_miejscowości] FOREIGN KEY([id_miejscowości])
REFERENCES [adresy].[miejscowości] ([id_miejscowości])
GO
ALTER TABLE [adresy].[kody_pocztowe] CHECK CONSTRAINT [id_miejsc_miejscowości]
GO
ALTER TABLE [dbo].[sprzedaż_TU_osoby_kontaktowe]  WITH CHECK ADD  CONSTRAINT [osoby_id_tu] FOREIGN KEY([id_regionu_tu])
REFERENCES [sprzedaż].[oddział_regionalny_TU] ([id_regionu_tu])
GO
ALTER TABLE [dbo].[sprzedaż_TU_osoby_kontaktowe] CHECK CONSTRAINT [osoby_id_tu]
GO
ALTER TABLE [dbo].[sprzedaż_TU_osoby_kontaktowe]  WITH CHECK ADD  CONSTRAINT [osoby_kontaktowe_id_tu] FOREIGN KEY([id_tu])
REFERENCES [sprzedaż].[towarzystwa_ubezpieczeniowe] ([id_tu])
GO
ALTER TABLE [dbo].[sprzedaż_TU_osoby_kontaktowe] CHECK CONSTRAINT [osoby_kontaktowe_id_tu]
GO
ALTER TABLE [finanse].[stawki_prowizyjne]  WITH CHECK ADD  CONSTRAINT [id_prac_pracownicy] FOREIGN KEY([id_pracownika])
REFERENCES [pracownicy].[pracownicy] ([id_pracownika])
GO
ALTER TABLE [finanse].[stawki_prowizyjne] CHECK CONSTRAINT [id_prac_pracownicy]
GO
ALTER TABLE [finanse].[stawki_prowizyjne]  WITH CHECK ADD  CONSTRAINT [id_prod_sprzedaż] FOREIGN KEY([id_produktu])
REFERENCES [sprzedaż].[produkty] ([id_produktu])
GO
ALTER TABLE [finanse].[stawki_prowizyjne] CHECK CONSTRAINT [id_prod_sprzedaż]
GO
ALTER TABLE [pracownicy].[partnerzy]  WITH CHECK ADD  CONSTRAINT [id_pracownika_partnerzy_pracownicy] FOREIGN KEY([id_pracownika])
REFERENCES [pracownicy].[pracownicy] ([id_pracownika])
GO
ALTER TABLE [pracownicy].[partnerzy] CHECK CONSTRAINT [id_pracownika_partnerzy_pracownicy]
GO
ALTER TABLE [pracownicy].[placówki]  WITH CHECK ADD  CONSTRAINT [adres_placówki] FOREIGN KEY([id_adresu])
REFERENCES [adresy].[adresy] ([id_adresu])
GO
ALTER TABLE [pracownicy].[placówki] CHECK CONSTRAINT [adres_placówki]
GO
ALTER TABLE [pracownicy].[placówki_środki_trwałe]  WITH CHECK ADD  CONSTRAINT [id_placówki_srodki_prwałe_pracownicy] FOREIGN KEY([id_placówki])
REFERENCES [pracownicy].[placówki] ([id_placówki])
GO
ALTER TABLE [pracownicy].[placówki_środki_trwałe] CHECK CONSTRAINT [id_placówki_srodki_prwałe_pracownicy]
GO
ALTER TABLE [pracownicy].[placówki_środki_trwałe]  WITH CHECK ADD  CONSTRAINT [id_środka_trwałego_środki_trwałe2] FOREIGN KEY([id_środka_trwałego])
REFERENCES [biuro].[środki_trwałe] ([id_środka_trwałego])
GO
ALTER TABLE [pracownicy].[placówki_środki_trwałe] CHECK CONSTRAINT [id_środka_trwałego_środki_trwałe2]
GO
ALTER TABLE [pracownicy].[pracownicy_środki_trwałe]  WITH CHECK ADD  CONSTRAINT [id_pracownika_srodki_trwałe_pracownicy] FOREIGN KEY([id_pracownika])
REFERENCES [pracownicy].[pracownicy] ([id_pracownika])
GO
ALTER TABLE [pracownicy].[pracownicy_środki_trwałe] CHECK CONSTRAINT [id_pracownika_srodki_trwałe_pracownicy]
GO
ALTER TABLE [pracownicy].[pracownicy_środki_trwałe]  WITH CHECK ADD  CONSTRAINT [id_środka_trwałego_środki_trwałe] FOREIGN KEY([id_środka_trwałego])
REFERENCES [biuro].[środki_trwałe] ([id_środka_trwałego])
GO
ALTER TABLE [pracownicy].[pracownicy_środki_trwałe] CHECK CONSTRAINT [id_środka_trwałego_środki_trwałe]
GO
ALTER TABLE [pracownicy].[stanowiska]  WITH CHECK ADD  CONSTRAINT [_id_stanowiska_id_przełożonego] FOREIGN KEY([id_stanowiska_przełożonego])
REFERENCES [pracownicy].[stanowiska] ([id_stanowiska])
GO
ALTER TABLE [pracownicy].[stanowiska] CHECK CONSTRAINT [_id_stanowiska_id_przełożonego]
GO
ALTER TABLE [pracownicy].[stanowiska]  WITH CHECK ADD  CONSTRAINT [pracownicy_stanowiska_id_działu] FOREIGN KEY([id_działu])
REFERENCES [pracownicy].[działy] ([id_działu])
GO
ALTER TABLE [pracownicy].[stanowiska] CHECK CONSTRAINT [pracownicy_stanowiska_id_działu]
GO
ALTER TABLE [pracownicy].[szczegóły_umowy]  WITH CHECK ADD  CONSTRAINT [id_placówki_szczegóły_pacówki] FOREIGN KEY([id_placówki])
REFERENCES [pracownicy].[placówki] ([id_placówki])
GO
ALTER TABLE [pracownicy].[szczegóły_umowy] CHECK CONSTRAINT [id_placówki_szczegóły_pacówki]
GO
ALTER TABLE [pracownicy].[szczegóły_umowy]  WITH CHECK ADD  CONSTRAINT [id_stanowiska_szczegóły_stanowiska] FOREIGN KEY([id_stanowiska])
REFERENCES [pracownicy].[stanowiska] ([id_stanowiska])
GO
ALTER TABLE [pracownicy].[szczegóły_umowy] CHECK CONSTRAINT [id_stanowiska_szczegóły_stanowiska]
GO
ALTER TABLE [pracownicy].[szczegóły_umowy]  WITH CHECK ADD  CONSTRAINT [id_umowy_umowy__szczegóły] FOREIGN KEY([id_umowy])
REFERENCES [pracownicy].[umowy] ([id_umowy])
GO
ALTER TABLE [pracownicy].[szczegóły_umowy] CHECK CONSTRAINT [id_umowy_umowy__szczegóły]
GO
ALTER TABLE [pracownicy].[umowy]  WITH CHECK ADD  CONSTRAINT [id_pracownika_umowy_pracownicy] FOREIGN KEY([id_pracownika])
REFERENCES [pracownicy].[pracownicy] ([id_pracownika])
GO
ALTER TABLE [pracownicy].[umowy] CHECK CONSTRAINT [id_pracownika_umowy_pracownicy]
GO
ALTER TABLE [pracownicy].[umowy]  WITH CHECK ADD  CONSTRAINT [umowy_rodzaje_umów] FOREIGN KEY([id_rodz_umowy])
REFERENCES [pracownicy].[rodzaje_umów] ([id_rodz_umowy])
GO
ALTER TABLE [pracownicy].[umowy] CHECK CONSTRAINT [umowy_rodzaje_umów]
GO
ALTER TABLE [pracownicy].[zatrudnieni]  WITH CHECK ADD  CONSTRAINT [id_pracownika_zatrudnieni_pracownicy] FOREIGN KEY([id_pracownika])
REFERENCES [pracownicy].[pracownicy] ([id_pracownika])
GO
ALTER TABLE [pracownicy].[zatrudnieni] CHECK CONSTRAINT [id_pracownika_zatrudnieni_pracownicy]
GO
ALTER TABLE [sprzedaż].[klienci_biznesowi]  WITH CHECK ADD  CONSTRAINT [fk_id_klienta_biznesowego] FOREIGN KEY([id_klienta])
REFERENCES [sprzedaż].[klienci] ([id_klienta])
GO
ALTER TABLE [sprzedaż].[klienci_biznesowi] CHECK CONSTRAINT [fk_id_klienta_biznesowego]
GO
ALTER TABLE [sprzedaż].[klienci_indywidualni]  WITH CHECK ADD  CONSTRAINT [fk_id_klienta] FOREIGN KEY([id_klienta])
REFERENCES [sprzedaż].[klienci] ([id_klienta])
GO
ALTER TABLE [sprzedaż].[klienci_indywidualni] CHECK CONSTRAINT [fk_id_klienta]
GO
ALTER TABLE [sprzedaż].[loginy]  WITH CHECK ADD  CONSTRAINT [login_id_tu] FOREIGN KEY([id_tu])
REFERENCES [sprzedaż].[towarzystwa_ubezpieczeniowe] ([id_tu])
GO
ALTER TABLE [sprzedaż].[loginy] CHECK CONSTRAINT [login_id_tu]
GO
ALTER TABLE [sprzedaż].[oddział_regionalny_TU]  WITH CHECK ADD  CONSTRAINT [id_tu_fk] FOREIGN KEY([id_tu])
REFERENCES [sprzedaż].[towarzystwa_ubezpieczeniowe] ([id_tu])
GO
ALTER TABLE [sprzedaż].[oddział_regionalny_TU] CHECK CONSTRAINT [id_tu_fk]
GO
ALTER TABLE [sprzedaż].[polisy]  WITH CHECK ADD  CONSTRAINT [fk_id_klienta_sprzedaż_ubezpieczeń] FOREIGN KEY([id_klienta])
REFERENCES [sprzedaż].[klienci] ([id_klienta])
GO
ALTER TABLE [sprzedaż].[polisy] CHECK CONSTRAINT [fk_id_klienta_sprzedaż_ubezpieczeń]
GO
ALTER TABLE [sprzedaż].[polisy]  WITH CHECK ADD  CONSTRAINT [fk_id_pracownika_sprzedaż_ubezpieczeń] FOREIGN KEY([id_pracownika])
REFERENCES [pracownicy].[pracownicy] ([id_pracownika])
GO
ALTER TABLE [sprzedaż].[polisy] CHECK CONSTRAINT [fk_id_pracownika_sprzedaż_ubezpieczeń]
GO
ALTER TABLE [sprzedaż].[polisy]  WITH CHECK ADD  CONSTRAINT [fk_id_produktu_sprzedaż_ubezpieczeń] FOREIGN KEY([id_produktu])
REFERENCES [sprzedaż].[produkty] ([id_produktu])
GO
ALTER TABLE [sprzedaż].[polisy] CHECK CONSTRAINT [fk_id_produktu_sprzedaż_ubezpieczeń]
GO
ALTER TABLE [sprzedaż].[polisy]  WITH CHECK ADD  CONSTRAINT [fk_id_statusu_sprzedaż_ubezpieczeń] FOREIGN KEY([id_statusu])
REFERENCES [sprzedaż].[status] ([id_statusu])
GO
ALTER TABLE [sprzedaż].[polisy] CHECK CONSTRAINT [fk_id_statusu_sprzedaż_ubezpieczeń]
GO
ALTER TABLE [sprzedaż].[produkty]  WITH CHECK ADD  CONSTRAINT [fk_id_tu_produkty] FOREIGN KEY([id_tu])
REFERENCES [sprzedaż].[towarzystwa_ubezpieczeniowe] ([id_tu])
GO
ALTER TABLE [sprzedaż].[produkty] CHECK CONSTRAINT [fk_id_tu_produkty]
GO
/****** Object:  StoredProcedure [adresy].[dodaj_adres]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [adresy].[dodaj_adres]
(
	@nazwa_miejscowości varchar(50),
	@kod_pocztowy char(6),
	@nazwa_ulicy varchar(60) = bez_ulicy,
	@nr_budynku varchar(4),
	@nr_pomieszczenia varchar(4) = null,
    @id_adresu as int = null output
)
as
begin try
begin tran
-- deklaracja zmiennych, które zostaną wykorzystane w poniższych fragmentach
declare @id_miejscowości as int
declare @id_kodu_pocztowego_sc_i as smallint
declare @id_kodu_pocztowego as smallint
declare @id_ulicy_sc_i as int
-- odnalezienie id_kodu pocztowego z argumentu który został przekazany przez użytkownika
set @id_kodu_pocztowego = 
						     ( 
								select id_kodu_pocztowego 
								  from adresy.kody_pocztowe
								 where kod_pocztowy = @kod_pocztowy
							 )
-- odnalezienie id_ulicy z argumentu który został przekazany przez użytkownika
declare @id_ulicy int
set @id_ulicy =
							(
									select id_ulicy 
									  from adresy.ulice 
									 where nazwa_ulicy = @nazwa_ulicy
							)
/* 
  Sprawdzenie czy w tabeli adresy jestnieją id_kodu_pocztowego oraz id_ulicy.
  Jeśli tak procedura w następnym kroku sprawdzi czy dokłądny adres istnieje już w bazie
  i jeśli tak pobierze jego id w celu przekazania do paramtertu output, który zostanie wykorzystany
  w innych procedurach
 */
if exists (
		   select id_kodu_pocztowego
				, id_ulicy
			 from adresy.adresy
			where id_kodu_pocztowego = @id_kodu_pocztowego
			  and id_ulicy           = @id_ulicy
		  )
		   begin 
				if exists (
							select id_kodu_pocztowego
				                 , id_ulicy
			                  from adresy.adresy
			                 where id_kodu_pocztowego = @id_kodu_pocztowego
			                   and id_ulicy = @id_ulicy 
							   and nr_budynku = @nr_budynku
							   and nr_pomieszczenia = @nr_pomieszczenia
						   )
						    begin
								 select 'Adres już w bazie' as komunikat
								    set @id_adresu = 
												  (
												   select id_adresu
											         from adresy.adresy
													where id_kodu_pocztowego = @id_kodu_pocztowego
													  and id_ulicy = @id_ulicy
													  and nr_budynku = @nr_budynku
													  and nr_pomieszczenia = @nr_pomieszczenia
												  )
							end
					else 
-- za sprawą tego fragmentu dodajemy do bazy danych numer budynku oraz numer lokalu
							begin 
									insert into.adresy.adresy
									values(@id_kodu_pocztowego,@id_ulicy,@nr_budynku,@nr_pomieszczenia)
									set @id_adresu = (select SCOPE_IDENTITY())
							end
		   end 
/* w przypadku gdy podany adres nie istnieje za sprawą procedury będzimy sprawdzać 
   czy istnieją poszczególne elementy i jeśli nie to zostaną dodane do odpowiednich tabel
*/
else 
/*jeżeli przekazana wartość w argumencie w postaci nazwwy miasta nie istnieje zostanie ona
dodana. Zakładając że nie istnieje miasto to nie może istnieć i kod pocztowy W przeciwnim wypadku zostanie wyciągnięta wartość id. 
*/
	if not exists (
				   select nazwa_miejscowości 
					 from adresy.miejscowości
					where nazwa_miejscowości = @nazwa_miejscowości
				  )
				begin 
					insert into adresy.miejscowości
						 values (@nazwa_miejscowości)
							set @id_miejscowości = (select SCOPE_IDENTITY())
					insert into adresy.kody_pocztowe
						 values (@kod_pocztowy,@id_miejscowości)
							set @id_kodu_pocztowego_sc_i = (select SCOPE_IDENTITY())
							 if not exists 
/*jeżeli również nie istnieje przekazana w argumencie ulica to zostanie dodana do bazy danych.
wartość id wyciągnięta i przekazana do tabeli adres.adresy.
*/
											(
											   Select nazwa_ulicy 
												 from adresy.ulice
												where nazwa_ulicy = @nazwa_ulicy
											)
								begin
									insert into adresy.ulice
										 values(@nazwa_ulicy)
											set @id_ulicy_sc_i = (select SCOPE_IDENTITY())
									insert into adresy.adresy
										 values(@id_kodu_pocztowego_sc_i,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
											set @id_adresu = (select SCOPE_IDENTITY())
								end
							else
-- w przypadku gdyby ulica istniała zostania pobrana wartość id_ulicy
								begin
									set @id_ulicy_sc_i = 
														(
															Select id_ulicy
															from adresy.ulice
															where nazwa_ulicy = @nazwa_ulicy
														)
									   insert into adresy.adresy
											values(@id_kodu_pocztowego_sc_i,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
											   set @id_adresu = (select SCOPE_IDENTITY())
								end
				end
	else
/*powyższy fragment kodu dotyczył gdyby miasto nie istniało. 
Poniższy będzie analizował dane gdyby miasto istniało 
*/
	begin
		 set @id_miejscowości = 
								(
								  select id_miejscowości 
									from adresy.miejscowości
								   where nazwa_miejscowości = @nazwa_miejscowości
								)
-- miasta często mają kilka kodów, więc następuje sprawdzenie czy podany przez argument kod pocztowy istnieje
		 if not exists 				
					  (
						select kod_pocztowy 
						  from adresy.kody_pocztowe
						 where kod_pocztowy = @kod_pocztowy
					  )
						begin
							insert into adresy.kody_pocztowe
								 values (@kod_pocztowy,@id_miejscowości)
									set @id_kodu_pocztowego_sc_i = (select SCOPE_IDENTITY())
						     if not exists  
											(
											   Select nazwa_ulicy 
												 from adresy.ulice
												where nazwa_ulicy = @nazwa_ulicy
											)
											begin
												  insert into adresy.ulice
														 values(@nazwa_ulicy)
														set @id_ulicy_sc_i = (select SCOPE_IDENTITY())
												  insert into adresy.adresy
														values(@id_kodu_pocztowego_sc_i,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
														set @id_adresu = (select SCOPE_IDENTITY())
											end
									 else 
									        begin
													set @id_ulicy_sc_i = 
																		(
																			Select id_ulicy
																			from adresy.ulice
																			where nazwa_ulicy = @nazwa_ulicy
																		)
													insert into adresy.adresy
														values(@id_kodu_pocztowego_sc_i,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
															set @id_adresu = (select SCOPE_IDENTITY())
						                    end
						    end
				else
-- w tym przypadku sprawdzamy dalesze elementy gdyby kod pocztowy był już wcześniej w bazie 
				if not exists  
											(
											   Select nazwa_ulicy 
												 from adresy.ulice
												where nazwa_ulicy = @nazwa_ulicy
											)
											begin
												  insert into adresy.ulice
														 values(@nazwa_ulicy)
														set @id_ulicy_sc_i = (select SCOPE_IDENTITY())
												  insert into adresy.adresy
														values(@id_kodu_pocztowego,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
														set @id_adresu = (select SCOPE_IDENTITY())
											end
									 else 
									        begin
													set @id_ulicy_sc_i = 
																		(
																			Select id_ulicy
																			from adresy.ulice
																			where nazwa_ulicy = @nazwa_ulicy
																		)
													insert into adresy.adresy
														values(@id_kodu_pocztowego,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
															set @id_adresu = (select SCOPE_IDENTITY())
											end
	end
	commit
	end try
	begin catch
	rollback; throw
	end catch 
GO
/****** Object:  StoredProcedure [finanse].[dodaj_stawki_prowizyjne]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [finanse].[dodaj_stawki_prowizyjne]
(
 @polecenie as varchar(6),
 @id_pracownika as int,
 @nazwa_produktu varchar(50),
 @prowizja decimal (4,2),
 @od_kiedy date,
 @do_kiedy date = '20991231'
)
as
	declare @id_produktu as smallint = 
									  ( 
									    select id_produktu 
									      from sprzedaż.produkty
										 where nazwa_produktu = @nazwa_produktu
								      )
	if not exists  ( 
					 select polecenie 
					   from pomocnicza_prowizja
					  where polecenie = @polecenie
					)
		begin
				select 'błędne polecenie' as komunikat
		end
	else
		begin
		 if @polecenie = 'nowe'
		     begin
				if exists (
				             select id_pracownika
							      , id_produktu
								  , od_kiedy
							   from finanse.stawki_prowizyjne
							  where id_pracownika = @id_pracownika
							    and   id_produktu = @id_produktu
						   )
							   begin 
									select ('już takie dane wprowadzono wcześniej') as komunikat
							   end
				 else
						begin
							insert into finanse.stawki_prowizyjne
								values(@id_pracownika,@id_produktu,@prowizja,@od_kiedy,@do_kiedy)
						end
			   end 
		  else
		    begin
			update finanse.stawki_prowizyjne
					set do_kiedy = dateadd(day,-1,@od_kiedy)
				  where id_pracownika = @id_pracownika 
					and id_produktu   = @id_produktu
					and od_kiedy      = (
										   select MAX(od_kiedy) 
											 from finanse.stawki_prowizyjne
											where id_pracownika = @id_pracownika
										)
					insert into finanse.stawki_prowizyjne
					values(@id_pracownika,@id_produktu,@prowizja,@od_kiedy,@do_kiedy)
			end
		end
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_aneks_do_umowy]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [pracownicy].[dodaj_aneks_do_umowy]
(
@nr_umowy      as varchar(10),
@nr_aneksu     as varchar(10),
@pensja        as decimal(7,2) = null,
@id_stanowiska as smallint     = null,
@id_placówka   as smallint     = null,
@początek      as date,
@koniec        as date         = null
)
as
----sprawdzenie czy dany aneks już istnieje dla danej umowy. Jeśli tak procedura wświetli 
----stosowny komunikat i zostanie zatrzymana.
if exists (
		     select nr_aneksu 
               from pracownicy.szczegóły_umowy
			  where nr_aneksu = @nr_aneksu
			    and id_umowy = (
								 select id_umowy 
								   from pracownicy.umowy
								  where nr_umowy = @nr_umowy
							    )

		   )
begin
	Select 'Już istnieje taki ankes. Popraw numer' as komunikat
end
---- w przypadku poprawnej numeracji procedura wykona poniższe kroki i wpisze aneks do umowy
---- uwzględniając podane parametry
else
begin
begin try
begin tran
declare @id_pracownika   as int 
declare @id_umowy        as int
declare @pensja_s        as decimal(7,2)
declare @id_stanowiska_s as smallint
declare @id_placówki_s   as smallint
----
		set @id_umowy = (
						 select id_umowy 
						   from pracownicy.umowy
						  where nr_umowy = @nr_umowy
						)

		select @id_pracownika   = pu.id_pracownika 
			 , @pensja_s        = su.pensja
			 , @id_stanowiska_s = su.id_stanowiska
			 , @id_placówki_s   = su.id_placówki
		  from pracownicy.szczegóły_umowy as su
	inner join pracownicy.umowy as pu
		    on su.id_umowy = pu.id_umowy
		 where nr_umowy = @nr_umowy
		   and początek =  (
							select MAX(początek) 
						      from pracownicy.szczegóły_umowy
						     where id_umowy = @id_umowy
						  )
-----
	update pracownicy.szczegóły_umowy
	   set koniec = (DATEADD(d,-1,@początek))
	 where id_umowy    = @id_umowy 
	   and początek    = (
							select MAX(początek) 
							  from pracownicy.szczegóły_umowy
							 where id_umowy = @id_umowy
						  )
----- funkcja coalesce przepisze dane, które nie zostały zmienione. 						
	insert into pracownicy.szczegóły_umowy
	values (@id_umowy,@nr_aneksu,coalesce(@pensja,@pensja_s)
	,coalesce(@id_stanowiska,@id_stanowiska_s),coalesce(@id_placówka,@id_placówki_s),@początek,@koniec)
-----
select 'dodano aneks' as komunikat
commit
end try
	begin catch
		rollback
		print 'transakcja nie powiodła się'
		--;throw
	end catch
end
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_partnera]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [pracownicy].[dodaj_partnera]
(
 @nazwa              varchar(30),
 @nip                int,
 @regon              int,
 @miejscowość        varchar(30),
 @ulica              varchar(20) = null,
 @nr_budynku         varchar(5),
 @nr_lokalu          varchar(5) = null,
 @kod_pocztowy       varchar(6),
 @nr_tel_prywatny        int = null,
 @email_prywatny     varchar(30) = null,
 @nr_tel_służbowy        int = null,
 @email_służbowy     varchar(30) = null,
 @nr_konta_bankowego varchar(26) = null,
 @nazwa_banku        varchar(20) = null,
 @uwagi              varchar(50) = null
)
as
begin try
begin tran
 ----- Sprawdzenie czy numer nip istnieje już w bazie
   if exists (
			   select nip 
				 from pracownicy.partnerzy
			    where nip = @nip
			  )
	  begin
			select 'Partner już w bazie' as komunikat
	  end
   else
	   begin
----- Dodanie adres korespondencyjnego do bazy oraz zwrot id
			declare @id_adresu as int
				exec adresy.dodaj_adres
				@nazwa_miejscowości  = @Miejscowość,
				@kod_pocztowy        = @kod_pocztowy,
				@nazwa_ulicy         = @Ulica,
				@Nr_budynku          = @Nr_budynku,
				@nr_pomieszczenia    = @Nr_lokalu,
				@id_adresu = @id_adresu output
----- Dodanie danych do tabeli pracownicy.pracownicy
			insert into pracownicy.pracownicy
			values(@nr_tel_służbowy,@email_służbowy,@nr_konta_bankowego
					,@nazwa_banku,@id_adresu,@uwagi)
----- Uzyskanie ostatniego numeru id_pracownika
			declare @id_pracownika as smallint
			set @id_pracownika = (select SCOPE_IDENTITY())
----- Dodanie danych do tabeli pracownicy.partnerzy
			insert into pracownicy.partnerzy
			values(@id_pracownika,@nazwa,@nip,@regon)
	end
commit
end try
begin catch
begin	    
rollback		
         Select 'Błąd. Partner nie został dodany' as komunikat
		 declare @id_pracownika_s as int
           set @id_pracownika_s = 
								   (
						            select isnull(max(id_pracownika),0)
		                              from pracownicy.pracownicy
					               )
dbcc checkident('pracownicy.pracownicy',reseed,@id_pracownika_s)
;throw
end
end catch
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_placówkę]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [pracownicy].[dodaj_placówkę]
(
@Miejscowość		      varchar(30),
@Ulica					  varchar(20) = bez_ulicy,
@Nr_budynku				  varchar(5),
@Nr_lokalu				  varchar(5)  = null,
@kod_pocztowy			  varchar(6)
)
as
begin try
begin tran
---sprawdzenie czy podany adres placówki nie istnieje w bazie. Jeśli nie zostanie dodany
					declare @id_adresu as int
					exec adresy.dodaj_adres
					@nazwa_miejscowości  = @Miejscowość,
					@kod_pocztowy        = @kod_pocztowy,
					@nazwa_ulicy         = @Ulica,
					@Nr_budynku          = @Nr_budynku,
					@nr_pomieszczenia    = @Nr_lokalu	,
					@id_adresu = @id_adresu output
			  
			  if exists (
						  select id_adresu 
			                from pracownicy.placówki
						   where id_adresu = @id_adresu
						)
				begin
						select 'Placówka już istnieje' as komunikat
				end
			  else
			    begin
						insert into pracownicy.placówki
						values(@id_adresu)
				end 
commit
end try
begin catch
rollback
declare @id_placówki_s as int 
set @id_placówki_s = (
								       select MAX(@id_placówki_s) 
										 from pracownicy.placówki
									   )
dbcc checkident ('pracownicy.placówki',reseed,@id_placówki_s)
end catch
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_umowę_partnera]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     proc [pracownicy].[dodaj_umowę_partnera]
(
	@nr_umowy varchar(10),
	@nip as int,
	@nazwa_umowy as varchar(20),
	@początek_umowy as date,
	@koniec_umowy as date = null,
	@pensja as decimal(7,2),
	@nazwa_stanowiska as varchar(50),
	@nazwa_miejscowości_placówki varchar(50) = null,
	@kod_pocztowy_placówki char(6) = null,
	@nazwa_ulicy_placówki varchar(60) = null,
	@nr_budynku_placówki varchar(4) = null,
	@nr_pomieszczenia_placówki varchar(4) = null
)
as
/*
Sprawdzenie czy dany numer umowy znajduje się już w bazie. Jeśli tak pozostałe dzialania
zostaną wstrzymane 
*/
begin try 
begin tran
		if exists 
				 (
					select nr_umowy 
					  from pracownicy.umowy
					 where nr_umowy = @nr_umowy
				 )
		  begin
					select 'taka umowa już istnieje - poraw błąd' as komunikat
		  end 
	 else
-- gdy danego numeru nie ma w bazie procedura pobierze id partnera
			  begin
					declare @id_pracownika_partner as smallint
						set @id_pracownika_partner = 
													 ( 
														select id_pracownika 
														  from pracownicy.partnerzy
														 where nip = @nip
													 )
-- pobranie numeru id rodzaju umowy
					declare @id_rodz_umowy as smallint 
					    set @id_rodz_umowy = 
											    (
												  select id_rodz_umowy 
												    from pracownicy.rodzaje_umów
												   where nazwa_umowy = @nazwa_umowy
												)
-- dane zostaną dodane do tabeli pracownicy.umowy
					insert into pracownicy.umowy
					values(@nr_umowy,@id_pracownika_partner,@id_rodz_umowy)
----uzyskanie id_numer_umowy i przekazanie wartości dalej
					declare @id_umowy as int
					    set @id_umowy = (select SCOPE_IDENTITY())
----uzyskanie wartości zmiennych z przekazanych parametrów
					declare @id_stanowiska as int 
						set @id_stanowiska = 
											 (
											   select id_stanowiska 
											     from pracownicy.stanowiska
												where nazwa_stanowiska = @nazwa_stanowiska
										     )
-- w przypadku gdy @nazwa miejscowości to null jest to informacja że partner nie będzie pracował w placówce
					if @nazwa_miejscowości_placówki is null
						begin 
							insert into pracownicy.szczegóły_umowy(id_umowy,pensja,id_stanowiska,początek,koniec)
							values(@id_umowy,@pensja,@id_stanowiska,@początek_umowy,@koniec_umowy)
						end
					else
					    begin
								declare @id_kodu_pocztowego as smallint
									set @id_kodu_pocztowego = 
															 ( 
																select id_kodu_pocztowego 
																  from adresy.kody_pocztowe
																 where kod_pocztowy = @kod_pocztowy_placówki
															 )
								declare @id_ulicy int
									set @id_ulicy =
												   (
												     select id_ulicy 
													   from adresy.ulice 
												      where nazwa_ulicy = @nazwa_ulicy_placówki
												   )
								declare @id_adresu int
									set @id_adresu = 
													  (
													   select id_adresu
														 from adresy.adresy
														where id_kodu_pocztowego = @id_kodu_pocztowego
														  and id_ulicy = @id_ulicy
														  and nr_budynku = @nr_budynku_placówki
														  and nr_pomieszczenia = @nr_pomieszczenia_placówki
													  )
								declare @id_placówki as smallint 
										set @id_placówki =
														  (
														    select id_placówki 
															 from pracownicy.placówki
															where id_adresu = @id_adresu
														  )
-- dodanie informacji do tabeli pracownicy.szczegóły_umowy
							insert into pracownicy.szczegóły_umowy(id_umowy,pensja,id_stanowiska,id_placówki,początek,koniec)
							values(@id_umowy,@pensja,@id_stanowiska,@id_placówki,@początek_umowy,@koniec_umowy)
						end
				end
commit
end try
begin catch
begin
		rollback 
		select 'Nie dodano umowy. Popraw dane' as komunikat
		        declare @id as int 
				    set @id = 
							 (
							  select isnull(MAX(id_umowy),0) 
							    from pracownicy.umowy
							 )
				dbcc checkident ('pracownicy.umowy',reseed,@id)
				declare @id2 as int 
				    set @id2 = 
							 (
							  select isnull(MAX(id_szczegółu),0) 
							    from pracownicy.szczegóły_umowy
							 )
				dbcc checkident ('pracownicy.szczegóły_umowy',reseed,@id2)
;throw
end
end catch
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_umowę_zatrudnionego]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     proc [pracownicy].[dodaj_umowę_zatrudnionego]
(
	@nr_umowy varchar(10),
	@pesel as varchar(11),
	@nazwa_umowy as varchar(20),
	@początek_umowy as date,
	@koniec_umowy as date = null,
	@pensja as decimal(7,2),
	@nazwa_stanowiska as varchar(50),
	@nazwa_miejscowości_placówki varchar(50),
	@kod_pocztowy_placówki char(6),
	@nazwa_ulicy_placówki varchar(60) = null,
	@nr_budynku_placówki varchar(4),
	@nr_pomieszczenia_placówki varchar(4) = null
)
as
begin try 
begin tran
/*
Sprawdzenie czy dany numer umowy znajduje się już w bazie. Jeśli tak pozostałe dzialania
zostaną wstrzymane 
*/
		if exists 
				 (
					select nr_umowy 
					  from pracownicy.umowy
					 where nr_umowy = @nr_umowy
				 )
		  begin
					select 'taka umowa już istnieje - poraw błąd' as komunikat
		  end 
	 else
-- gdy danego numeru nie ma w bazie procedura pobierze id zatrudnionego pracownika
			  begin
					declare @id_pracownika_zatrudnionego as smallint
						set @id_pracownika_zatrudnionego = 
														 ( 
															select id_pracownika 
															  from pracownicy.zatrudnieni
															 where pesel = @pesel
														 )
-- pobranie numeru id rodzaju umowy
					declare @id_rodz_umowy as smallint 
					    set @id_rodz_umowy = 
											    (
												  select id_rodz_umowy 
												    from pracownicy.rodzaje_umów
												   where nazwa_umowy = @nazwa_umowy
												)
-- dane zostaną dodane do tabeli pracownicy.umowy
					insert into pracownicy.umowy
					values(@nr_umowy,@id_pracownika_zatrudnionego
					      ,@id_rodz_umowy)
----uzyskanie id_numer_umowy i przekazanie wartości dalej
					declare @id_umowy as int
					    set @id_umowy = (select SCOPE_IDENTITY())
----uzyskanie wartości zmiennych z przekazanych parametrów
						declare @id_stanowiska as int 
							set @id_stanowiska = 
												 (
												   select id_stanowiska 
													 from pracownicy.stanowiska
													where nazwa_stanowiska = @nazwa_stanowiska
												 )
						declare @id_kodu_pocztowego as smallint
							set @id_kodu_pocztowego = 
														( 
														   select id_kodu_pocztowego 
															from adresy.kody_pocztowe
															where kod_pocztowy = @kod_pocztowy_placówki
														)
						declare @id_ulicy int
							set @id_ulicy =
											(
												select id_ulicy 
												from adresy.ulice 
												where nazwa_ulicy = @nazwa_ulicy_placówki
											)
						declare @id_adresu int
							set @id_adresu = 
												(
												select id_adresu
													from adresy.adresy
												where id_kodu_pocztowego = @id_kodu_pocztowego
													and id_ulicy = @id_ulicy
													and nr_budynku = @nr_budynku_placówki
													and nr_pomieszczenia = @nr_pomieszczenia_placówki
												)
						declare @id_placówki as smallint 
								set @id_placówki =
													(
													select id_placówki 
														from pracownicy.placówki
													where id_adresu = @id_adresu
													)
-- dodanie informacji do tabeli pracownicy.szczegóły_umowy
							insert into pracownicy.szczegóły_umowy(id_umowy,pensja,id_stanowiska,id_placówki,początek,koniec)
							values(@id_umowy,@pensja,@id_stanowiska,@id_placówki,@początek_umowy,@koniec_umowy)
				end
commit
end try
begin catch
begin
		rollback 
		select 'Nie dodano umowy. Popraw dane' as komunikat
		        declare @id as int 
				    set @id = 
							 (
							  select isnull(MAX(id_umowy),0) 
							    from pracownicy.umowy
							 )
				dbcc checkident ('pracownicy.umowy',reseed,@id)
				declare @id2 as int 
				    set @id2 = 
							 (
							  select isnull(MAX(id_szczegółu),0) 
							    from pracownicy.szczegóły_umowy
							 )
				dbcc checkident ('pracownicy.szczegóły_umowy',reseed,@id2)
;throw
end
end catch
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_zatrudnionego]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [pracownicy].[dodaj_zatrudnionego]
(
 @imię              varchar(20),
 @nazwisko          varchar(30),
 @pesel                char(11) = null,
 @miejscowość       varchar(30),
 @ulica             varchar(20) = null,
 @nr_budynku         varchar(5),
 @nr_lokalu          varchar(5) = null,
 @kod_pocztowy       varchar(6),
 @nr_tel_prywatny        int = null,
 @email_prywatny     varchar(30) = null,
 @nr_tel_służbowy        int = null,
 @email_służbowy     varchar(30) = null,
 @nr_konta_bankowego varchar(26) = null,
 @nazwa_banku        varchar(20) = null,
 @uwagi              varchar(50) = null
 )
 as
 begin try
 begin tran
 -----sprawdzenie czy numer pesel istnieje już w bazie
   if exists (
			   select pesel 
				 from pracownicy.zatrudnieni
			    where pesel = @pesel
			  )
	  begin
			select 'Pracownik już w bazie' as komunikat
	  end
----- sprawdzenie poprawności numeru pesel
   else 
	  begin
        declare @cyfra as int 
        declare @liczba_stała as int = 10
        declare @kontrolna as int = right(@pesel,1)
				;with obliczenia as
				(
					select  0  as liczba
						 , 'a' as pesel
				 union all
					select liczba+1
					     , SUBSTRING(@pesel,liczba+1,1) as pesel 
					  from obliczenia
					 where liczba + 1 <=11
				)
					select @cyfra = right(sum(pesel*waga),1) 
					  from obliczenia as o
				inner join wagi       as w
				        on o.liczba = w.id
----- Jeżeli liczba kontrola jest poprawna procedura wykona kolejne zadania
				if 
					@kontrolna - right(@liczba_stała - @cyfra,1) = 0
				  begin
----- Dodanie adres korespondencyjnego do bazy oraz zwrot id
					declare @id_adresu as int
					exec adresy.dodaj_adres
					@nazwa_miejscowości  = @Miejscowość,
					@kod_pocztowy        = @kod_pocztowy,
					@nazwa_ulicy         = @Ulica,
					@Nr_budynku          = @Nr_budynku,
					@nr_pomieszczenia    = @Nr_lokalu,
					@id_adresu = @id_adresu output
----- Dodanie danych do tabeli pracownicy.pracownicy
					insert into pracownicy.pracownicy
					values(@nr_tel_służbowy,@email_służbowy,@nr_konta_bankowego
					      ,@nazwa_banku,@id_adresu,@uwagi)
----- Uzyskanie ostatniego numeru id_pracownika
					declare @id_pracownika as smallint
					set @id_pracownika = (select SCOPE_IDENTITY())
----- Dodanie danych do tabeli pracownicy.zatrudnieni
					insert into pracownicy.zatrudnieni
					values(@id_pracownika,@imię,@nazwisko,@pesel
					      ,@nr_tel_prywatny,@email_prywatny)
				  end 
			  else
----- W przypadku błędnego numeru pesel - procedura wyświetli komunikat
				  begin
					 select 'błędny pesel' as komunikat
				  end
			end
commit
end try
begin catch
begin	    
rollback		
         Select 'Błąd. Pracownik nie został dodany' as komunikat
		 declare @id_pracownika_s as int
           set @id_pracownika_s = 
								   (
						            select isnull(max(id_pracownika),0)
		                              from pracownicy.pracownicy
					               )
dbcc checkident('pracownicy.pracownicy',reseed,@id_pracownika_s)
end
end catch
GO
/****** Object:  StoredProcedure [pracownicy].[pokaż_pracowników]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     proc [pracownicy].[pokaż_pracowników]
(
	@nazwa as varchar(50) = null
)
as
/*
za sprawą procedury zobaczymy dane wszystkich pracowniników. Procedura korzysta z widoku
from view_biuro.pracownicy_nazwa. Dodatkowo uzwględniamy role. Każda z ról będzie widzieć
inne kolumny. 
*/
begin
declare @n as nvarchar(50)
    set @n = @nazwa;
declare @sql as nvarchar(1000)
declare @rola as varchar(13)
    set @rola = 
			    (
							  SELECT DP1.name AS DatabaseRoleName  
								FROM sys.database_role_members AS DRM  
					RIGHT OUTER JOIN sys.database_principals   AS DP1  
								  ON DRM.role_principal_id   = DP1.principal_id  
					 LEFT OUTER JOIN sys.database_principals   AS DP2  
								  ON DRM.member_principal_id = DP2.principal_id  
							   WHERE DP2.name = (select SYSTEM_USER)
				)
if @rola = 'Sprzedawcy'
	begin
		set @sql = 
		'select pracownik
			  , nr_tel_służbowy
			  , email_służbowy
			  , kod_pocztowy
			  , nazwa_miejscowości
			  , nazwa_ulicy
			  , nr_budynku
			  , nr_pomieszczenia
		  from [biuro].[view_pracownicy_nazwa]
		 where pracownik like ''%'' + @nazwa + ''%'' 
			or @nazwa is null;';
	end
else
	begin
		set @sql = 
		'select id_pracownika
			  , nr_umowy
			  , pracownik
			  , nr_tel_służbowy
			  , email_służbowy
			  , kod_pocztowy
			  , nazwa_miejscowości
			  , nazwa_ulicy
			  , nr_budynku
			  , nr_pomieszczenia
			  , pensja
			  , początek
			  , koniec
		  from [biuro].[view_pracownicy_nazwa]
		 where pracownik like ''%'' + @nazwa + ''%'' 
			or @nazwa is null;';
	end
exec sp_executesql
@stmt = @sql,
@params = N'@nazwa as nvarchar(200)',
@nazwa = @n
end
GO
/****** Object:  StoredProcedure [pracownicy].[wykaz_klientów]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     proc [pracownicy].[wykaz_klientów]
(
@nazwa as varchar(50) = null
)
as
declare @n as nvarchar(50)
set @n = @nazwa;

declare @sql as nvarchar(1000)
set @sql = 
'select id_klienta
      , klient
      , nazwa_miejscowości
      , nazwa_ulicy
      , nr_budynku
      , nr_pomieszczenia
      , kod_pocztowy
      , nr_tel
      , email
      , [Regon/Pesel]
      , nip
      , uwagi
  from [dbo].[view_pokaż_klientów]
 where klient like ''%'' + @nazwa + ''%'' 
    or @nazwa is null;'

exec sp_executesql
@stmt = @sql,
@params = N'@nazwa as nvarchar(200)',
@nazwa = @n
GO
/****** Object:  StoredProcedure [sprzedaż].[dodaj_klienta_biznesowego]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE       proc [sprzedaż].[dodaj_klienta_biznesowego]
(
 @nazwa              varchar(20),
 @nip				 int,
 @regon              int,
 @miejscowość       varchar(30),
 @ulica             varchar(20) = null,
 @nr_budynku         varchar(5),
 @nr_lokalu          varchar(5) = null,
 @kod_pocztowy       varchar(6),
 @nr_tel                 int = null,
 @email              varchar(30) = null,
 @uwagi              varchar(50) = null
 )
 as
 begin try
 begin tran
 -----sprawdzenie czy numer nip istnieje już w bazie
   if exists (
			   select nip 
				 from sprzedaż.klienci_biznesowi
			    where nip = @nip
			  )
	  begin
			select 'Klient już w bazie' as komunikat
	  end
   else 
	  begin
----- Dodanie adresu do bazy oraz zwrot id
			    declare @id_adresu as int
				exec adresy.dodaj_adres
				@nazwa_miejscowości  = @Miejscowość,
				@kod_pocztowy        = @kod_pocztowy,
				@nazwa_ulicy         = @Ulica,
				@Nr_budynku          = @Nr_budynku,
				@nr_pomieszczenia    = @Nr_lokalu,
				@id_adresu = @id_adresu output
			insert into sprzedaż.klienci (nr_tel,email,uwagi,id_adresu)
				 values(@nr_tel,@email,@uwagi,@id_adresu)
----- Uzyskanie ostatniego numeru id_klienta przez daną procedurę
				declare @id_klienta as int
					set @id_klienta = (select SCOPE_IDENTITY())
----- Dodanie danych do tabeli sprzedaż.klienci_indywidualni
			insert into sprzedaż.klienci_biznesowi(id_klienta,nazwa,nip,regon)
				 values(@id_klienta,@nazwa,@nip,@regon)	 
		end
commit
end try
begin catch
begin	    
rollback		
         Select 'Błąd. Klient nie został dodany' as komunikat
		 declare @id_klienta_s as int
           set @id_klienta_s = 
								   (
						            select isnull(max(id_klienta),0)
		                              from sprzedaż.klienci
					               )
dbcc checkident('sprzedaż.klienci',reseed,@id_klienta_s)
;throw
end
end catch
GO
/****** Object:  StoredProcedure [sprzedaż].[dodaj_klienta_indywidualnego]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE     proc [sprzedaż].[dodaj_klienta_indywidualnego]
(
 @imię              varchar(20),
 @nazwisko          varchar(30),
 @pesel                char(11) = null,
 @miejscowość       varchar(30),
 @ulica             varchar(20) = null,
 @nr_budynku         varchar(5),
 @nr_lokalu          varchar(5) = null,
 @kod_pocztowy       varchar(6),
 @nr_tel_prywatny        int = null,
 @email_prywatny     varchar(30) = null,
 @uwagi              varchar(50) = null
 )
 as
 begin try
 begin tran
 -----sprawdzenie czy numer pesel istnieje już w bazie
   if exists (
			   select pesel 
				 from sprzedaż.klienci_indywidualni
			    where pesel = @pesel
			  )
	  begin
			select 'Klient już w bazie' as komunikat
	  end
----- sprawdzenie poprawności numeru pesel
   else 
	  begin
        declare @cyfra as int 
        declare @liczba_stała as int = 10
        declare @kontrolna as int = right(@pesel,1)
				;with obliczenia as
				(
					select  0  as liczba
						 , 'a' as pesel
				 union all
					select liczba+1
					     , SUBSTRING(@pesel,liczba+1,1) as pesel 
					  from obliczenia
					 where liczba + 1 <=11
				)
					select @cyfra = right(sum(pesel*waga),1) 
					  from obliczenia as o
				inner join wagi       as w
				        on o.liczba = w.id
----- Jeżeli liczba kontrola jest poprawna procedura wykona kolejne zadania
				if 
					@kontrolna - right(@liczba_stała - @cyfra,1) = 0
				  begin
----- Dodanie adres korespondencyjnego do bazy oraz zwrot id
						declare @id_adresu as int
						exec adresy.dodaj_adres
						@nazwa_miejscowości  = @Miejscowość,
						@kod_pocztowy        = @kod_pocztowy,
						@nazwa_ulicy         = @Ulica,
						@Nr_budynku          = @Nr_budynku,
						@nr_pomieszczenia    = @Nr_lokalu,
						@id_adresu = @id_adresu output
					insert into sprzedaż.klienci (nr_tel,email,id_adresu,uwagi)
						 values(@nr_tel_prywatny,@email_prywatny,@id_adresu,@uwagi)
----- Uzyskanie ostatniego numeru id_klienta przez daną procedurę
					declare @id_klienta as int
					    set @id_klienta = (select SCOPE_IDENTITY())
----- Dodanie danych do tabeli sprzedaż.klienci_indywidualni
					insert into sprzedaż.klienci_indywidualni(id_klienta,imię,nazwisko,pesel)
					values(@id_klienta,@imię,@nazwisko,@pesel)
				  end 
			  else
----- W przypadku błędnego numeru pesel - procedura wyświetli komunikat
				  begin
					 select 'błędny pesel' as komunikat
				  end
			end
commit
end try
begin catch
begin	    
rollback		
         Select 'Błąd. Pracownik nie został dodany' as komunikat
		 declare @id_klienta_s as int
           set @id_klienta_s = 
								   (
						            select isnull(max(id_klienta),1)
		                              from sprzedaż.klienci
					               )
dbcc checkident('sprzedaż.klienci',reseed,@id_klienta_s)
;throw
end
end catch
GO
/****** Object:  StoredProcedure [sprzedaż].[kasuj_polisę]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [sprzedaż].[kasuj_polisę]
(
@nr_polisy varchar(20)
)
as
/*
za sprawą procecury tylko uprawniony pracownik może dokonać skasowania polisy. 
*/
delete from [sprzedaż].[polisy]
where nr_polisy = @nr_polisy
select 'Polisa skasowana' as komunikat 
GO
/****** Object:  StoredProcedure [sprzedaż].[pokaż_płatności]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Poprzez procedurę sprawdzamy płatności dla wskazanej polisy 
Procedura wykona obliczenia uwzględniając ilość rat. Ewentualne rozbieżności 
wynikajace z zaokrągleń zostaną dodane do pierwszej raty za polisę. Za sprawą procedury 
nie jest już konieczne przychowywanie danych na dysku ani użycie funkcji tabelarycznej. 
*/
CREATE   proc [sprzedaż].[pokaż_płatności]
( 
@nr_polisy as varchar(20)
)
as
		  /* 
			 W zmiennej przechowamy informacje ile miesięcy będzie trwać ubezpieczenie.
		     Zmienna znajdze najlepszy użytek w przypadku polis dłuzszych niż rok. 
		  */
			 declare @ilość_miesięcy as int 
		  /* Zmienna przechwytuje wartość związaną z liczbą rat, która będzi wykorzystana później.*/
			 declare @raty as int
		  /* W zmiennej przechowamy całościową opłatę za polisę. Tzw. składkę.*/ 
			 declare @składka as decimal(6,2) 
		  /*
			 W zmiennej przechowam informację o pierwszym terminie płatności. 
 			 Od tego terminu będziemy wyliczaś termny kolejnych rat
		  */
		     declare @termin_pierwszej_raty as date

		  /* uzyskanie informacji i wykorzystanie zmiennych w kolejnej części procedury */
			 select @ilość_miesięcy = (datediff(MONTH,początek_ubezpieczenia,koniec_ubezpieczenia)+1)
				  , @raty = raty
				  , @składka = składka
				  , @termin_pierwszej_raty = termin_pierwszej_raty
			   from sprzedaż.polisy
			  where nr_polisy = @nr_polisy
/*
	Utorzenie zmiennej która pozwoli obliczyć kolejny dzień raty
*/
declare @terminy as int = 
						  (
						    @ilość_miesięcy/@raty
						  )
/*
	Obliczenie pierwszej raty składki.
*/
declare @rata as decimal(6,2) = 
							    (
								  @składka/@raty
								)
/*
	Liwkidacja problemu zaookrągleń i tzw brakującego grosza. Różnica doliczana do pierwszej raty. 
*/
declare @pierwsza_rata as decimal(6,2) = 
										 (
											@rata + (@składka - (@rata*@raty))
										 )
/*
  Wykorzystanie powyższych zmienny i obliczenie za pośrednictwem rekurnecyjnego CTE terminów kolejnych rat
*/
					;with obliczenia as
					(
					select 1 as nr_raty
						 , @pierwsza_rata as rata
						 , @termin_pierwszej_raty as data_raty
				union all
					select nr_raty + 1, @rata as rata
						 , DATEADD(month,@terminy ,data_raty) as data_raty 
					  from obliczenia 
					 where nr_raty + 1 <= @raty 
					) 
					select nr_raty,rata as kwota,data_raty 
					  from obliczenia 	
		
GO
/****** Object:  StoredProcedure [sprzedaż].[pokaż_polisy]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [sprzedaż].[pokaż_polisy]
(
@id_klienta as int 
)
/*
Poprzez procedurę jesteś sprawdzić jakie polisy posiada wybrany przez nas klient 
*/
as
		select distinct id_klienta
			  , su.nr_polisy 
			  , sp.nazwa_produktu
			  , tu.nazwa_tu
			  , su.początek_ubezpieczenia
			  , su.koniec_ubezpieczenia
			  , pn.pracownik
			  , su.składka
			  , su.raty
		  from sprzedaż.polisy as su
	inner join [biuro].[view_pracownicy_nazwa] as pn
		    on su.id_pracownika = pn.id_pracownika
	inner join sprzedaż.produkty as sp
	        on sp.id_produktu = su.id_produktu
	inner join sprzedaż.towarzystwa_ubezpieczeniowe as tu
	        on tu.id_tu = sp.id_tu
		 where id_klienta = @id_klienta 
GO
/****** Object:  StoredProcedure [sprzedaż].[raport_sprzedażowy]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [sprzedaż].[raport_sprzedażowy]
(
@data_początkowa as date,
@data_końcowa as date
)
as 
declare @id_pracownika as smallint 
set @id_pracownika = 
					(
					  select id_pracownika 
					    from biuro.view_pracownicy_nazwa
					   where pracownik in   
										   (
											 select replace(SYSTEM_USER,'_',' ')
											)
					)
select sso.nr_polisy
			 , vpk.klient
			 , sp.nazwa_produktu
			 , sso.data_wpisania_polisy
			 , sso.składka 
			 , sso.początek_ubezpieczenia
			 , sso.koniec_ubezpieczenia
		from sprzedaż.polisy as sso
  inner join [dbo].[view_pokaż_klientów]   as vpk
		  on sso.id_klienta = vpk.id_klienta
  inner join sprzedaż.produkty             as sp
		  on sp.id_produktu = sso.id_produktu
	   where id_pracownika = @id_pracownika
	     and sso.data_wpisania_polisy between @data_początkowa and @data_końcowa
GO
/****** Object:  StoredProcedure [sprzedaż].[wpisz_dokument]    Script Date: 26.08.2022 11:43:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [sprzedaż].[wpisz_dokument]
(
	@nr_polisy varchar(20),
	@id_klienta int,
	@nazwa_produktu varchar(50),
	@data_wystawienia_polisy date = null,
	@data_wpisania_polisy date = null,
	@początek_ubezpieczenia date,
	@koniec_ubezpieczenia date = null,
	@nazwa_statusu varchar(10),
	@składka decimal (7,2),
	@raty smallint,
	@forma_płatności varchar(10),
	@termin_pierwszej_raty date
)
---- poprzez procedurę pracownik dodaje informacje o sprzedanej polisie do bazy danych
as
begin try
begin tran
----- sprawdzenie czy wymagane dane zostały dodane jeżeli nie procedura nie zostanie wykonana
if   (
		@nr_polisy              is null or
		@id_klienta             is null or 
		@nazwa_produktu         is null or 
		@początek_ubezpieczenia is null or 
		@nazwa_statusu          is null or 
		@raty                   is null
	 )
	 begin 
			select 'Brak wymaganych danych' as komunikat
	 end
else
-- sprawdzenie czy taka polisa nie istnieje w bazie gdyż każdy numer powinien być numerem unikalnym
	 if exists 
		        (
	             select nr_polisy 
				   from sprzedaż.polisy
				  where nr_polisy = @nr_polisy
				)
					begin
						 select 'taka polisa już jest w bazie. Sprawdź numer' as komunikat
					end
	else
			 if @koniec_ubezpieczenia < @początek_ubezpieczenia
				 begin
				   select 'Sprawdź daty. Polisa nie została wpisana'
				 end
    --else
			 --if @data_wpisania_polisy < CAST(getdate() as date)
				--begin 
				--		Select 'Nie może wpisać polisy ze wcześniejszą datą' as komunikat
				--end
	else
		begin
	-- deklaracja zmiennych oraz zmiennej tabelarycznej w tym nazwy użytkownika
			declare @rozłożenie_raty as sprzedaż.raty
			set @data_wystawienia_polisy = ISNULL(@data_wystawienia_polisy, getdate())
			set @data_wpisania_polisy    = ISNULL(@data_wpisania_polisy,GETDATE())
			set @koniec_ubezpieczenia    = ISNULL(@koniec_ubezpieczenia,dateadd(day,364,@początek_ubezpieczenia))
			declare @id_pracownika as smallint 
			set @id_pracownika = 
								(
									select id_pracownika 
									  from biuro.view_pracownicy_nazwa
									 where pracownik in  (
														   select replace(SYSTEM_USER,'_',' ')
														 )
								)
	-----
			declare @id_produktu as smallint 
				set @id_produktu = 
									(
										select id_produktu 
										  from sprzedaż.produkty
										 where nazwa_produktu = @nazwa_produktu
									)
			declare @id_statusu as smallint
				set @id_statusu = 
									(
										select id_statusu 
										  from sprzedaż.status
										 where nazwa_statusu = @nazwa_statusu 
									)
	---- dodanie wartości polisy do tabeli sprzedaż.sprzedaż_ubezpieczeń
			insert into sprzedaż.polisy
			values (@nr_polisy,@id_klienta,@id_pracownika,@id_produktu
					,@data_wystawienia_polisy,@data_wpisania_polisy,@początek_ubezpieczenia
					,@koniec_ubezpieczenia,@id_statusu,@składka,@raty,@termin_pierwszej_raty)
	------ Wyświetlenie komunikatu
			select 'operacja przebiegła prawidłowo' as komunikat
			end
commit
end try
begin catch
begin
	rollback
	select 'polisa nie została wpisana' as komunikat 
	declare @id_polisy_s as int
	set @id_polisy_s = (
					   select isnull(MAX(id_polisy),0)
						 from sprzedaż.polisy
					 )
					 dbcc checkident ('sprzedaż.polisy',reseed,@id_polisy_s)
;throw
end
end catch
GO
USE [master]
GO
ALTER DATABASE [multiagencja_ubezpieczeniowa] SET  READ_WRITE 
GO
