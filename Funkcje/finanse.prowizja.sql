USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  UserDefinedFunction [finanse].[prowizja]    Script Date: 26.08.2022 11:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   function [finanse].[prowizja]
(  
 @id_pracownika smallint
,@id_produktu smallint
,@data_wpisania_polisy date
)
RETURNS TABLE AS RETURN
	Select prowizja
		 , od_kiedy
		 , do_kiedy
	from finanse.stawki_prowizyjne
   where id_pracownika = @id_pracownika
     and id_produktu = @id_produktu
	 and @data_wpisania_polisy between od_kiedy and do_kiedy 