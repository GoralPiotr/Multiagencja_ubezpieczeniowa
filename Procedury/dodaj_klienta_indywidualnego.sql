USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_zatrudnionego]    Script Date: 14.07.2022 21:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create or ALTER   proc [sprzedaż].[dodaj_klienta_indywidualnego]
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
 @uwagi              varchar(50) = null
 )
 as
 begin try
 begin tran
 -----sprawdzenie czy numer pesel istnieje już w bazie
   if exists (
			   select pesel 
				 from sprzedaż.kilenci_indywidualni
			    where pesel = @pesel
			  )
	  begin
			select 'Klient już w bazie' as komunikat
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
					insert into sprzedaż.klienci (nr_tel,email,miejscowość,ulica,nr_budynku,nr_lokalu,kod_pocztowy,uwagi)
						 values(@nr_tel_prywatny,@email_prywatny,@miejscowość,@ulica,@nr_budynku,@nr_lokalu,@kod_pocztowy,@uwagi)
----- Uzyskanie ostatniego numeru id_klienta przez daną procedurę
					declare @id_klienta as int
					    set @id_klienta = (select SCOPE_IDENTITY())
----- Dodanie danych do tabeli sprzedaż.klienci_indywidualni
					insert into sprzedaż.klienci_indywidualni(id_klienta,imię,nazwisko,pesel)
					values(@id_klienta,@imię,@nazwisko,@pesel)
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
		 declare @id_klienta_s as int
           set @id_klienta_s = 
								   (
						            select isnull(max(id_klienta),0)
		                              from sprzedaż.klienci
					               )
dbcc checkident('sprzedaż.klienci',reseed,@id_klienta_s)
end
end catch