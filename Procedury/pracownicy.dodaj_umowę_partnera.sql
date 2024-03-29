USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_umowę_partnera]    Script Date: 20.08.2022 21:49:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER     proc [pracownicy].[dodaj_umowę_partnera]
(
	@nr_umowy varchar(10),
	@nip as int,
	@nazwa_umowy as varchar(20),
	@początek_umowy as date,
	@koniec_umowy as date = null,
	@pensja as decimal(7,2),
	@nazwa_stanowiska as varchar(50),
	@nazwa_miejscowości_placówki varchar(50) = null,
	@kod_pocztowy_placówki char(6) = null,
	@nazwa_ulicy_placówki varchar(60) = null,
	@nr_budynku_placówki varchar(4) = null,
	@nr_pomieszczenia_placówki varchar(4) = null
)
as
/*
Sprawdzenie czy dany numer umowy znajduje się już w bazie. Jeśli tak pozostałe dzialania
zostaną wstrzymane 
*/
begin try 
begin tran
		if exists 
				 (
					select nr_umowy 
					  from pracownicy.umowy
					 where nr_umowy = @nr_umowy
				 )
		  begin
					select 'taka umowa już istnieje - poraw błąd' as komunikat
		  end 
	 else
-- gdy danego numeru nie ma w bazie procedura pobierze id partnera
			  begin
					declare @id_pracownika_partner as smallint
						set @id_pracownika_partner = 
													 ( 
														select id_pracownika 
														  from pracownicy.partnerzy
														 where nip = @nip
													 )
-- pobranie numeru id rodzaju umowy
					declare @id_rodz_umowy as smallint 
					    set @id_rodz_umowy = 
											    (
												  select id_rodz_umowy 
												    from pracownicy.rodzaje_umów
												   where nazwa_umowy = @nazwa_umowy
												)
-- dane zostaną dodane do tabeli pracownicy.umowy
					insert into pracownicy.umowy
					values(@nr_umowy,@id_pracownika_partner,@id_rodz_umowy)
----uzyskanie id_numer_umowy i przekazanie wartości dalej
					declare @id_umowy as int
					    set @id_umowy = (select SCOPE_IDENTITY())
----uzyskanie wartości zmiennych z przekazanych parametrów
					declare @id_stanowiska as int 
						set @id_stanowiska = 
											 (
											   select id_stanowiska 
											     from pracownicy.stanowiska
												where nazwa_stanowiska = @nazwa_stanowiska
										     )
-- w przypadku gdy @nazwa miejscowości to null jest to informacja że partner nie będzie pracował w placówce
					if @nazwa_miejscowości_placówki is null
						begin 
							insert into pracownicy.szczegóły_umowy(id_umowy,pensja,id_stanowiska,początek,koniec)
							values(@id_umowy,@pensja,@id_stanowiska,@początek_umowy,@koniec_umowy)
						end
					else
					    begin
								declare @id_kodu_pocztowego as smallint
									set @id_kodu_pocztowego = 
															 ( 
																select id_kodu_pocztowego 
																  from adresy.kody_pocztowe
																 where kod_pocztowy = @kod_pocztowy_placówki
															 )
								declare @id_ulicy int
									set @id_ulicy =
												   (
												     select id_ulicy 
													   from adresy.ulice 
												      where nazwa_ulicy = @nazwa_ulicy_placówki
												   )
								declare @id_adresu int
									set @id_adresu = 
													  (
													   select id_adresu
														 from adresy.adresy
														where id_kodu_pocztowego = @id_kodu_pocztowego
														  and id_ulicy = @id_ulicy
														  and nr_budynku = @nr_budynku_placówki
														  and nr_pomieszczenia = @nr_pomieszczenia_placówki
													  )
								declare @id_placówki as smallint 
										set @id_placówki =
														  (
														    select id_placówki 
															 from pracownicy.placówki
															where id_adresu = @id_adresu
														  )
-- dodanie informacji do tabeli pracownicy.szczegóły_umowy
							insert into pracownicy.szczegóły_umowy(id_umowy,pensja,id_stanowiska,id_placówki,początek,koniec)
							values(@id_umowy,@pensja,@id_stanowiska,@id_placówki,@początek_umowy,@koniec_umowy)
						end
				end
commit
end try
begin catch
begin
		rollback 
		select 'Nie dodano umowy. Popraw dane' as komunikat
		        declare @id as int 
				    set @id = 
							 (
							  select isnull(MAX(id_umowy),0) 
							    from pracownicy.umowy
							 )
				dbcc checkident ('pracownicy.umowy',reseed,@id)
				declare @id2 as int 
				    set @id2 = 
							 (
							  select isnull(MAX(id_szczegółu),0) 
							    from pracownicy.szczegóły_umowy
							 )
				dbcc checkident ('pracownicy.szczegóły_umowy',reseed,@id2)
;throw
end
end catch
