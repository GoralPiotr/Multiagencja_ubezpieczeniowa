USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_adres_korespondencyjny]    Script Date: 12.07.2022 08:40:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create or ALTER proc [pracownicy].[dodaj_placówkę]
(
@Miejscowość		      varchar(30),
@Ulica					  varchar(20) = null,
@Nr_budynku				  varchar(5),
@Nr_lokalu				  varchar(5) = null,
@kod_pocztowy			  varchar(6),
@powierzchnia             decimal(5,2)
)
as
begin try
begin tran
---sprawdzenie czy podany adres placówki nie istnieje w bazie. Jeśli nie zostanie dodany
if not exists (
				select id_placówki
				  from pracownicy.placówki
				 where  Miejscowość = @Miejscowość
				   and       (Ulica = @Ulica or @Ulica is null)
				   and   Nr_budynku = @Nr_budynku
				   and   (Nr_lokalu = @Nr_lokalu or @Nr_lokalu is null)
				   and kod_pocztowy = @kod_pocztowy
			  )
	begin 
			insert into pracownicy.placówki
				 values(@Miejscowość,@Ulica,@Nr_budynku,@Nr_lokalu,@kod_pocztowy,@powierzchnia)
		
	end
else
	begin
			select 'adres już w bazie' as komunikat
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