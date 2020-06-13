 use sistemaInventario;

 /*creacion para mi modelo parte 1*/
 /*manera consultas*/

/*mis datos P*/
create procedure Modelo_p1
as
select
lm.id_listaMateriale as [LOTE],
lm.Padre as[Material],
lm.cantidad_Elaborar as [Cantidad]
from Lista_Material lm 
group by lm.id_listaMateriale, lm.Padre, lm.cantidad_Elaborar
order by lm.id_listaMateriale asc

/*Ejecutar el proceso*/
execute Modelo_p1

/*mis datos Q*/
create procedure Modelo_q1
as
select
lm.id_listaMateriale as [LOTE],
lm.Padre as[Material],
lm.cantidad_Elaborar as [Cantidad],
sum(sum(lm.cantidad_Elaborar)) over (order by lm.id_listaMateriale asc) as [Total Acumulado],
(round((100 * count(lm.cantidad_Elaborar)/ sum(lm.cantidad_Elaborar)),2)) as [Porcentaje]
from Lista_Material lm 
group by lm.id_listaMateriale, lm.Padre, lm.cantidad_Elaborar
order by lm.id_listaMateriale asc

/*Ejecutar el proceso*/
execute Modelo_q1

/*modelo */

/*creacion de mi modelo parte 2*/
/*manera consultas*/

/*mis datos P*/
create procedure Modelo_p2
as
SELECT lm.Padre as [Material], 
SUM(lm.cantidad_Elaborar) AS [Cantidad]
FROM Lista_Material lm
GROUP BY lm.Padre

/*Ejecutar el proceso*/
execute Modelo_p2

/*mis datos Q*/
create procedure Modelo_q2
as
SELECT lm.Padre as [Material], 
SUM(lm.cantidad_Elaborar) AS [Cantidad],
sum(sum(lm.cantidad_Elaborar)) over (order by lm.Padre asc) as [Total Acumulado],
(round((100 * count(lm.cantidad_Elaborar)/ sum(lm.cantidad_Elaborar)),2)) as [Porcentaje]
FROM Lista_Material lm
GROUP BY lm.Padre

/*Ejecutar el proceso*/
execute Modelo_q2
 