create or ALTER   proc [pracownicy].[dodaj_adres_korespondencyjny]
(
@Miejscowoœæ		      varchar(30),
@Ulica					  varchar(20) = null,
@Nr_budynku				  varchar(5),
@Nr_lokalu				  varchar(5) = null,
@kod_pocztowy			  varchar(6),
@id_adresu_korespondencyjnego int = null output
)
as
begin try
begin tran
---sprawdzenie czy podany adres korespondencyjny nie istnieje w bazie. Jeœli nie zostanie dodany
if not exists (
				select id_adresu_korespondencyjnego
				  from pracownicy.adresy_korespondencyjne
				 where  Miejscowoœæ = @Miejscowoœæ
				   and       (Ulica = @Ulica or @Ulica is null)
				   and   Nr_budynku = @Nr_budynku
				   and   (Nr_lokalu = @Nr_lokalu or @Nr_lokalu is null)
				   and kod_pocztowy = @kod_pocztowy
			  )
	begin 
			insert into pracownicy.adresy_korespondencyjne
				 values(@Miejscowoœæ,@Ulica,@Nr_budynku,@Nr_lokalu,@kod_pocztowy)
		
	end
else
	begin
			select 'adres ju¿ w bazie' as komunikat
	end
-----ustawienie zmiennej @id_adresu_korespondencyjnego i przekazanie jej w parametrze output
	set @id_adresu_korespondencyjnego = 
	                  (
				select id_adresu_korespondencyjnego
				  from pracownicy.adresy_korespondencyjne
				 where  Miejscowoœæ = @Miejscowoœæ
				   and       (Ulica = @Ulica or @Ulica is null)
				   and   Nr_budynku = @Nr_budynku
				   and   (Nr_lokalu = @Nr_lokalu or @Nr_lokalu is null)
				   and kod_pocztowy = @kod_pocztowy
			  )
commit
end try
begin catch
rollback
declare @id_adresu_korespondencyjnego_s as int 
set @id_adresu_korespondencyjnego_s = (
					select isnull(MAX(id_adresu_korespondencyjnego),0) 
		                         from pracownicy.adresy_korespondencyjne
				      )
dbcc checkident ('pracownicy.adresy_korespondencyjne',reseed,@id_adresu_korespondencyjnego_s)
end catch