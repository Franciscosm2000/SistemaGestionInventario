--Tablas que Ocupa Alexander
Use sistemaInventario;

create table AJFB(
	IdAj int primary key identity(1,1),
	Demand int,
	Dias int
)

Create table Alexander(
	costo float,
	Mantenimiento float,
	Cf float,
	Ccounts float,
	Contrato float,
	despido float,
	Tnormal int,
	Textra int,
	Tunidad int,
	InvInicial int,
	ss int,
	Flaboral int
)

--Estrategia de Persecucion
	Alter proc [EstartegiaPersecucion]
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

	select @Co;
	Select* from #temporal;
	drop table #temporal;
	


end
--Ejercutar Estrategia de persecucion
	exec EstartegiaPersecucion
--------------------------------------------------------------------------------------------------------
--Inventario Ajustado
	Alter proc InventarioAjustado
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
	

		select @total;
		Select * from #temporal;
		drop table #temporal;
end
--Ejecutar Inventario Ajustado
exec InventarioAjustado
---------------------------------------------------------------------------------------------------------
--Fuerza Nivelada
	Alter proc FuerzaNivelada
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

	select @total;
	Select * from #temp
	drop table #temp
	drop table #temporal
	end
--Ejecutar Fuerza nivelada
exec FuerzaNivelada