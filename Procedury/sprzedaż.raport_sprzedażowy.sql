USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[raport_sprzedażowy]    Script Date: 26.08.2022 11:57:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [sprzedaż].[raport_sprzedażowy]
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