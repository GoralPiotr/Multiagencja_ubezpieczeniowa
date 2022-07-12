create or alter proc pracownicy.dodaj_zatrudnionego
(
 @imiê              varchar(20),
 @nazwisko          varchar(30),
 @pesel                char(11) = null,
 @miejscowoœæ       varchar(30),
 @ulica             varchar(20) = null,
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
 -----sprawdzenie czy numer pesel istnieje ju¿ w bazie
   if exists (
			   select pesel 
				 from pracownicy.zatrudnieni
			    where pesel = @pesel
			  )
	  begin
			select 'Pracownik ju¿ w bazie' as komunikat
	  end
----- sprawdzenie poprawnoœci numeru pesel
   else 
	  begin
        declare @cyfra as int 
        declare @liczba_sta³a as int = 10
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
----- Je¿eli liczba kontrola jest poprawna procedura wykona kolejne zadania
				if 
					@kontrolna - right(@liczba_sta³a - @cyfra,1) = 0
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
----- Dodanie danych do tabeli pracownicy.zatrudnieni
					insert into pracownicy.zatrudnieni
					values(@id_pracownika,@imiê,@nazwisko,@pesel
					      ,@nr_tel_prywatny,@email_prywatny)
				  end 
			  else
----- W przypadku b³êdnego numeru pesel - procedura wyœwietli komunikat
				  begin
					 select 'b³êdny pesel' as komunikat
				  end
			end
commit
end try
begin catch
begin	    
rollback		
         Select 'B³¹d. Pracownik nie zosta³ dodany' as komunikat
		 declare @id_pracownika_s as int
           set @id_pracownika_s = 
								   (
						            select isnull(max(id_pracownika),0)
		                              from pracownicy.pracownicy
					               )
dbcc checkident('pracownicy.pracownicy',reseed,@id_pracownika_s)
end
end catch