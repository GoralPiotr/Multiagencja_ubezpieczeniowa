USE [multiagencja_ubezpieczeniowa]
GO
/****** Object:  StoredProcedure [sprzedaż].[pokaż_płatności]    Script Date: 26.08.2022 10:29:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
Poprzez procedurę sprawdzamy płatności dla wskazanej polisy 
Procedura wykona obliczenia uwzględniając ilość rat. Ewentualne rozbieżności 
wynikajace z zaokrągleń zostaną dodane do pierwszej raty za polisę. Za sprawą procedury 
nie jest już konieczne przychowywanie danych na dysku ani użycie funkcji tabelarycznej. 
*/
ALTER   proc [sprzedaż].[pokaż_płatności]
( 
@nr_polisy as varchar(20)
)
as
		  /* 
			 W zmiennej przechowamy informacje ile miesięcy będzie trwać ubezpieczenie.
		     Zmienna znajdze najlepszy użytek w przypadku polis dłuzszych niż rok. 
		  */
			 declare @ilość_miesięcy as int 
		  /* Zmienna przechwytuje wartość związaną z liczbą rat, która będzi wykorzystana później.*/
			 declare @raty as int
		  /* W zmiennej przechowamy całościową opłatę za polisę. Tzw. składkę.*/ 
			 declare @składka as decimal(6,2) 
		  /*
			 W zmiennej przechowam informację o pierwszym terminie płatności. 
 			 Od tego terminu będziemy wyliczaś termny kolejnych rat
		  */
		     declare @termin_pierwszej_raty as date

		  /* uzyskanie informacji i wykorzystanie zmiennych w kolejnej części procedury */
			 select @ilość_miesięcy = (datediff(MONTH,początek_ubezpieczenia,koniec_ubezpieczenia)+1)
				  , @raty = raty
				  , @składka = składka
				  , @termin_pierwszej_raty = termin_pierwszej_raty
			   from sprzedaż.polisy
			  where nr_polisy = @nr_polisy
/*
	Utorzenie zmiennej która pozwoli obliczyć kolejny dzień raty
*/
declare @terminy as int = 
						  (
						    @ilość_miesięcy/@raty
						  )
/*
	Obliczenie pierwszej raty składki.
*/
declare @rata as decimal(6,2) = 
							    (
								  @składka/@raty
								)
/*
	Liwkidacja problemu zaookrągleń i tzw brakującego grosza. Różnica doliczana do pierwszej raty. 
*/
declare @pierwsza_rata as decimal(6,2) = 
										 (
											@rata + (@składka - (@rata*@raty))
										 )
/*
  Wykorzystanie powyższych zmienny i obliczenie za pośrednictwem rekurnecyjnego CTE terminów kolejnych rat
*/
					;with obliczenia as
					(
					select 1 as nr_raty
						 , @pierwsza_rata as rata
						 , @termin_pierwszej_raty as data_raty
				union all
					select nr_raty + 1, @rata as rata
						 , DATEADD(month,@terminy ,data_raty) as data_raty 
					  from obliczenia 
					 where nr_raty + 1 <= @raty 
					) 
					select nr_raty,rata as kwota,data_raty 
					  from obliczenia 	
		