/*LLenar datos Productos*/

insert into Producto values ('Cama Matrimonial');


/*datos materiales*/
insert into material values ('Cama Matrimonial',135,0,1);
insert into Material values ('Base', 37,8,1);
insert into Material values ('Tabla', 210,0,1);
insert into Material values ('Cabecera', 208,0,1);
insert into Material values ('Tablon de apoyo', 30,0,1);
insert into Material values ('Larguero', 180,0,1);
insert into Material values ('Tornillo', 1530,0,1);
insert into Material values ('Arandela', 2100,0,1);
insert into Material values ('Tablon superior', 35,10,1);
insert into Material values ('Forro Superior', 51,0,1);
insert into Material values ('Tablon Inferior', 75,0,1);
insert into Material values ('Forro Inferior', 25,0,1);

select *from Material

/*Lista de materiales*/

insert into Lista_Material values(1,1,'cama matrimonial',1,1);
insert into Lista_Material values(1,2,'cama matrimonial',1,1);
insert into Lista_Material values(1,3,'cama matrimonial',1,9);
insert into Lista_Material values(1,4,'base',2,1);
insert into Lista_Material values(1,5,'base',2,1);
insert into Lista_Material values(1,6,'base',2,2);
insert into Lista_Material values(1,7,'base',2,8);
insert into Lista_Material values(1,8,'base',2,8);
insert into Lista_Material values(1,9,'cabecera',3,1);
insert into Lista_Material values(1,10,'cabecera',3,1);
insert into Lista_Material values(1,11,'tablon de apoyo',3,1);
insert into Lista_Material values(1,12,'tablon de apoyo',3,1);

select *from Lista_Material
/*Recepciones Programadas*/

insert into Recepciones_Programadas values(1,0,0);
insert into Recepciones_Programadas values(2,3,5);
insert into Recepciones_Programadas values(3,0,0);
insert into Recepciones_Programadas values(4,0,0);
insert into Recepciones_Programadas values(5,1,20);
insert into Recepciones_Programadas values(6,0,0);
insert into Recepciones_Programadas values(7,0,0);
insert into Recepciones_Programadas values(8,4,5);
insert into Recepciones_Programadas values(9,0,0);
insert into Recepciones_Programadas values(10,0,0);
insert into Recepciones_Programadas values(11,0,0);

select *from Recepciones_Programadas

/*Programa Maestro*/

insert into Programa_Maestro values (1,1,90);
insert into Programa_Maestro values (1,2,148);
insert into Programa_Maestro values (1,3,210);
insert into Programa_Maestro values (1,4,120);




