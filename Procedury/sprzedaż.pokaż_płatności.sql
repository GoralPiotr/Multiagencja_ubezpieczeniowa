USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[pokaż_płatności]    Script Date: 25.07.2022 23:13:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [sprzedaż].[pokaż_płatności]
(
@id_polisy as int
)
as
/*
Poprzez procedurę sprawdzamy płatności dla wskazanej polisy 
*/
select id_polisy
     , lp_raty
     , forma_płatności
     , termin_płatności
from sprzedaż.płatności
where id_polisy = @id_polisy