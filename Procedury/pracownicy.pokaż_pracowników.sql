USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [pracownicy].[pokaż_pracowników]    Script Date: 20.08.2022 23:03:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER     proc [pracownicy].[pokaż_pracowników]
(
	@nazwa as varchar(50) = null
)
as
/*
za sprawą procedury zobaczymy dane wszystkich pracowniników. Procedura korzysta z widoku
from view_biuro.pracownicy_nazwa. Dodatkowo uzwględniamy role. Każda z ról będzie widzieć
inne kolumny. 
*/
begin
declare @n as nvarchar(50)
    set @n = @nazwa;
declare @sql as nvarchar(1000)
declare @rola as varchar(13)
    set @rola = 
			    (
							  SELECT DP1.name AS DatabaseRoleName  
								FROM sys.database_role_members AS DRM  
					RIGHT OUTER JOIN sys.database_principals   AS DP1  
								  ON DRM.role_principal_id   = DP1.principal_id  
					 LEFT OUTER JOIN sys.database_principals   AS DP2  
								  ON DRM.member_principal_id = DP2.principal_id  
							   WHERE DP2.name = (select SYSTEM_USER)
				)
if @rola = 'Sprzedawcy'
	begin
		set @sql = 
		'select pracownik
			  , nr_tel_służbowy
			  , email_służbowy
			  , kod_pocztowy
			  , nazwa_miejscowości
			  , nazwa_ulicy
			  , nr_budynku
			  , nr_pomieszczenia
		  from [biuro].[view_pracownicy_nazwa]
		 where pracownik like ''%'' + @nazwa + ''%'' 
			or @nazwa is null;';
	end
else
	begin
		set @sql = 
		'select id_pracownika
			  , nr_umowy
			  , pracownik
			  , nr_tel_służbowy
			  , email_służbowy
			  , kod_pocztowy
			  , nazwa_miejscowości
			  , nazwa_ulicy
			  , nr_budynku
			  , nr_pomieszczenia
			  , pensja
			  , początek
			  , koniec
		  from [biuro].[view_pracownicy_nazwa]
		 where pracownik like ''%'' + @nazwa + ''%'' 
			or @nazwa is null;';
	end
exec sp_executesql
@stmt = @sql,
@params = N'@nazwa as nvarchar(200)',
@nazwa = @n
end