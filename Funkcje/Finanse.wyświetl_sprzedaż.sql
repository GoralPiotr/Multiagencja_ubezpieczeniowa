USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  UserDefinedFunction [finanse].[wyświetl_sprzedaż]    Script Date: 26.08.2022 11:26:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   function [finanse].[wyświetl_sprzedaż]
(
	@nr_polisy as varchar(20) 
)
/*
Tzw funkcja multistatement za pośrednictwem której chcem uzyskać informację o wszystkich polisach 
oraz kwestiach związanych z płątnościami. Dane uzyskane po zastosoowaniu zagnieżdzonej pętli while
*/
returns @obliczenia table 
(
  nr_raty int 
, termin_płatności date
, kwota decimal(6,2)
)
as begin
declare @min_id_polisy as int 
declare @max_id_polisy as int 
select  @min_id_polisy = min(id_polisy) 
	  , @max_id_polisy = max(id_polisy) 
  from  sprzedaż.polisy

declare @i as int = @min_id_polisy
declare @raty as int = 1
  while @i <= @max_id_polisy
--- pętla nr 1
	   begin
			declare @termin_pierwszej_raty as date = 
													(
													  select termin_pierwszej_raty 
														from sprzedaż.polisy
													   where id_polisy = @i
													)
			declare @ilość_rat as int = (
										 select (datediff(MONTH,początek_ubezpieczenia,koniec_ubezpieczenia)+1)/raty 
										   from sprzedaż.polisy
										  where id_polisy = @i
										 )
--- pętla nr 2
			   while @raty <= (select raty from sprzedaż.polisy
								where id_polisy = @i)
								begin 
										insert into @obliczenia
										select @raty as nr_raty
											 , @termin_pierwszej_raty as termin_płatności
											 , cast(składka/raty as decimal (6,2)) as kwota
										  from sprzedaż.polisy
										 where id_polisy = @i
										   and nr_polisy = @nr_polisy
					set @raty +=1
					set @termin_pierwszej_raty = dateadd(month,@ilość_rat,@termin_pierwszej_raty)				
								end
							set @raty = 1		   
				   set @i +=1
			 end
	Return
end


