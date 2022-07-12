create or alter proc pracownicy.dodaj_partnera
(
 @nazwa              varchar(30),
 @nip                int,
 @regon              int,
 @miejscowoœæ        varchar(30),
 @ulica              varchar(20) = null,
 @nr_budynku         varchar(5),
 @nr_lokalu          varchar(5) = null,
 @kod_pocztowy       varchar(6),
 @nr_tel_prywatny        int = null,
 @email_prywatny     varchar(30) = null,
 @nr_tel_s³u¿bowy        int = null,
 @email_s³u¿bowy     varchar(30) = null,
 @nr_konta_bankowego varchar(26) = null,
 @nazwa_banku        varchar(20) = null,
 @uwagi              varchar(50) = null
)
as
begin try
begin tran
 ----- Sprawdzenie czy numer pesel istnieje ju¿ w bazie
   if exists (
			   select nip 
				 from pracownicy.partnerzy
			    where nip = @nip
			  )
	  begin
			select 'Partner ju¿ w bazie' as komunikat
	  end
   else
	   begin
----- Dodanie adres korespondencyjnego do bazy oraz zwrot id
			declare @id_adresu_korespondencyjnego as int
				exec pracownicy.dodaj_adres_korespondencyjny
				@Miejscowoœæ  = @Miejscowoœæ,
				@Ulica        = @Ulica,
				@Nr_budynku   = @Nr_budynku,
				@Nr_lokalu    = @Nr_lokalu,
				@kod_pocztowy = @kod_pocztowy,
				@id_adresu_korespondencyjnego = @id_adresu_korespondencyjnego output
----- Dodanie danych do tabeli pracownicy.pracownicy
			insert into pracownicy.pracownicy
			values(@nr_tel_s³u¿bowy,@email_s³u¿bowy,@nr_konta_bankowego
					,@nazwa_banku,@id_adresu_korespondencyjnego,@uwagi)
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
         Select 'B³¹d. Partner nie zosta³ dodany' as komunikat
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