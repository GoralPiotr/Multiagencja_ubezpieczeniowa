USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[wpisz_dokument]    Script Date: 26.08.2022 10:39:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [sprzedaż].[wpisz_dokument]
(
	@nr_polisy varchar(20),
	@id_klienta int,
	@nazwa_produktu varchar(50),
	@data_wystawienia_polisy date = null,
	@data_wpisania_polisy date = null,
	@początek_ubezpieczenia date,
	@koniec_ubezpieczenia date = null,
	@nazwa_statusu varchar(10),
	@składka decimal (7,2),
	@raty smallint,
	@forma_płatności varchar(10),
	@termin_pierwszej_raty date
)
---- poprzez procedurę pracownik dodaje informacje o sprzedanej polisie do bazy danych
as
begin try
begin tran
----- sprawdzenie czy wymagane dane zostały dodane jeżeli nie procedura nie zostanie wykonana
if   (
		@nr_polisy              is null or
		@id_klienta             is null or 
		@nazwa_produktu         is null or 
		@początek_ubezpieczenia is null or 
		@nazwa_statusu          is null or 
		@raty                   is null
	 )
	 begin 
			select 'Brak wymaganych danych' as komunikat
	 end
else
-- sprawdzenie czy taka polisa nie istnieje w bazie gdyż każdy numer powinien być numerem unikalnym
	 if exists 
		        (
	             select nr_polisy 
				   from sprzedaż.polisy
				  where nr_polisy = @nr_polisy
				)
					begin
						 select 'taka polisa już jest w bazie. Sprawdź numer' as komunikat
					end
	else
			 if @koniec_ubezpieczenia < @początek_ubezpieczenia
				 begin
				   select 'Sprawdź daty. Polisa nie została wpisana'
				 end
    --else
			 --if @data_wpisania_polisy < CAST(getdate() as date)
				--begin 
				--		Select 'Nie może wpisać polisy ze wcześniejszą datą' as komunikat
				--end
	else
		begin
	-- deklaracja zmiennych oraz zmiennej tabelarycznej w tym nazwy użytkownika
			declare @rozłożenie_raty as sprzedaż.raty
			set @data_wystawienia_polisy = ISNULL(@data_wystawienia_polisy, getdate())
			set @data_wpisania_polisy    = ISNULL(@data_wpisania_polisy,GETDATE())
			set @koniec_ubezpieczenia    = ISNULL(@koniec_ubezpieczenia,dateadd(day,364,@początek_ubezpieczenia))
			declare @id_pracownika as smallint 
			set @id_pracownika = 
								(
									select id_pracownika 
									  from biuro.view_pracownicy_nazwa
									 where pracownik in  (
														   select replace(SYSTEM_USER,'_',' ')
														 )
								)
	-----
			declare @id_produktu as smallint 
				set @id_produktu = 
									(
										select id_produktu 
										  from sprzedaż.produkty
										 where nazwa_produktu = @nazwa_produktu
									)
			declare @id_statusu as smallint
				set @id_statusu = 
									(
										select id_statusu 
										  from sprzedaż.status
										 where nazwa_statusu = @nazwa_statusu 
									)
	---- dodanie wartości polisy do tabeli sprzedaż.sprzedaż_ubezpieczeń
			insert into sprzedaż.polisy
			values (@nr_polisy,@id_klienta,@id_pracownika,@id_produktu
					,@data_wystawienia_polisy,@data_wpisania_polisy,@początek_ubezpieczenia
					,@koniec_ubezpieczenia,@id_statusu,@składka,@raty,@termin_pierwszej_raty)
	------ Wyświetlenie komunikatu
			select 'operacja przebiegła prawidłowo' as komunikat
			end
commit
end try
begin catch
begin
	rollback
	select 'polisa nie została wpisana' as komunikat 
	declare @id_polisy_s as int
	set @id_polisy_s = (
					   select isnull(MAX(id_polisy),0)
						 from sprzedaż.polisy
					 )
					 dbcc checkident ('sprzedaż.polisy',reseed,@id_polisy_s)
;throw
end
end catch