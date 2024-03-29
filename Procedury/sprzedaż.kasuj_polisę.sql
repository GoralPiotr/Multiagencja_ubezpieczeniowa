USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[kasuj_polisę]    Script Date: 26.08.2022 10:27:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [sprzedaż].[kasuj_polisę]
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