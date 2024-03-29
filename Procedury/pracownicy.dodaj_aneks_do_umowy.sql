USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[dodaj_aneks_do_umowy]    Script Date: 20.08.2022 20:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [pracownicy].[dodaj_aneks_do_umowy]
(
@nr_umowy      as varchar(10),
@nr_aneksu     as varchar(10),
@pensja        as decimal(7,2) = null,
@id_stanowiska as smallint     = null,
@id_placówka   as smallint     = null,
@początek      as date,
@koniec        as date         = null
)
as
----sprawdzenie czy dany aneks już istnieje dla danej umowy. Jeśli tak procedura wświetli 
----stosowny komunikat i zostanie zatrzymana.
if exists (
		     select nr_aneksu 
               from pracownicy.szczegóły_umowy
			  where nr_aneksu = @nr_aneksu
			    and id_umowy = (
								 select id_umowy 
								   from pracownicy.umowy
								  where nr_umowy = @nr_umowy
							    )

		   )
begin
	Select 'Już istnieje taki ankes. Popraw numer' as komunikat
end
---- w przypadku poprawnej numeracji procedura wykona poniższe kroki i wpisze aneks do umowy
---- uwzględniając podane parametry
else
begin
begin try
begin tran
declare @id_pracownika   as int 
declare @id_umowy        as int
declare @pensja_s        as decimal(7,2)
declare @id_stanowiska_s as smallint
declare @id_placówki_s   as smallint
----
		set @id_umowy = (
						 select id_umowy 
						   from pracownicy.umowy
						  where nr_umowy = @nr_umowy
						)

		select @id_pracownika   = pu.id_pracownika 
			 , @pensja_s        = su.pensja
			 , @id_stanowiska_s = su.id_stanowiska
			 , @id_placówki_s   = su.id_placówki
		  from pracownicy.szczegóły_umowy as su
	inner join pracownicy.umowy as pu
		    on su.id_umowy = pu.id_umowy
		 where nr_umowy = @nr_umowy
		   and początek =  (
							select MAX(początek) 
						      from pracownicy.szczegóły_umowy
						     where id_umowy = @id_umowy
						  )
-----
	update pracownicy.szczegóły_umowy
	   set koniec = (DATEADD(d,-1,@początek))
	 where id_umowy    = @id_umowy 
	   and początek    = (
							select MAX(początek) 
							  from pracownicy.szczegóły_umowy
							 where id_umowy = @id_umowy
						  )
----- funkcja coalesce przepisze dane, które nie zostały zmienione. 						
	insert into pracownicy.szczegóły_umowy
	values (@id_umowy,@nr_aneksu,coalesce(@pensja,@pensja_s)
	,coalesce(@id_stanowiska,@id_stanowiska_s),coalesce(@id_placówka,@id_placówki_s),@początek,@koniec)
-----
select 'dodano aneks' as komunikat
commit
end try
	begin catch
		rollback
		print 'transakcja nie powiodła się'
		--;throw
	end catch
end