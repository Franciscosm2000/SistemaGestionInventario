USE [master]
GO
/****** Object:  Database [sistemaInventario]    Script Date: 17/06/2020 14:29:42 ******/
CREATE DATABASE [sistemaInventario]
 GO
ALTER DATABASE [sistemaInventario] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sistemaInventario].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sistemaInventario] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sistemaInventario] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sistemaInventario] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sistemaInventario] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sistemaInventario] SET ARITHABORT OFF 
GO
ALTER DATABASE [sistemaInventario] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [sistemaInventario] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sistemaInventario] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sistemaInventario] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sistemaInventario] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sistemaInventario] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sistemaInventario] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sistemaInventario] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [sistemaInventario] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [sistemaInventario] SET  ENABLE_BROKER 
GO
ALTER DATABASE [sistemaInventario] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [sistemaInventario] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [sistemaInventario] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [sistemaInventario] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [sistemaInventario] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [sistemaInventario] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [sistemaInventario] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [sistemaInventario] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [sistemaInventario] SET  MULTI_USER 
GO
ALTER DATABASE [sistemaInventario] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [sistemaInventario] SET DB_CHAINING OFF 
GO
ALTER DATABASE [sistemaInventario] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [sistemaInventario] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [sistemaInventario] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [sistemaInventario] SET QUERY_STORE = OFF
GO
USE [sistemaInventario]
GO
/****** Object:  UserDefinedFunction [dbo].[Cantidades]    Script Date: 17/06/2020 14:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Cantidades]
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
GO
/****** Object:  UserDefinedFunction [dbo].[Disponibilidad]    Script Date: 17/06/2020 14:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Disponibilidad]
(@NecesidadesB int, @inventarioDA int,@recepcionesP int)	
returns int
as
begin
	 declare @dispo int
		set @dispo = (@inventarioDA + @recepcionesP - @NecesidadesB);
	
	 return @dispo;
end
GO
/****** Object:  UserDefinedFunction [dbo].[DisponiblePOQ]    Script Date: 17/06/2020 14:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[DisponiblePOQ]
(@idProducto int, @cont int)
returns int
as
begin
			declare @numeroPedidos int;
			declare @recepcionOrden int;
			set @recepcionOrden = 0;
			set @numeroPedidos =convert(int,dbo.NumeroDePedidos(1));
			declare @cont2 int;
			set @cont2 = 1;

			while(@cont2<=@numeroPedidos)
			begin
				if(@cont2 = 1)
				begin
					set @recepcionOrden = @recepcionOrden +(select pm.cantidad from Programa_Maestro pm where pm.id_producto = 1 and pm.id_Programa = @cont);
				end
				else
				begin
					set @recepcionOrden = @recepcionOrden + (select pm.cantidad from Programa_Maestro pm where pm.id_producto = @idProducto and pm.id_Programa = (@cont + 1));
				end
				set @cont2 = @cont2 + 1;
			end

			return @recepcionOrden;
end
GO
/****** Object:  UserDefinedFunction [dbo].[FrecuenciadePedido]    Script Date: 17/06/2020 14:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FrecuenciadePedido]
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
GO
/****** Object:  UserDefinedFunction [dbo].[NecesidadesNetas]    Script Date: 17/06/2020 14:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[NecesidadesNetas]
(@NecesidadesB int,@ss int, @inventarioDA int,@recepcionesP int)	
returns int
as
begin
	 declare @necesidades int
		set @necesidades = (@NecesidadesB + @ss - @inventarioDA - @recepcionesP);
	
	 return @necesidades;
end
GO
/****** Object:  UserDefinedFunction [dbo].[NumeroDePedidos]    Script Date: 17/06/2020 14:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[NumeroDePedidos]
(@id int)
	returns float
as
begin
		declare @N int
		set @N = (select pm.semana from Programa_Maestro pm where pm.semana in(select max(pm.semana) from Programa_Maestro pm));

		declare @nPedidos float
		set @nPedidos = round(@N/(select dbo.FrecuenciadePedido(1)),2);

		return @nPedidos;
end
GO
/****** Object:  Table [dbo].[AJFB]    Script Date: 17/06/2020 14:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AJFB](
	[IdAj] [int] IDENTITY(1,1) NOT NULL,
	[Demand] [int] NULL,
	[Dias] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdAj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Alexander]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alexander](
	[costo] [float] NULL,
	[Mantenimiento] [float] NULL,
	[Cf] [float] NULL,
	[Ccounts] [float] NULL,
	[Contrato] [float] NULL,
	[despido] [float] NULL,
	[Tnormal] [int] NULL,
	[Textra] [int] NULL,
	[Tunidad] [int] NULL,
	[InvInicial] [int] NULL,
	[ss] [int] NULL,
	[Flaboral] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lista_Material]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lista_Material](
	[id_listaMateriale] [int] IDENTITY(1,1) NOT NULL,
	[id_Producto] [int] NOT NULL,
	[id_Material] [int] NOT NULL,
	[Padre] [varchar](100) NOT NULL,
	[nivel] [int] NOT NULL,
	[cantidad_Elaborar] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_listaMateriale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Material]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Material](
	[id_Material] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
	[disponible] [int] NOT NULL,
	[stock_seguridad] [int] NOT NULL,
	[tiempo_espera_pedido] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[id_Producto] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[costoMantenimiento] [float] NULL,
	[costoPedir] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Programa_Maestro]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Programa_Maestro](
	[id_Programa] [int] IDENTITY(1,1) NOT NULL,
	[id_producto] [int] NOT NULL,
	[semana] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Programa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recepciones_Programadas]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recepciones_Programadas](
	[id_recepciones] [int] IDENTITY(1,1) NOT NULL,
	[id_material] [int] NOT NULL,
	[semana] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_recepciones] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TemporalLote]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemporalLote](
	[id] [int] NULL,
	[material] [varchar](100) NULL,
	[necesidadesBrutas] [int] NULL,
	[recepcionesProgramadas] [int] NULL,
	[disponible] [int] NULL,
	[necesidadesNetas] [int] NULL,
	[lanzamientoOrden] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[totales]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[totales](
	[total1] [float] NULL,
	[total2] [float] NULL,
	[total3] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Lista_Material]  WITH CHECK ADD FOREIGN KEY([id_Material])
REFERENCES [dbo].[Material] ([id_Material])
GO
ALTER TABLE [dbo].[Lista_Material]  WITH CHECK ADD FOREIGN KEY([id_Producto])
REFERENCES [dbo].[Producto] ([id_Producto])
GO
ALTER TABLE [dbo].[Programa_Maestro]  WITH CHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[Producto] ([id_Producto])
GO
ALTER TABLE [dbo].[Recepciones_Programadas]  WITH CHECK ADD FOREIGN KEY([id_material])
REFERENCES [dbo].[Material] ([id_Material])
GO
/****** Object:  StoredProcedure [dbo].[EstartegiaPersecucion]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create proc [dbo].[EstartegiaPersecucion]
	as
	begin
	create table #temporal(
		idTemporal int identity(1,1) primary key,
		Inventario int,
		Demanda int ,
		Stock int,
		Reqprod int ,
		InvFinal int ,
		repetida int,
		HorasReque int,
		HorasDisp int ,
		TrabReq int,
		ContratacionC int ,
		ContratacionM float,
		DespidoC int ,
		DespidoM float ,
		Tnormal int
	)
	declare @tr int;
	declare @tt int;
	set @tt=(select count(*) from AJFB);
	set @tr =1;
	declare @Co float;set @co=0;

	while(@tr<=@tt)
	begin

		/*Complementos*/
		declare @pp float;
		declare @pe float;
		set @pe=Convert(float,(select ss from Alexander));
		set @pp=@pe/100.0;



		/*Necesarias*/
		declare @IIn int;declare @Dem int;declare @st int;declare @req int;
		/*Seguiria invFinal..pero eso es lo mismo del stock*/
		declare @Hreq float;declare @HDisp float;

		Set @st=(Select Demand*@pp from AJFB where IdAj=@tr);
		Set @Dem=(Select Demand from AJFB where IdAj=@tr);
			if (@tr=1)
			begin
				set @IIn =(Select InvInicial from Alexander);
			end
			else
			begin
				set @IIn=(select Stock from #temporal where idTemporal=@tr-1);
			end		
		set @req=@Dem-@IIn+@st;
		set @Hreq=(select a.Tunidad*@req from Alexander a);
		set @HDisp=(Select Dias*8 from AJFB where IdAj=@tr);
		
		declare @trb float;set @trb=(@Hreq)/(@HDisp);/*Esto es el trabReque problema division*/

		declare @cont int;set @cont=0;
		declare @desp int;set @desp=0;

		/*contratos cantidad*/
		if(@tr=1)
		begin
			set @cont=((CEILING(@trb))-(Select a.Flaboral from Alexander a));
			if(@cont<=0)
			begin
				set @cont=0;
			end
		end
		else
		begin
			set @cont=(CEILING(@trb)-(Select a.TrabReq from #temporal a where idTemporal=@tr-1));
				if(@cont<0)
				begin
					set @cont=0;
				end
		end

		/*Contrato dinero*/
		declare @conM float;
		set @conM=(select a.Contrato*@cont from Alexander a);
		set @Co=@Co+@conm;

		/*Despidos Cantidad*/

		if(@tr=1)
		begin
				set @desp=((select a.Flaboral from Alexander a)-CEILING(@trb));
				if(@desp<=0)
				begin
					set @desp=0;
				end
		end
		else
		begin
				set @desp=((select a.TrabReq from #temporal a where idTemporal=@tr-1)-CEILING(@trb));
				if(@desp<=0)
				begin
					set @desp=0;
				end
		end

		/*Despidos dinero*/
		declare @despM float;
		set @despM=(select a.despido*@desp from Alexander a);
		set @Co=@Co+@despM;

		/*TNormal*/
		declare @Norm int;
		set @Norm=(select a.Tnormal*@Hreq from Alexander a);
		Set @Co=@Co+@Norm;

		/*------------------------------------*/
		Insert into #temporal(Inventario,Demanda,Stock,Reqprod,InvFinal,repetida,HorasReque
		,HorasDisp,TrabReq,ContratacionC,ContratacionM,DespidoC,DespidoM,Tnormal) 
		values (@IIn,@Dem,@st,@req,@st,@req,@Hreq,@HDisp,CEILING(@trb),@cont,@conM,@desp,@despM,@Norm);

		SET @tr=@tr+1;
	end		
	update totales set total1=@Co;
	Select* from #temporal;
	drop table #temporal;
	


end
GO
/****** Object:  StoredProcedure [dbo].[FuerzaNivelada]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create proc [dbo].[FuerzaNivelada]
	as
	begin
		create table #temporal(
		idTemporal int identity(1,1) primary key,
		ProducReq int,
		HorasRequeridas int ,
		Stock int,
	)

	declare @tr int;set @tr =1;
	declare @tt int;set @tt=(select count(*) from AJFB);

	declare @pp float;
	declare @pe float;
	set @pe=Convert(float,(select ss from Alexander));
	set @pp=@pe/100.0;
	Declare @Dem int;Declare @st int;Declare @IIn int;Declare @req int;
	Declare @Hreq int;
	while(@tr<=@tt)
		begin
			
			Set @Dem=(Select Demand from AJFB where IdAj=@tr);
			Set @st=(Select Demand*@pp from AJFB where IdAj=@tr);
				if (@tr=1)
				begin
					set @IIn =(Select InvInicial from Alexander);
				end
				else
				begin
					set @IIn=(select Stock from #temporal where idTemporal=@tr-1);
				end		
			set @req=@Dem-@IIn+@st;

			set @Hreq=@req*(Select a.Tunidad from Alexander a);

			insert into #temporal(ProducReq,HorasRequeridas,Stock) 
			values(@req,@Hreq,@st);
			SET @tr=@tr+1;
		end

	--encontrar los trabajadores necesarios.
	------------------------------------------
	Declare @hp float;
	set @hp=(Select a.ProducReq*(select a.Tunidad from Alexander a) from #temporal a where a.idTemporal=(select top 1 (a.IdAj) from AJFB a order by Demand asc));
	Declare @hpa float;
	set @hpa=(select top 1 (a.Dias)*8 from AJFB a order by Demand asc);
	declare @hpeo int;
	set @hpeo=(@hp)/(@hpa);

	
	Set @tr=1;

	Create table #temp(
	idtemp int primary key identity(1,1),
	HorasReq int ,
	ProductReal int,
	Faltante int ,
	CostoSub int,
	Tnormal int
	)

	declare @total float;set @total=0;
	Declare @h1 int;
	Declare @pre int;
	declare @falt int;
	declare @csub float;
	declare @nor int;
	while(@tr<=@tt)
		begin
			set @h1=@hpeo*8*(select a.Dias from AJFB a where IdAj=@tr);
			set @pre=@h1/(select a.Tunidad from Alexander a);
			set @falt=(select a.ProducReq-@pre from #temporal a where a.idTemporal=@tr);
			set @csub=(select (a.Ccounts-a.costo)*@falt from Alexander a);
			set @nor=(select (a.HorasRequeridas)*(select a.Tnormal from Alexander a) from #temporal a where a.idTemporal=@tr);
			set @total=@total+@csub+@nor

			insert into #temp(HorasReq,ProductReal,Faltante,CostoSub,Tnormal) values(@h1,@pre,@falt,@csub,@nor)
			set @tr=@tr+1;
		end

	update totales set total3=@total; 
	Select * from #temp
	drop table #temp
	drop table #temporal
	end
GO
/****** Object:  StoredProcedure [dbo].[InventarioAjustado]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create proc [dbo].[InventarioAjustado]
	as
	begin
		create table #temporal(
			idTemporal int identity(1,1) primary key,
			ProducReq int,
			HorasReque int ,
			Stock int,
			HorasDisp int,
			ProducReal int ,
			InvInicial int ,
			Demanda int,
			InvFinal int,
			CostFaltante float ,
			CostMante float,
			Tnormal int
		)
		declare @tr int;
		declare @tt int;
		set @tt=(select count(*) from AJFB);
		set @tr =1;

		declare @req int;
		declare @IIn int;
		declare @Dem int;
		declare @st int;
		declare @pp float;
		declare @pe float;
			set @pe=Convert(float,(select ss from Alexander));
			set @pp=@pe/100.0;

		declare @Hreq int;
		declare @Hdisp int;
		declare @PReal int;
		declare @dm int;
		declare @If int;
		declare @Cfal float;
		declare @hm float;
		declare @tot int;
		declare @total float;
			set @total=0;

		declare @trabR int;

		declare @THoras int;
		set @THoras=(Select Sum(a.Demand)*(select b.Tunidad from Alexander b) from AJFB a);

		set @trabR=Ceiling(@THoras/(select sum(a.Dias)*8 from AJFB a));

		while(@tr<=@tt)
		begin	
		
			Set @Dem=(Select Demand from AJFB where IdAj=@tr);
			Set @st=(Select Demand*@pp from AJFB where IdAj=@tr);
				if (@tr=1)
				begin
					set @IIn =(Select InvInicial from Alexander);
				end
				else
				begin
					set @IIn=(select Stock from #temporal where idTemporal=@tr-1);
				end		
			set @req=@Dem-@IIn+@st;

			/*Horas requeridas*/
			set @Hreq=@req*(Select a.Tunidad from Alexander a);
			set @Hdisp=(@trabR*8*(select a.Dias from AJFB a where a.IdAj=@tr));
			set @PReal=CEILING(@Hdisp/(select a.Tunidad From Alexander a));

			if(@tr=1)
			begin
				set @IIn =(Select InvInicial from Alexander);
			end
			else
			begin
				set @IIn=(select InvFinal from #temporal where idTemporal=@tr-1);
				if(@IIn<=0)
				begin
					set @IIn=0;
				end
			end

			if(@tr=@tt)
			begin
				set @If=(Select a.InvInicial from Alexander a);
			end
			else
			begin
				if(@tr=1)
				begin
					set @If=@PReal-@Dem+@IIn;
				end
				else
				begin
				set @If=@PReal-@Dem+(Select InvFinal from #temporal where idTemporal=@tr-1);
				end
			end
			
			if(@If<=0)
			begin
				set @Cfal=((-1)*@If)*(select a.Cf from Alexander a);
			end
			else
			begin
				set @Cfal=0;
			end

			if(@If>0)
			begin
				set @hm=(select a.Mantenimiento*@If from Alexander a);
			end
			else
			begin
				set @hm=0;
			end

			set @tot=(select a.Tnormal*@Hdisp from Alexander a);
			set @total=@total+@Cfal+@hm+@tot;
			

			insert into #temporal(ProducReq,HorasReque,Stock,HorasDisp,ProducReal,InvInicial,Demanda,InvFinal,CostFaltante,CostMante,Tnormal) 
			values(@req,@Hreq,@st,@Hdisp,@PReal,@IIn,@Dem,@If,@Cfal,@hm,@tot);
			SET @tr=@tr+1;
		end
	

		update totales set total2=@total;
		Select * from #temporal;
		drop table #temporal;
end
GO
/****** Object:  StoredProcedure [dbo].[lotePorlote]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[lotePorlote]
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
	set @cantidadSemana =( select pm.semana from Programa_Maestro pm where pm.semana in(select max(pm.semana) from Programa_Maestro pm));
 
 
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

		update #Temporal set lanzamientoOrden = 0 where lanzamientoOrden is null;

		select *from #Temporal

		SET @cont1=@cont1+1;
		set @cont = 1;

	drop table #Temporal
GO
/****** Object:  StoredProcedure [dbo].[lotePorloteCompleto]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[lotePorloteCompleto]
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

			insert into  TemporalLote
			 select *from #Temporal;

			drop table #Temporal --elimacion de tabla temporal

			set @idMaterial = @idMaterial + 1;
		end
			drop table #aux;
			--select *from #Ordenes
			drop table #Ordenes
GO
/****** Object:  StoredProcedure [dbo].[MetodoEOQ]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[MetodoEOQ]
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
GO
/****** Object:  StoredProcedure [dbo].[MetodoPOQ]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[MetodoPOQ]
@idProducto int
as	

	declare @cantidadPedios int;
	set @cantidadPedios = convert(int,(select dbo.NumeroDePedidos(@idProducto)));


	create table #Temporal
		(
			id int identity (1,1) primary key,
			necesidadesBrutas int,
			recepcionesProgramadas int,
			disponible int,
			necesidadesNetas int,
			recepcionOrden int,
			lanzamientoOrden int,
		)

	
		declare @cont int
		set @cont = 1;
		declare @cantidadSemana int;

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

-------------------------------------------Inventario Disponible
				if(@cont = 1)
				begin
					set @dispo = (select lm.disponible from Material lm where lm.id_Material = @idProducto);
				end --Fin if

				else
				begin
										/*necesidades netas -recepcion de orden*/
					declare @NecesidadesD int;
					declare @recepcionOrdenD int;

					set @NecesidadesD = (select t.necesidadesNetas from #Temporal t where t.id = (@cont - 1));
					set @recepcionOrdenD = (select t.recepcionOrden from #Temporal t where t.id = (@cont - 1));

					set @dispo = @recepcionOrdenD - @NecesidadesD  ;

				end --Fin else
-------------------------------------------Necesidades Netas
				
				set @necesidadesN = (@necesidadesB - @dispo);
	
-------------------------------------------Recepcion Orden

			declare @recepcionOrden int;



			if(@cont = 1)
			begin
				set @recepcionOrden = (select dbo.DisponiblePOQ(@idProducto,@cont));
			end
			else
			begin
				if(@cantidadPedios%2=0 )
				begin
					if(@cont%2=0)
					begin
						set @recepcionOrden = (select dbo.DisponiblePOQ(@idProducto,(@cont+1)));
					end
				end 

				else 
				begin
					if(@cont%2 != 0)
					begin
						set @recepcionOrden = (select dbo.DisponiblePOQ(@idProducto,(@cont+1)));
					end
					
				end
			end
			
				insert into #Temporal (necesidadesBrutas,recepcionesProgramadas,disponible,necesidadesNetas,recepcionOrden)
				 values (@necesidadesB,@recepcionesP,@dispo,@necesidadesN,@recepcionOrden);
				 				
				if(@cantidadPedios%2=0 )
				begin
					if(@cont%2=0)
					begin
						update #Temporal set recepcionOrden = 0 where id = @cont;
						update #Temporal set lanzamientoOrden = @recepcionOrden where id = @cont;
					end
				end 
				else 
				begin
					if(@cont%2 != 0)
					begin
						update #Temporal set recepcionOrden = @recepcionOrden  where id = @cont;
						update #Temporal set lanzamientoOrden = 0 where id=@cont;
					end
					
				end				
				

			set @cont = @cont + 1;
		end---Fin del while

		update #Temporal set lanzamientoOrden = 0 where lanzamientoOrden is null;

		select *from #Temporal;
		drop table #Temporal;
GO
/****** Object:  StoredProcedure [dbo].[Modelo_p1]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Modelo_p1]
as
select
lm.id_listaMateriale as [LOTE],
lm.Padre as[Material],
lm.cantidad_Elaborar as [Cantidad]
from Lista_Material lm 
group by lm.id_listaMateriale, lm.Padre, lm.cantidad_Elaborar
order by lm.id_listaMateriale asc
GO
/****** Object:  StoredProcedure [dbo].[Modelo_p2]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*mis datos P*/
create procedure [dbo].[Modelo_p2]
as
SELECT lm.Padre as [Material], 
SUM(lm.cantidad_Elaborar) AS [Cantidad]
FROM Lista_Material lm
GROUP BY lm.Padre
GO
/****** Object:  StoredProcedure [dbo].[Modelo_q1]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Modelo_q1]
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
GO
/****** Object:  StoredProcedure [dbo].[Modelo_q2]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Modelo_q2]
as
SELECT lm.Padre as [Material], 
SUM(lm.cantidad_Elaborar) AS [Cantidad],
sum(sum(lm.cantidad_Elaborar)) over (order by lm.Padre asc) as [Total Acumulado],
(round((100 * count(lm.cantidad_Elaborar)/ sum(lm.cantidad_Elaborar)),2)) as [Porcentaje]
FROM Lista_Material lm
GROUP BY lm.Padre
GO
/****** Object:  StoredProcedure [dbo].[mostrarDatosAlexander]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[mostrarDatosAlexander]
as
	select *from Alexander;
GO
/****** Object:  StoredProcedure [dbo].[MostrarTablaCompletaLote]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[MostrarTablaCompletaLote]
as
	exec  lotePorloteCompleto 1

			update TemporalLote set necesidadesBrutas = 0  where necesidadesBrutas is null;
			update TemporalLote set recepcionesProgramadas = 0  where necesidadesBrutas is null;
			update TemporalLote set disponible = 0  where necesidadesBrutas is null;
			update TemporalLote set necesidadesNetas = 0  where necesidadesBrutas is null;
			update TemporalLote set lanzamientoOrden = 0  where necesidadesBrutas is null;

	select material as Material,
	necesidadesBrutas as [Necesidades Brutas],
	recepcionesProgramadas as [Recepciones Programadas],
	disponible as [Disponible],
	necesidadesNetas as [Necesidades Netas],
	lanzamientoOrden as [Lanzamiento de Orden] from TemporalLote;

	delete TemporalLote;
GO
/****** Object:  StoredProcedure [dbo].[ProgramaMaestro]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ProgramaMaestro]
as
select p.nombre as Nombre, pm.semana as Semana, pm.cantidad as Cantidad
from Producto p inner join Programa_Maestro pm 
on (p.id_Producto = pm.id_Producto);
GO
/****** Object:  StoredProcedure [dbo].[Registro_inventario]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Registro Inventario*/
create proc [dbo].[Registro_inventario]
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
GO
/****** Object:  StoredProcedure [dbo].[tablaCosto]    Script Date: 17/06/2020 14:29:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[tablaCosto]
as
	create table #Costo
	(
		id int primary key identity(1,1),
		modelo varchar(100),
		costoMatener float,
		costoOrdenar float,
		costoTotal float
	)

		create table #LxL
	(
			id int,
			necesidadesBrutas int,
			recepcionesProgramadas int,
			disponible int,
			necesidadesNetas int,
			recepcionOrden int,
			lanzamientoOrden int,
	)

	create table #EOQ
	(
			id int,
			necesidadesBrutas int,
			recepcionesProgramadas int,
			disponible int,
			necesidadesNetas int,
			lanzamientoOrden int,
	)

	create table #POQ
	(
			id int ,
			necesidadesBrutas int,
			recepcionesProgramadas int,
			disponible int,
			necesidadesNetas int,
			recepcionOrden int,
			lanzamientoOrden int,
	)

	---Llenado de tablas

	insert into #LxL(id,necesidadesBrutas , recepcionesProgramadas, disponible , necesidadesNetas ,recepcionOrden,lanzamientoOrden)
	exec lotePorlote 1;

	insert into #EOQ (id,necesidadesBrutas , recepcionesProgramadas, disponible , necesidadesNetas ,lanzamientoOrden)
	exec MetodoEOQ 1;

	insert into #POQ (id,necesidadesBrutas , recepcionesProgramadas, disponible , necesidadesNetas , recepcionOrden,lanzamientoOrden)
	exec MetodoPOQ 1;

	---Impresion de tabla
	
	declare @costoM int;
	declare @costoO int;

	set @costoM = (select p.costoMantenimiento from Producto p  where p.id_Producto = 1)
	set @costoO = (select p.costoPedir from Producto p  where p.id_Producto = 1)

	--tabla lxl
	declare @costoMantenerlxl int;
	declare @costoOrdenlxl int;
	declare @costoTotallxl int;

	set @costoMantenerlxl = (select SUM((e.disponible*0.5)) from #LxL e)
	set @costoOrdenlxl =(select SUM(@costoO) from #LxL e where e.lanzamientoOrden  is not null and e.lanzamientoOrden > 0);
	set @costoTotallxl = @costoMantenerlxl + @costoOrdenlxl;

		insert into #Costo values ('Metodo LXL',@costoMantenerlxl,@costoOrdenlxl,@costoTotallxl);

	---tabla eoq
	declare @costoMantenerEOQ int;
	declare @costoOrdenEOQ int;
	declare @costoTotalEOQ int;

	set @costoMantenerEOQ = (select SUM((e.disponible*0.5)) from #EOQ e)
	set @costoOrdenEOQ =(select SUM(@costoO) from #EOQ e where e.lanzamientoOrden  is not null and e.lanzamientoOrden > 0);
	set @costoTotalEOQ = @costoMantenerEOQ + @costoOrdenEOQ;

		insert into #Costo values ('Metodo EOQ',@costoMantenerEOQ,@costoOrdenEOQ,@costoTotalEOQ);

	---tabla poq
	declare @costoMantenerPOQ int;
	declare @costoOrdenPOQ int;
	declare @costoTotalPOQ int;

	set @costoMantenerPOQ = (select SUM(e.disponible * 0.5) from #POQ e)
	set @costoOrdenPOQ = (select SUM(@costoO) from #POQ e where e.lanzamientoOrden is not null and e.lanzamientoOrden > 0);
	set @costoTotalPOQ = @costoMantenerPOQ + @costoOrdenPOQ;

		insert into #Costo values ('Metodo POQ',@costoMantenerPOQ,@costoOrdenPOQ,@costoTotalPOQ);


	select *from #Costo;
	---Elimados de tablas
	drop table #EOQ;
	drop table #POQ;
	drop table #Costo;
GO
USE [master]
GO
ALTER DATABASE [sistemaInventario] SET  READ_WRITE 
GO
