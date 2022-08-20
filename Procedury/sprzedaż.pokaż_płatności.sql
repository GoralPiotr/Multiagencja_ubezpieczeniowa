USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[pokaż_płatności]    Script Date: 10.08.2022 17:13:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [sprzedaż].[pokaż_płatności]
(
@nr_polisy as varchar(20)
)
as
/*
Poprzez procedurę sprawdzamy płatności dla wskazanej polisy 
*/
			select sp.id_polisy
				 , sp.lp_raty
				 , sp.forma_płatności
				 , sp.termin_płatności
			 from sprzedaż.płatności			 as sp
	   inner join sprzedaż.sprzedaż_ubezpieczeń  as ssu
			   on ssu.id_polisy = sp.id_polisy
			where ssu.nr_polisy = @nr_polisy