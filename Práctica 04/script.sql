/*
* @Authors:
 *           Jorge Acevedo
 *           Javier Martín
 *           Sergio Tabares
 *           Adrián Epifanio
*
* @Date:   2021-10-29 15:59:49
* @Last Modified time: 2021-11-01 16:33:21
*/
-- MySQL Script generated by MySQL Workbench
-- Fri Oct  29 15:59:49 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering



DROP TABLE IF EXISTS ClienteCompraEmpleadoProducto ;
DROP TABLE IF EXISTS Producto ;
DROP TABLE IF EXISTS Empleado ;
DROP TABLE IF EXISTS EmpleadoTrabajaZona ;
DROP TABLE IF EXISTS Cliente ;
DROP TABLE IF EXISTS Zona ;
DROP TABLE IF EXISTS Vivero ;



/*===============================================================================
=                                   Vivero                                      =
===============================================================================*/
-- --------------------------------------
-- Table Vivero
-- --------------------------------------
DROP TABLE IF EXISTS Vivero ;
CREATE TABLE IF NOT EXISTS Vivero (
  Nombre VARCHAR(30) NOT NULL,
  Latitud DECIMAL NULL,
  Longitud DECIMAL NULL,
  Localidad VARCHAR(45) NULL,
  PRIMARY KEY (Nombre));

-- --------------------------------------
-- Data for table Vivero
-- --------------------------------------
INSERT INTO Vivero (Nombre, Latitud, Longitud, Localidad) VALUES ('Vivero La Laguna', 5, 21, 'La Laguna');
INSERT INTO Vivero (Nombre, Latitud, Longitud, Localidad) VALUES ('Vivero Santa Cruz', 14, 74, 'Santa Cruz de Tenerife');



/*===============================================================================
=                                   Zona                                        =
===============================================================================*/
-- --------------------------------------
-- Table Zona
-- --------------------------------------
DROP TABLE IF EXISTS Zona ;
CREATE TABLE IF NOT EXISTS Zona (
  Codigo INT NOT NULL,
  Nombre VARCHAR(50) NOT NULL,
  Vivero_Nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (Codigo),
  UNIQUE (Codigo),
  CONSTRAINT fk_Zona_Vivero
    FOREIGN KEY (Vivero_Nombre)
    REFERENCES Vivero (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- --------------------------------------
-- Data for table Zona
-- --------------------------------------
INSERT INTO Zona (Codigo, Nombre, Vivero_Nombre) VALUES (0101, 'Almacén', 'Vivero La Laguna');
INSERT INTO Zona (Codigo, Nombre, Vivero_Nombre) VALUES (0102, 'Cajas', 'Vivero La Laguna');
INSERT INTO Zona (Codigo, Nombre, Vivero_Nombre) VALUES (0103, 'Exterior', 'Vivero La Laguna');
INSERT INTO Zona (Codigo, Nombre, Vivero_Nombre) VALUES (0203, 'Exterior', 'Vivero Santa Cruz');
INSERT INTO Zona (Codigo, Nombre, Vivero_Nombre) VALUES (0202, 'Cajas', 'Vivero Santa Cruz');
INSERT INTO Zona (Codigo, Nombre, Vivero_Nombre) VALUES (0201, 'Almacén', 'Vivero Santa Cruz');



/*===============================================================================
=                                   Cliente                                     =
===============================================================================*/
-- --------------------------------------
-- Table Cliente
-- --------------------------------------
DROP TABLE IF EXISTS Cliente ;
CREATE TABLE IF NOT EXISTS Cliente (
  DNI VARCHAR(9) NOT NULL,
  Bonificacion DECIMAL NULL,
  Total_mensual DECIMAL NULL,
  PRIMARY KEY (DNI));

-- --------------------------------------
-- Data for table Cliente
-- --------------------------------------
INSERT INTO Cliente (DNI, Bonificacion, Total_mensual) VALUES ('23456789A', NULL, NULL);
INSERT INTO Cliente (DNI, Bonificacion, Total_mensual) VALUES ('23456789B', NULL, NULL);



/*===============================================================================
=                             EmpleadoTrabajaZona                               =
===============================================================================*/
-- --------------------------------------
-- Table EmpleadoTrabajaZona
-- --------------------------------------
DROP TABLE IF EXISTS EmpleadoTrabajaZona ;
CREATE TABLE IF NOT EXISTS EmpleadoTrabajaZona (
  Fecha_Inicio DATE NOT NULL,
  Fecha_Fin DATE NOT NULL,
  Ventas INT NULL,
  Zona_Codigo INT NOT NULL,
  PRIMARY KEY (Fecha_Inicio, Zona_Codigo),
  CONSTRAINT fk_EmpleadoTrabajaZona_Zona
    FOREIGN KEY (Zona_Codigo)
    REFERENCES Zona (Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- --------------------------------------
-- Data for table EmpleadoTrabajaZona
-- --------------------------------------
INSERT INTO EmpleadoTrabajaZona (Fecha_Inicio, Fecha_Fin, Ventas, Zona_Codigo) VALUES ('01/01/2019', '01/01/2021', NULL, 0101);
INSERT INTO EmpleadoTrabajaZona (Fecha_Inicio, Fecha_Fin, Ventas, Zona_Codigo) VALUES ('03/01/2020', '03/01/2021', NULL, 0102);
INSERT INTO EmpleadoTrabajaZona (Fecha_Inicio, Fecha_Fin, Ventas, Zona_Codigo) VALUES ('02/01/2017', '02/01/2021', NULL, 0203);



/*===============================================================================
=                                   Empleado                                    =
===============================================================================*/
-- --------------------------------------
-- Table Empleado
-- --------------------------------------
DROP TABLE IF EXISTS Empleado ;
CREATE TABLE IF NOT EXISTS Empleado (
  Css VARCHAR(45) NOT NULL,
  Sueldo DECIMAL NOT NULL,
  Antiguedad INT NOT NULL,
  DNI VARCHAR(9) NOT NULL,
  EmpleadoTrabajaZona_Fecha_Inicio DATE NOT NULL,
  EmpleadoTrabajaZona_Zona_Codigo INT NOT NULL,
  PRIMARY KEY (DNI),
  CONSTRAINT fk_Empleado_EmpleadoTrabajaZona
    FOREIGN KEY (EmpleadoTrabajaZona_Fecha_Inicio , EmpleadoTrabajaZona_Zona_Codigo)
    REFERENCES EmpleadoTrabajaZona (Fecha_Inicio , Zona_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- --------------------------------------
-- Data for table Empleado
-- --------------------------------------
INSERT INTO Empleado (Css, Sueldo, Antiguedad, DNI, EmpleadoTrabajaZona_Fecha_Inicio, EmpleadoTrabajaZona_Zona_Codigo) VALUES ('XXXX123456789012', 1200, 2, '12345678A', '01/01/2019', 0101);
INSERT INTO Empleado (Css, Sueldo, Antiguedad, DNI, EmpleadoTrabajaZona_Fecha_Inicio, EmpleadoTrabajaZona_Zona_Codigo) VALUES ('XXXZ123456789012', 1150, 1, '12345678B', '03/01/2020', 0102);
INSERT INTO Empleado (Css, Sueldo, Antiguedad, DNI, EmpleadoTrabajaZona_Fecha_Inicio, EmpleadoTrabajaZona_Zona_Codigo) VALUES ('XXXY123456789012', 1300, 4, '12345678C', '02/01/2017', 0203);



/*===============================================================================
=                                   Producto                                    =
===============================================================================*/
-- --------------------------------------
-- Table Producto
-- --------------------------------------
DROP TABLE IF EXISTS Producto ;
CREATE TABLE IF NOT EXISTS Producto (
  Codigo_Producto INT NOT NULL,
  Precio DECIMAL NOT NULL,
  Stock INT NULL,
  Zona_Codigo INT NOT NULL,
  PRIMARY KEY (Codigo_Producto, Zona_Codigo),
  CONSTRAINT fk_Producto_Zona
    FOREIGN KEY (Zona_Codigo)
    REFERENCES Zona (Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- --------------------------------------
-- Data for table Producto
-- --------------------------------------
INSERT INTO Producto (Codigo_Producto, Precio, Stock, Zona_Codigo) VALUES (0001, 15.99, NULL, 0101);
INSERT INTO Producto (Codigo_Producto, Precio, Stock, Zona_Codigo) VALUES (0002, 12.36, NULL, 0101);
INSERT INTO Producto (Codigo_Producto, Precio, Stock, Zona_Codigo) VALUES (0003, 9.45, NULL, 0202);
INSERT INTO Producto (Codigo_Producto, Precio, Stock, Zona_Codigo) VALUES (0004, 2.36, NULL, 0203);



/*===============================================================================
=                       ClienteCompraEmpleadoProducto                           =
===============================================================================*/
-- --------------------------------------
-- Table ClienteCompraEmpleadoProducto
-- --------------------------------------
DROP TABLE IF EXISTS ClienteCompraEmpleadoProducto ;
CREATE TABLE IF NOT EXISTS ClienteCompraEmpleadoProducto (
  Cantidad INT NOT NULL,
  Fecha DATE NOT NULL,
  Empleado_DNI VARCHAR(9) NOT NULL,
  Producto_Codigo_Producto INT NOT NULL,
  Producto_Zona_Codigo INT NOT NULL,
  Cliente_DNI VARCHAR(9) NOT NULL,
  PRIMARY KEY (Fecha, Empleado_DNI, Producto_Codigo_Producto, Producto_Zona_Codigo, Cliente_DNI),
  CONSTRAINT fk_ClienteCompraEmpleadoProducto_Empleado
    FOREIGN KEY (Empleado_DNI)
    REFERENCES Empleado (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ClienteCompraEmpleadoProducto_Producto
    FOREIGN KEY (Producto_Codigo_Producto , Producto_Zona_Codigo)
    REFERENCES Producto (Codigo_Producto , Zona_Codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ClienteCompraEmpleadoProducto_Cliente
    FOREIGN KEY (Cliente_DNI)
    REFERENCES Cliente (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- --------------------------------------
-- Data for table ClienteCompraEmpleadoProducto
-- --------------------------------------
INSERT INTO ClienteCompraEmpleadoProducto (Cantidad, Fecha, Empleado_DNI, Producto_Codigo_Producto, Producto_Zona_Codigo, Cliente_DNI) VALUES (2, '04/04/2020', '12345678A', 0001, 0101, '23456789A');



SELECT * FROM Vivero;
SELECT * FROM Zona;
SELECT * FROM EmpleadoTrabajaZona;
SELECT * FROM Cliente;
SELECT * FROM Producto;
/* Tablas grandes (extender terminal para ver completas)
SELECT * FROM Empleado;
SELECT * FROM ClienteCompraEmpleadoProducto;
*/
