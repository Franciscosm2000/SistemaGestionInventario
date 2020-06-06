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
																					
											/*METODO LOTE POR LOTE*/					


create proc lotePorlote
@idProducto int
as
	/*tabla temporal para guardar los datos del padre y obtener las necesidades brutas */
	
	create table #Ordenes
	(
		id int identity (1,1) primary key,
		elemento varchar(100),
		cantidad int
	)
	
	--Tabla auxiliar para llenar datos de necesidades brutas
	create table #aux
	(
		id int primary key identity(1,1),
		id_Orden int
	)

	declare @idMaterial int;
	set @idMaterial = 1;
	declare @cantidadSemana int;
	declare @cantidadM int;

	set @cantidadSemana =( select pm.semana from Programa_Maestro pm where pm.semana in(select max(pm.semana) from Programa_Maestro pm));
	set @cantidadM = ( select count(lm.id_Producto) from Lista_Material lm where lm.id_Producto = 1 /*idproducto*/);

	
	while (@idMaterial <= @cantidadM) --INnicio del while que contiene todos los materiales 
	begin

		/*declaracion de tabla temporal*/

		create table #Temporal
		(
			id int identity (1,1) primary key,
			material varchar(100),
			necesidadesBrutas int,
			recepcionesProgramadas int,
			disponible int,
			necesidadesNetas int,
			lanzamientoOrden int,
		)

			/*Metodo de llenado de tabla temporal*/
	
		declare @cont int
		set @cont = 1;

			while(@cont <= @cantidadSemana) -- INicio del while de las semana
			begin
	 
-------------------------------------------Variables
			 declare @necesidadesB int;
			 declare @stock int;
			 declare @recepcionesP int;
			 declare @dispo int;
			 declare @necesidadesN int;
			 declare @lanzamientoOrden int;
			 declare @InvPeriodoAnterior int;
			 --- Llenado de variables
--------------------------------------------Necesidades Brutas
			if(@idMaterial = 1) --- condicional cuando el material es el 1
			begin
			 set @necesidadesB = (select pm.cantidad from  Programa_Maestro pm where pm.semana = @cont); 
			end

			else 
			begin
				declare @materialPadre varchar(100);
				declare @cantidadNecesitada int;
				set @materialPadre = (select lm.Padre from Lista_Material lm where lm.id_Material = @idMaterial)
				set @cantidadNecesitada = (select lm.cantidad_Elaborar from Lista_Material lm where lm.id_Material = @idMaterial);


		--Insertando datos de la tabla auxiliar
				insert into	#aux 
				 select o.id from #Ordenes o where o.elemento = @materialPadre;
			
					set @necesidadesB = (select o.cantidad from #Ordenes o where o.elemento = @materialPadre and o.id = 
					(select id_Orden from #aux a where a.id = @cont)) * @cantidadNecesitada;
		
		--select *from #aux
			end ---fin del else
-------------------------------------------Recepciones Programadas

				if((select rp.cantidad from Recepciones_Programadas rp where rp.id_material = /*idMaterial*/@idMaterial and rp.semana = @cont) is null)
				begin
					 set @recepcionesP = 0;	
				end
				else
				begin
					 set @recepcionesP = (select rp.cantidad from Recepciones_Programadas rp where rp.id_material = /*idMaterial*/ @idMaterial and rp.semana = @cont) ;	
				end

-------------------------------------Disponible
					if(@cont > 1)
					begin
					----NoP es para saver si el valor es positivo o no y asi poner asigniar el valor del periodo anterior
						declare @NoP int

						set @NoP = (select t.disponible from #Temporal t where t.id = (@cont - 1));

						if(@NoP <0)
						begin
							set @InvPeriodoAnterior = (select m.stock_seguridad from Material m where m.id_Material = @idMaterial);
						end
						else
						begin
							set @InvPeriodoAnterior = (select t.disponible from #Temporal t where t.id = (@cont - 1));
						end

						
					end
					else
					begin
						set @InvPeriodoAnterior = (select m.disponible from Material m where m.id_Material = @idMaterial);
					end
						set @dispo = (dbo.Disponibilidad(@necesidadesB , @InvPeriodoAnterior, @recepcionesP));
				
-----------------------------------------------------necesidades netas

					set @stock = (select m.stock_seguridad from Material m where m.id_Material = @idMaterial);

-----------------------------------------------------necesidades netas
				if(@dispo < 1)
				begin
				set @necesidadesN = dbo.NecesidadesNetas(@necesidadesB,@stock,@InvPeriodoAnterior,@recepcionesP);
				--	set @necesidadesN = -(@dispo);
				end
				else 
				begin
					set @necesidadesN = 0; 
				end

				

				---Llendo de tabla
				insert into #Temporal(necesidadesBrutas ,material , recepcionesProgramadas , disponible , necesidadesNetas)
				values (@necesidadesB,(select m.descripcion FROM  Material m where m.id_Material = @idMaterial),@recepcionesP,@dispo,@necesidadesN);

--------------------------------------------------Lanzamiento de orden 
				--Se tiene que modificar de que para cada elemento hay diferente lanzamiento de orden
				--
				
				declare @aux int;
				set @aux = 1;

		
				while(@aux < @cantidadSemana) --while para colocar en su posicion al lanzamiento de orden 
				begin
			
					if((select t.necesidadesNetas from #Temporal t where t.id = (@aux + 1)) > 0 )
					begin
						set @lanzamientoOrden = (select t.necesidadesNetas from #Temporal t where t.id = (@aux + 1));
					end

					else 
					begin
						set @lanzamientoOrden = 0;
					end
			
						---Llendo de tabla
						update #Temporal set lanzamientoOrden = @lanzamientoOrden where id = @aux ;

					set @aux = @aux + 1;
				end -- Fin del while*/

				--Incrementado contador
				set @cont = @cont + 1;
				--eliminacion de datos y reiniciando el id
				truncate table #aux;
				DBCC CHECKIDENT (#aux, RESEED, 1)
			end -- fin del while de las semana

--------------------------------WHILE para guardar los datos del elemento para el siguiente
			declare @aux2 int
			set @aux2 = 1;
			while(@aux2 <= @cantidadSemana)
			begin
					--Guardando datos para los proximos calculos
				declare @elemento varchar(100);
				declare @cant int;
				set @elemento = (select lm.descripcion from Material lm where id_Material = @idMaterial and @idProducto = 1);
				set @cant = (select t.lanzamientoOrden from #Temporal t where t.id = @aux2);
				insert into #Ordenes (elemento,cantidad) values (@elemento,@cant);

				set @aux2 = @aux2 + 1;
			end
--------------------------------------------------------------------------------------------------------------------
			select *from #Temporal;
			drop table #Temporal --elimacion de tabla temporal

			set @idMaterial = @idMaterial + 1;
		end
			drop table #aux;
			--select *from #Ordenes
			drop table #Ordenes
go

exec lotePorlote 1


/*Funcion de necesidades netas*/
/*Necesidades netas= Necesidades brutas+stock de seguridad-inventario disponible del período anterior-recepciones programadas*/

create function Disponibilidad
(@NecesidadesB int, @inventarioDA int,@recepcionesP int)	
returns int
as
begin
	 declare @dispo int
		set @dispo = (@inventarioDA + @recepcionesP - @NecesidadesB);
	
	 return @dispo;
end


create function NecesidadesNetas
(@NecesidadesB int,@ss int, @inventarioDA int,@recepcionesP int)	
returns int
as
begin
	 declare @necesidades int
		set @necesidades = (@NecesidadesB + @ss - @inventarioDA - @recepcionesP);
	
	 return @necesidades;
end



										/*Metodo EOQ Cantidad economica de pedido*/


alter proc MetodoEOQ
@idProducto int
as	
	create table #Temporal
		(
			id int identity (1,1) primary key,
			necesidadesBrutas int,
			recepcionesProgramadas int,
			disponible int,
			necesidadesNetas int,
			lanzamientoOrden int,
		)

	
		declare @cont int
		set @cont = 1;
		declare @cantidadSemana int;
		declare @cantidadM int;

		set @cantidadSemana =( select pm.semana from Programa_Maestro pm where pm.semana in(select max(pm.semana) from Programa_Maestro pm));
			while(@cont <= @cantidadSemana) -- INicio del while de las semana
			begin
	 
-------------------------------------------Variables
			 declare @necesidadesB int;
			 declare @stock int;
			 declare @recepcionesP int;
			 declare @dispo int;
			 declare @necesidadesN int;
			 declare @lanzamientoOrden int;
			 declare @InvPeriodoAnterior int;
			 --- Llenado de variables
--------------------------------------------Necesidades Brutas
			 set @necesidadesB = (select pm.cantidad from  Programa_Maestro pm where pm.semana = @cont); 

-------------------------------------------Recepciones Programada

				if((select rp.cantidad from Recepciones_Programadas rp where rp.id_material = @idProducto and rp.semana = @cont) is null)
				begin
					 set @recepcionesP = 0;	
				end
				else
				begin
					 set @recepcionesP = (select rp.cantidad from Recepciones_Programadas rp where rp.id_material = /*idMaterial*/ @idProducto and rp.semana = @cont) ;	
				end

----------------------------------------------Inventario Disponible
				if(@cont = 1)
				begin
					set @dispo = (select lm.disponible from Material lm where lm.id_Material = @idProducto);
				end --Fin if

				else
				begin
										/*necesidades netas -recepcion de orden*/
					declare @NecesidadesD int;

					set @NecesidadesD = (select t.necesidadesNetas from #Temporal t where t.id = (@cont - 1));

					if(@cont%2=0)
					begin
						set @dispo = (select dbo.Cantidades(@idProducto)) - @necesidadesN  ;
					end

					else 
					begin
							/*Inventario dispo-necesidades brutas*/
						declare @inventarioAnterior int;
						declare @necesidadesBrutas int;

						set @inventarioAnterior= (select t.disponible from #Temporal t where t.id = (@cont - 1));
						set @necesidadesBrutas= (select t.necesidadesBrutas from #Temporal t where t.id = (@cont - 1));

						set @dispo =  @inventarioAnterior - @necesidadesBrutas;

					end
						
				end --Fin else

----------------------------------------------Necesidades Netas
				if(@cont%2=0)
				begin
					set @necesidadesN = 0;
				end

				else 
				begin
					set @necesidadesN = @necesidadesB - @dispo;
				end

----------------------------------------------Lanzamiento de orden

				if(@cont%2=0)
				begin
					set @lanzamientoOrden = (select dbo.Cantidades(@idProducto));
				end

				else 
				begin
					set @lanzamientoOrden = 0;
				end

				
				 insert into #Temporal (necesidadesBrutas, recepcionesProgramadas, disponible, necesidadesNetas, lanzamientoOrden)
				  values (@necesidadesB,@recepcionesP,@dispo,@necesidadesN,@lanzamientoOrden);


		set @cont = @cont + 1;
		end---Fin del while
		select *from #Temporal;
		drop table #Temporal;
go

exec MetodoEOQ 1


/*Funcion de cantidad*/
--verificar funcion
alter function Cantidades
(@id int)
returns float
as
begin
	declare @Demanda int

	set @Demanda = (select avg(pm.cantidad) as Demanda
					from Producto p inner join Programa_Maestro pm 
					on (p.id_Producto = pm.id_Producto)) *52; 

	declare @Q float
	declare @divicion float

	set @divicion = (2*@Demanda*(select p.costoPedir from Producto p where id_Producto = @id))/((select p.costoMantenimiento from Producto p where id_Producto = @id)*52);

	set @Q =  ROUND((SQRT(@divicion)),0);


	return @Q
end 

select dbo.Cantidades(1)

										/*Metodo POQ Cantidad economica de pedido*/

create proc MetodoPOQ
begin
end



alter function FrecuenciadePedido
(@id int)
	returns float
as
begin
	/*D/Q*/

	declare @Demanda int
	declare @N int

	set @Demanda = ((select avg(pm.cantidad) as Demanda
					from Producto p inner join Programa_Maestro pm 
					on (p.id_Producto = pm.id_Producto)) *52); 

	set @N = (select pm.semana from Programa_Maestro pm where pm.semana in(select max(pm.semana) from Programa_Maestro pm));
	
	declare @frecuencia float;
	
	set @frecuencia = round(((@Demanda)/(select dbo.Cantidades(@id))/52)*@N,2);
	
	return @frecuencia;
end

select dbo.FrecuenciadePedido(1)


alter function NumeroDePedidos
(@id int)
	returns float
as
begin
		declare @N int
		set @N = (select pm.semana from Programa_Maestro pm where pm.semana in(select max(pm.semana) from Programa_Maestro pm));

		declare @nPedidos float
		set @nPedidos = round((select dbo.FrecuenciadePedido(@id))/@N,2);

		return @nPedidos;
end

select dbo.NumeroDePedidos(1)