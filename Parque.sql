--

CREATE DATABASE ParqueVehicularDB

USE ParqueVehicularDB

CREATE TABLE ParqueVehicular_Normalizada(
	id int primary key identity(1,1),
	tipo_placa text,
	anio_de_fabricacion text,
	cilindrada text,
	cantidad_de_cilindros text,
	cantidad_de_puertas text,
	valor_del_vehiculo text,
	colores text,
	fecha_de_importacion text,
	imp_valor_del_vehiculo text,
	fecha_de_ingreso text,
	anio_ingreso text,
	mes_ingreso text,
	clase text,
	pertenencia text,
	marca text,
	modelo text,
	capacidad text,
	des_capacidad text,
	combustible text,
	aduana text,
	condicion_ingreso text,
	propietario_departamento text,
	propietario_municipio text,
	estado text
)

DROP TABLE ParqueVehicular_Normalizada

SELECT TOP 10 * FROM ParqueVehicular_Normalizada