
drop database sistemaInventario

create database sistemaInventario

use sistemaInventario

create table Producto
(
	id_Producto int identity(1,1) primary key,
<<<<<<< HEAD
	nombre varchar(50),
	costoMantenimiento float,
	costoPedir float
=======
	nombre varchar(50)
>>>>>>> 143c9ea9bae5d6c0d8cf4cdfb06fcc71cead865f
);


create table Material
(
	id_Material int identity(1,1) primary key,
	descripcion varchar(100)  not null,
	disponible int not null,
	stock_seguridad int not null,
	tiempo_espera_pedido int not null
);

create table Lista_Material
(
	id_listaMateriale int identity(1,1) primary key,
	id_Producto int not null,
	id_Material int not null,
	Padre varchar(100) not null,
	nivel int not null,
	cantidad_Elaborar int not null
);


create table Recepciones_Programadas
(
	id_recepciones int identity(1,1) primary key,
	id_material int not null,
	semana int not null,
	cantidad int not null
);

create table Programa_Maestro
(
	id_Programa int identity(1,1) primary key,
	id_producto int not null,
	semana int not null,
	cantidad int not null
)


/*Relaciones*/

ALTER TABLE Lista_Material ADD FOREIGN KEY(id_Producto) REFERENCES Producto(id_Producto);

ALTER TABLE Lista_Material ADD FOREIGN KEY(id_material) REFERENCES Material(id_material);

ALTER TABLE Programa_Maestro ADD FOREIGN KEY(id_Producto) REFERENCES Producto(id_Producto);

ALTER TABLE Recepciones_Programadas ADD FOREIGN KEY(id_Material) REFERENCES Material(id_material);


















