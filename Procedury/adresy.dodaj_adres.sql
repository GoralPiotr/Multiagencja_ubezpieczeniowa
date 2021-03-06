USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [adresy].[dodaj_adres]    Script Date: 25.07.2022 19:29:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [adresy].[dodaj_adres]
(
	@nazwa_miejscowości varchar(50),
	@kod_pocztowy char(6),
	@nazwa_ulicy varchar(60) = bez_ulicy,
	@nr_budynku varchar(4),
	@nr_pomieszczenia varchar(4) = null,
    @id_adresu as int = null output
)
as
begin try
begin tran
-- deklaracja zmiennych, które zostaną wykorzystane w poniższych fragmentach
declare @id_miejscowości as int
declare @id_kodu_pocztowego_sc_i as smallint
declare @id_kodu_pocztowego as smallint
declare @id_ulicy_sc_i as int
-- odnalezienie id_kodu pocztowego z argumentu który został przekazany przez użytkownika
set @id_kodu_pocztowego = 
						     ( 
								select id_kodu_pocztowego 
								  from adresy.kody_pocztowe
								 where kod_pocztowy = @kod_pocztowy
							 )
-- odnalezienie id_ulicy z argumentu który został przekazany przez użytkownika
declare @id_ulicy int
set @id_ulicy =
							(
									select id_ulicy 
									  from adresy.ulice 
									 where nazwa_ulicy = @nazwa_ulicy
							)
/* 
  Sprawdzenie czy w tabeli adresy jestnieją id_kodu_pocztowego oraz id_ulicy.
  Jeśli tak procedura w następnym kroku sprawdzi czy dokłądny adres istnieje już w bazie
  i jeśli tak pobierze jego id w celu przekazania do paramtertu output, który zostanie wykorzystany
  w innych procedurach
 */
if exists (
		   select id_kodu_pocztowego
				, id_ulicy
			 from adresy.adresy
			where id_kodu_pocztowego = @id_kodu_pocztowego
			  and id_ulicy           = @id_ulicy
		  )
		   begin 
				if exists (
							select id_kodu_pocztowego
				                 , id_ulicy
			                  from adresy.adresy
			                 where id_kodu_pocztowego = @id_kodu_pocztowego
			                   and id_ulicy = @id_ulicy 
							   and nr_budynku = @nr_budynku
							   and nr_pomieszczenia = @nr_pomieszczenia
						   )
						    begin
								 select 'Adres już w bazie' as komunikat
								    set @id_adresu = 
												  (
												   select id_adresu
											         from adresy.adresy
													where id_kodu_pocztowego = @id_kodu_pocztowego
													  and id_ulicy = @id_ulicy
													  and nr_budynku = @nr_budynku
													  and nr_pomieszczenia = @nr_pomieszczenia
												  )
							end
					else 
-- za sprawą tego fragmentu dodajemy do bazy danych numer budynku oraz numer lokalu
							begin 
									insert into.adresy.adresy
									values(@id_kodu_pocztowego,@id_ulicy,@nr_budynku,@nr_pomieszczenia)
									set @id_adresu = (select SCOPE_IDENTITY())
							end
		   end 
/* w przypadku gdy podany adres nie istnieje za sprawą procedury będzimy sprawdzać 
   czy istnieją poszczególne elementy i jeśli nie to zostaną dodane do odpowiednich tabel
*/
else 
/*jeżeli przekazana wartość w argumencie w postaci nazwwy miasta nie istnieje zostanie ona
dodana. Zakładając że nie istnieje miasto to nie może istnieć i kod pocztowy W przeciwnim wypadku zostanie wyciągnięta wartość id. 
*/
	if not exists (
				   select nazwa_miejscowości 
					 from adresy.miejscowości
					where nazwa_miejscowości = @nazwa_miejscowości
				  )
				begin 
					insert into adresy.miejscowości
						 values (@nazwa_miejscowości)
							set @id_miejscowości = (select SCOPE_IDENTITY())
					insert into adresy.kody_pocztowe
						 values (@kod_pocztowy,@id_miejscowości)
							set @id_kodu_pocztowego_sc_i = (select SCOPE_IDENTITY())
							 if not exists 
/*jeżeli również nie istnieje przekazana w argumencie ulica to zostanie dodana do bazy danych.
wartość id wyciągnięta i przekazana do tabeli adres.adresy.
*/
											(
											   Select nazwa_ulicy 
												 from adresy.ulice
												where nazwa_ulicy = @nazwa_ulicy
											)
								begin
									insert into adresy.ulice
										 values(@nazwa_ulicy)
											set @id_ulicy_sc_i = (select SCOPE_IDENTITY())
									insert into adresy.adresy
										 values(@id_kodu_pocztowego_sc_i,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
											set @id_adresu = (select SCOPE_IDENTITY())
								end
							else
-- w przypadku gdyby ulica istniała zostania pobrana wartość id_ulicy
								begin
									set @id_ulicy_sc_i = 
														(
															Select id_ulicy
															from adresy.ulice
															where nazwa_ulicy = @nazwa_ulicy
														)
									   insert into adresy.adresy
											values(@id_kodu_pocztowego_sc_i,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
											   set @id_adresu = (select SCOPE_IDENTITY())
								end
				end
	else
/*powyższy fragment kodu dotyczył gdyby miasto nie istniało. 
Poniższy będzie analizował dane gdyby miasto istniało 
*/
	begin
		 set @id_miejscowości = 
								(
								  select id_miejscowości 
									from adresy.miejscowości
								   where nazwa_miejscowości = @nazwa_miejscowości
								)
-- miasta często mają kilka kodów, więc następuje sprawdzenie czy podany przez argument kod pocztowy istnieje
		 if not exists 				
					  (
						select kod_pocztowy 
						  from adresy.kody_pocztowe
						 where kod_pocztowy = @kod_pocztowy
					  )
						begin
							insert into adresy.kody_pocztowe
								 values (@kod_pocztowy,@id_miejscowości)
									set @id_kodu_pocztowego_sc_i = (select SCOPE_IDENTITY())
						     if not exists  
											(
											   Select nazwa_ulicy 
												 from adresy.ulice
												where nazwa_ulicy = @nazwa_ulicy
											)
											begin
												  insert into adresy.ulice
														 values(@nazwa_ulicy)
														set @id_ulicy_sc_i = (select SCOPE_IDENTITY())
												  insert into adresy.adresy
														values(@id_kodu_pocztowego_sc_i,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
														set @id_adresu = (select SCOPE_IDENTITY())
											end
									 else 
									        begin
													set @id_ulicy_sc_i = 
																		(
																			Select id_ulicy
																			from adresy.ulice
																			where nazwa_ulicy = @nazwa_ulicy
																		)
													insert into adresy.adresy
														values(@id_kodu_pocztowego_sc_i,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
															set @id_adresu = (select SCOPE_IDENTITY())
						                    end
						    end
				else
-- w tym przypadku sprawdzamy dalesze elementy gdyby kod pocztowy był już wcześniej w bazie 
				if not exists  
											(
											   Select nazwa_ulicy 
												 from adresy.ulice
												where nazwa_ulicy = @nazwa_ulicy
											)
											begin
												  insert into adresy.ulice
														 values(@nazwa_ulicy)
														set @id_ulicy_sc_i = (select SCOPE_IDENTITY())
												  insert into adresy.adresy
														values(@id_kodu_pocztowego,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
														set @id_adresu = (select SCOPE_IDENTITY())
											end
									 else 
									        begin
													set @id_ulicy_sc_i = 
																		(
																			Select id_ulicy
																			from adresy.ulice
																			where nazwa_ulicy = @nazwa_ulicy
																		)
													insert into adresy.adresy
														values(@id_kodu_pocztowego,@id_ulicy_sc_i,@nr_budynku,@nr_pomieszczenia)
															set @id_adresu = (select SCOPE_IDENTITY())
											end
	end
	commit
	end try
	begin catch
	rollback; throw
	end catch 