USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_zatrudnionego]    Script Date: 25.07.2022 23:00:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
ALTER   proc [pracownicy].[dodaj_zatrudnionego]
(
 @imię              varchar(20),
 @nazwisko          varchar(30),
 @pesel                char(11) = null,
 @miejscowość       varchar(30),
 @ulica             varchar(20) = null,
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
 -----sprawdzenie czy numer pesel istnieje już w bazie
   if exists (
			   select pesel 
				 from pracownicy.zatrudnieni
			    where pesel = @pesel
			  )
	  begin
			select 'Pracownik już w bazie' as komunikat
	  end
----- sprawdzenie poprawności numeru pesel
   else 
	  begin
        declare @cyfra as int 
        declare @liczba_stała as int = 10
        declare @kontrolna as int = right(@pesel,1)
				;with obliczenia as
				(
					select  0  as liczba
						 , 'a' as pesel
				 union all
					select liczba+1
					     , SUBSTRING(@pesel,liczba+1,1) as pesel 
					  from obliczenia
					 where liczba + 1 <=11
				)
					select @cyfra = right(sum(pesel*waga),1) 
					  from obliczenia as o
				inner join wagi       as w
				        on o.liczba = w.id
----- Jeżeli liczba kontrola jest poprawna procedura wykona kolejne zadania
				if 
					@kontrolna - right(@liczba_stała - @cyfra,1) = 0
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
----- Dodanie danych do tabeli pracownicy.zatrudnieni
					insert into pracownicy.zatrudnieni
					values(@id_pracownika,@imię,@nazwisko,@pesel
					      ,@nr_tel_prywatny,@email_prywatny)
				  end 
			  else
----- W przypadku błędnego numeru pesel - procedura wyświetli komunikat
				  begin
					 select 'błędny pesel' as komunikat
				  end
			end
commit
end try
begin catch
begin	    
rollback		
         Select 'Błąd. Pracownik nie został dodany' as komunikat
		 declare @id_pracownika_s as int
           set @id_pracownika_s = 
								   (
						            select isnull(max(id_pracownika),0)
		                              from pracownicy.pracownicy
					               )
dbcc checkident('pracownicy.pracownicy',reseed,@id_pracownika_s)
end
end catch