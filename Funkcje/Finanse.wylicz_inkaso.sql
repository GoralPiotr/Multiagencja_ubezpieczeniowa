USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  UserDefinedFunction [finanse].[wylicz_inkaso]    Script Date: 26.08.2022 11:27:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   function [finanse].[wylicz_inkaso]
(
@polecenie as varchar(10),
@id_pracownika as smallint,
@data_od as date = null,
@data_do as date = null
)
returns decimal(10,2)
as
begin
	set @data_od = ISNULL(@data_od, getdate())
	set @data_do = ISNULL(@data_do, getdate())
		declare @x as decimal(10,2)
			if @polecenie = 'suma'
				begin
					set @x = (
								  select SUM(składka) as suma_inkaso 
									from sprzedaż.polisy
								   where data_wpisania_polisy between @data_od and @data_do
									 and id_pracownika = @id_pracownika 
								group by id_pracownika
	                          )
				end
			if @polecenie = 'średnia'
				begin
					set @x = (
								  select avg(składka) as suma_inkaso 
									from sprzedaż.polisy
								   where data_wpisania_polisy between @data_od and @data_do
									 and id_pracownika = @id_pracownika 
								group by id_pracownika
					         )
				 end
			if @polecenie = 'ilość'
				begin
					set @x = (
								  select count(składka) as suma_inkaso 
									from sprzedaż.polisy
								   where data_wpisania_polisy between @data_od and @data_do
									 and id_pracownika = @id_pracownika 
								group by id_pracownika
					         )
				 end
return @x
end 




