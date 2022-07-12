USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_umowę]    Script Date: 12.07.2022 19:40:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [pracownicy].[dodaj_umowę]
(
	@nr_umowy varchar(10),
	@pesel as varchar(11)=null,
	@nip as int = null,
	@nip_podmiotu_nadrzędnego as int,
	@nazwa_umowy as varchar(20),
	@początek_umowy as date,
	@koniec_umowy as date = null,
	@pensja as decimal(7,2),
	@nazwa_stanowiska as varchar(50),
	@nazwa_działu as varchar(50),
	@id_placówki as smallint
)
as
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
			 if @nip is null 
			   begin
					declare @id_pracownika as smallint
						set @id_pracownika = 
											 ( 
												select id_pracownika 
											      from pracownicy.zatrudnieni
											     where pesel = @pesel
											 )
					declare @id_pracownika_p as smallint
						set @id_pracownika_p = 
											    ( 
												  select id_pracownika 
											        from pracownicy.partnerzy
											       where nip = @nip_podmiotu_nadrzędnego
											    )
					declare @id_rodz_umowy as smallint 
					    set @id_rodz_umowy = 
											    (
												  select id_rodz_umowy 
												    from pracownicy.rodzaje_umów
												   where nazwa_umowy = @nazwa_umowy
												)
					insert into pracownicy.umowy
					values(@nr_umowy,@id_pracownika,@id_pracownika_p
					      ,@id_rodz_umowy,@początek_umowy,@koniec_umowy)
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
					declare @id_działu as smallint
						set @id_działu =  
										 (
											select id_działu 
											  from pracownicy.działy
											 where nazwa_działu = @nazwa_działu
										 )
					insert into pracownicy.szczegóły_umowy(id_umowy,pensja,id_stanowiska,id_działu,id_placówki,początek,zakończenie)
					values(@id_umowy,@pensja,@id_stanowiska
					      ,@id_działu,@id_placówki,@początek_umowy,@koniec_umowy)
			   end
			 else
			   begin
					declare @id_pracownika_partner as smallint
						set @id_pracownika_partner = 
													 ( 
														select id_pracownika 
														  from pracownicy.partnerzy
														 where nip = @nip
													 )
					declare @id_pracownika_pp as smallint
						set @id_pracownika_pp = 
											    ( 
												  select id_pracownika 
											        from pracownicy.partnerzy
											       where nip = @nip_podmiotu_nadrzędnego
											    )
					declare @id_rodz_umowy_p as smallint 
					    set @id_rodz_umowy_p = 
											    (
												  select id_rodz_umowy 
												    from pracownicy.rodzaje_umów
												   where nazwa_umowy = @nazwa_umowy
												)
					insert into pracownicy.umowy
					values(@nr_umowy,@id_pracownika_partner,@id_pracownika_pp
					      ,@id_rodz_umowy_p,@początek_umowy,@koniec_umowy)
----uzyskanie id_numer_umowy i przekazanie wartości dalej
					declare @id_umowy_p as int
					    set @id_umowy_p = (select SCOPE_IDENTITY())
----uzyskanie wartości zmiennych z przekazanych parametrów
					declare @id_stanowiska_p as int 
						set @id_stanowiska_p = 
											 (
											   select id_stanowiska 
											     from pracownicy.stanowiska
												where nazwa_stanowiska = @nazwa_stanowiska
										     )
					declare @id_działu_p as int
						set @id_działu_p =  
										 (
											select id_działu 
											  from pracownicy.działy
											 where nazwa_działu = @nazwa_działu
										 )
					insert into pracownicy.szczegóły_umowy(id_umowy,pensja,id_stanowiska,id_działu,id_placówki,początek,zakończenie)
					values(@id_umowy_p,@pensja,@id_stanowiska_p
					      ,@id_działu_p,@id_placówki,@początek_umowy,@koniec_umowy)
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