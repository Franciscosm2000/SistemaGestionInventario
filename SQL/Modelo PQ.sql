use sistemaInventario;

/*modelo PQ*/

/*creacion para mi modelo parte 1*/

create procedure modelo_parte_1
as 
/*
declare @contador int
set @contador = (select ROW_NUMBER() over(order by lm.cantidad_Elaborar desc) AS [Lote] from Lista_Material lm);
*/
select
lm.id_listaMateriale,
lm.Padre as[Modelo],
lm.cantidad_Elaborar as [Volumen Lote],
sum(sum(lm.cantidad_Elaborar)) over (order by lm.id_listaMateriale asc) as [Total Acumulado]
/*(COUNT(lm.cantidad_Elaborar)*100 / (select Count(cantidad_Elaborar) From Lista_Material)) as porcentaje*/
from Lista_Material lm 
group by lm.id_listaMateriale, lm.Padre, lm.cantidad_Elaborar
order by lm.id_listaMateriale asc

/*creacion de mi modelo parte 2*/

/*sumando los modelos*/
    SELECT lm.Padre , SUM(lm.cantidad_Elaborar) AS Total
    FROM Lista_Material lm
    GROUP BY lm.Padre
	
