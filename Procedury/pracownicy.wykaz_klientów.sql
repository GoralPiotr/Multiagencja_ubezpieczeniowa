USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[wykaz_klientów]    Script Date: 18.08.2022 21:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER     proc [pracownicy].[wykaz_klientów]
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