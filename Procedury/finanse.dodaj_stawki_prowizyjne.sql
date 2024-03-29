USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [finanse].[dodaj_stawki_prowizyjne]    Script Date: 25.08.2022 22:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   procedure [finanse].[dodaj_stawki_prowizyjne]
(
 @polecenie as varchar(6),
 @id_pracownika as int,
 @nazwa_produktu varchar(50),
 @prowizja decimal (4,2),
 @od_kiedy date,
 @do_kiedy date = '20991231'
)
as
	declare @id_produktu as smallint = 
									  ( 
									    select id_produktu 
									      from sprzedaż.produkty
										 where nazwa_produktu = @nazwa_produktu
								      )
	if not exists  ( 
					 select polecenie 
					   from pomocnicza_prowizja
					  where polecenie = @polecenie
					)
		begin
				select 'błędne polecenie' as komunikat
		end
	else
		begin
		 if @polecenie = 'nowe'
		     begin
				if exists (
				             select id_pracownika
							      , id_produktu
								  , od_kiedy
							   from finanse.stawki_prowizyjne
							  where id_pracownika = @id_pracownika
							    and   id_produktu = @id_produktu
						   )
							   begin 
									select ('już takie dane wprowadzono wcześniej') as komunikat
							   end
				 else
						begin
							insert into finanse.stawki_prowizyjne
								values(@id_pracownika,@id_produktu,@prowizja,@od_kiedy,@do_kiedy)
						end
			   end 
		  else
		    begin
			update finanse.stawki_prowizyjne
					set do_kiedy = dateadd(day,-1,@od_kiedy)
				  where id_pracownika = @id_pracownika 
					and id_produktu   = @id_produktu
					and od_kiedy      = (
										   select MAX(od_kiedy) 
											 from finanse.stawki_prowizyjne
											where id_pracownika = @id_pracownika
										)
					insert into finanse.stawki_prowizyjne
					values(@id_pracownika,@id_produktu,@prowizja,@od_kiedy,@do_kiedy)
			end
		end