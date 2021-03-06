USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[pokaz_pracowników]    Script Date: 25.07.2022 23:03:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [pracownicy].[pokaz_pracowników]
(
	@nazwa as varchar(50) = null
)
as
/*
za sprawą procedury zobaczymy dane wszystkich pracowniników. Procedura korzysta z widoku
from biuro.pracownicy_nazwa
*/
declare @n as nvarchar(50)
set @n = @nazwa;

declare @sql as nvarchar(1000)
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
  from biuro.pracownicy_nazwa
 where pracownik like ''%'' + @nazwa + ''%'' 
    or @nazwa is null;';

exec sp_executesql
@stmt = @sql,
@params = N'@nazwa as nvarchar(200)',
@nazwa = @n