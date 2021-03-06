USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_partnera]    Script Date: 25.07.2022 21:21:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [pracownicy].[dodaj_partnera]
(
 @nazwa              varchar(30),
 @nip                int,
 @regon              int,
 @miejscowość        varchar(30),
 @ulica              varchar(20) = null,
 @nr_budynku         varchar(5),
 @nr_lokalu          varchar(5) = null,
 @kod_pocztowy       varchar(6),
 @nr_tel_prywatny        int = null,
 @email_prywatny     varchar(30) = null,
 @nr_tel_służbowy        int = null,
 @email_służbowy     varchar(30) = null,
 @nr_konta_bankowego varchar(26) = null,
 @nazwa_banku        varchar(20) = null,
 @uwagi              varchar(50) = null
)
as
begin try
begin tran
 ----- Sprawdzenie czy numer nip istnieje już w bazie
   if exists (
			   select nip 
				 from pracownicy.partnerzy
			    where nip = @nip
			  )
	  begin
			select 'Partner już w bazie' as komunikat
	  end
   else
	   begin
----- Dodanie adres korespondencyjnego do bazy oraz zwrot id
			declare @id_adresu as int
				exec adresy.dodaj_adres
				@nazwa_miejscowości  = @Miejscowość,
				@kod_pocztowy        = @kod_pocztowy,
				@nazwa_ulicy         = @Ulica,
				@Nr_budynku          = @Nr_budynku,
				@nr_pomieszczenia    = @Nr_lokalu,
				@id_adresu = @id_adresu output
----- Dodanie danych do tabeli pracownicy.pracownicy
			insert into pracownicy.pracownicy
			values(@nr_tel_służbowy,@email_służbowy,@nr_konta_bankowego
					,@nazwa_banku,@id_adresu,@uwagi)
----- Uzyskanie ostatniego numeru id_pracownika
			declare @id_pracownika as smallint
			set @id_pracownika = (select SCOPE_IDENTITY())
----- Dodanie danych do tabeli pracownicy.partnerzy
			insert into pracownicy.partnerzy
			values(@id_pracownika,@nazwa,@nip,@regon)
	end
commit
end try
begin catch
begin	    
rollback		
         Select 'Błąd. Partner nie został dodany' as komunikat
		 declare @id_pracownika_s as int
           set @id_pracownika_s = 
								   (
						            select isnull(max(id_pracownika),0)
		                              from pracownicy.pracownicy
					               )
dbcc checkident('pracownicy.pracownicy',reseed,@id_pracownika_s)
;throw
end
end catch