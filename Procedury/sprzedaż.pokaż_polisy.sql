USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[pokaż_polisy]    Script Date: 26.08.2022 10:37:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [sprzedaż].[pokaż_polisy]
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
