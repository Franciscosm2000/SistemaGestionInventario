use sistemaInventario;

/*Tabla Programa Maestro*/
create proc ProgramaMaestro
as
select p.nombre as Nombre, pm.semana as Semana, pm.cantidad as Cantidad
from Producto p inner join Programa_Maestro pm 
on (p.id_Producto = pm.id_Producto);
go

exec ProgramaMaestro

/*Registro Inventario*/
create proc Registro_inventario
as
select m.descripcion as Descripcion 
,lm.nivel as Nivel,
m.disponible as Disponible,
m.stock_seguridad as [Stock de Seguridad],
lm.Padre as [Elemento Padre],
lm.cantidad_Elaborar as [Cantidad a Elaborar],
m.tiempo_espera_pedido as [Tiempo de Espera],
rp.semana as [semana],
rp.cantidad as Cantidad
 from Producto p
inner join Lista_Material lm
on(p.id_Producto = lm.id_Producto)
inner join Material m 
on (lm.id_Material = m.id_Material)
inner join Recepciones_Programadas rp
on(rp.id_material = m.id_Material)
go

exec Registro_inventario
