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

																/*Lote por lote*/

																USE [sistemaInventario]
GO
/****** Object:  StoredProcedure [dbo].[MetodoLotePorLote]    Script Date: 11/05/2020 22:35:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[MetodoLotePorLote]
@idProducto int
as
	
	create table #Temporal
	(
		id_temporal int primary key identity(1,1),
		necesidadesBrutas int,
		recepcionProgramada int,
		disponible int,
		necesidadesNetas int,
		recepcionOrden int,
		lanzamientoOrden int
	)
		
	declare @cont int;
	declare @cont1 int;
	set @cont = 1;
	set @cont1 = 1;

	declare @cont2 int;
    set @cont2 = 1;

	declare @cantidadSemana int;
	declare @cantidadM int;

	set @cantidadSemana =( select pm.semana from Programa_Maestro pm where pm.semana in(select max(pm.semana) from Programa_Maestro pm));
	set @cantidadM = ( select count(lm.id_Producto) from Lista_Material lm where lm.id_Producto = @idProducto);


	while(@cont1<=@cantidadM)
	begin --primer while

		while(@cont <= @cantidadSemana)
		begin --segundo while
			declare @recepcion int;
			declare @lanzamiento int;
			set @lanzamiento = 0;
			
			declare @necesidadesB int

			if(@cont1 = 1)
			begin
				set @necesidadesB = (select cantidad from Programa_Maestro pm where pm.id_producto = @idProducto and pm.semana = @cont);
			end
			
			else  
			begin 
				set @necesidadesB = (select pm.lanzamientoOrden from #Temporal pm where pm.id_temporal = @cont);
				select @necesidadesB;
			end

			declare @recepcionesP int
			set @recepcionesP = 0	

			declare @dispo int;

			if(@cont = 1)
				begin
					set @dispo = (select p.disponible from Material p where p.id_Material = @cont1 ) + @recepcionesP - @necesidadesB;
				end

			else
				begin
					set @dispo = (select t.disponible from #Temporal t where t.id_temporal =( @cont - 1 )) + @recepcionesP - @necesidadesB;
				end

			declare @necesidades int;
		
			if(@dispo < 0)
			begin
				set @dispo = 0;

				set @necesidades = @necesidadesB + (select m.stock_seguridad from Material m where m.id_Material = @cont1) - (select t.disponible from #Temporal t where t.id_temporal = (@cont -1)) - @recepcionesP;
				set @recepcion = @necesidades;
			end


			else
				begin
					set @necesidades = 0;
					set @recepcion = 0;
				end


		
			insert into #Temporal (necesidadesBrutas, recepcionProgramada, disponible, necesidadesNetas, recepcionOrden) 
			values (@necesidadesB, @recepcionesP, @dispo, @necesidades,@recepcion);

			SET @cont=@cont+1;
		end --cierre primer while

			/*para poner el lanzamiento de orde*/
		
		while(@cont2 < @cantidadSemana)
		begin
			update #Temporal set lanzamientoOrden = (select recepcionOrden from #Temporal t where t.id_temporal = (@cont2 + 1)) where id_temporal = @cont2;
			SET @cont2=@cont2+1;
		end

		select *from #Temporal

		SET @cont1=@cont1+1;
		set @cont = 1;
		delete from  #Temporal;
	end --cierre 2do while

	drop table #Temporal

exec MetodoLotePorLote 1