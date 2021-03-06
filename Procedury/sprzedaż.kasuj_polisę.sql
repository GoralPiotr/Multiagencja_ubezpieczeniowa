USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[kasuj_polisę]    Script Date: 25.07.2022 23:11:30 ******/
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
zastosowane cascadowe usunięcie klucza 
*/
delete from [sprzedaż].[sprzedaż_ubezpieczeń]
where nr_polisy = @nr_polisy
select 'Polisa skasowana' as komunikat 