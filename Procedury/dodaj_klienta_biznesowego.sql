USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[dodaj_klienta_indywidualnego]    Script Date: 14.07.2022 22:49:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create or alter     proc [sprzedaż].[dodaj_klienta_biznesowego]
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
 -----sprawdzenie czy numer pesel istnieje już w bazie
   if exists (
			   select nip 
				 from sprzedaż.kilenci_biznesowi
			    where nip = @nip
			  )
	  begin
			select 'Klient już w bazie' as komunikat
	  end
   else 
	  begin
----- Dodanie adresu do bazy oraz zwrot id
			insert into sprzedaż.klienci (nr_tel,email,miejscowość,ulica,nr_budynku,nr_lokalu,kod_pocztowy,uwagi)
				 values(@nr_tel,@email,@miejscowość,@ulica,@nr_budynku,@nr_lokalu,@kod_pocztowy,@uwagi)
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
         Select 'Błąd. Pracownik nie został dodany' as komunikat
		 declare @id_klienta_s as int
           set @id_klienta_s = 
								   (
						            select isnull(max(id_klienta),0)
		                              from sprzedaż.klienci
					               )
dbcc checkident('sprzedaż.klienci',reseed,@id_klienta_s)
end
end catch