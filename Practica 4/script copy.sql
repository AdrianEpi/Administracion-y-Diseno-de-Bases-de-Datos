-- MySQL Script generated by MySQL Workbench
-- Tue 02 Nov 2021 10:33:04 PM WET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8 ;
USE mydb ;

-- -----------------------------------------------------
-- Table Vivero
-- -----------------------------------------------------
DROP TABLE IF EXISTS Vivero ;

CREATE TABLE IF NOT EXISTS Vivero (
  Nombre VARCHAR(30) NOT NULL,
  Latitud DECIMAL NULL,
  Longitud DECIMAL NULL,
  Localidad VARCHAR(45) NULL,
  PRIMARY KEY (Nombre))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Zona
-- -----------------------------------------------------
DROP TABLE IF EXISTS Zona ;

CREATE TABLE IF NOT EXISTS Zona (
  Nombre VARCHAR(50) NOT NULL,
  Vivero_Nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (Nombre, Vivero_Nombre),
  CONSTRAINT fk_Zona_Vivero1
    FOREIGN KEY (Vivero_Nombre)
    REFERENCES Vivero (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table EmpleadoTrabajaZona
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table Empleado
-- -----------------------------------------------------
DROP TABLE IF EXISTS Empleado ;

CREATE TABLE IF NOT EXISTS Empleado (
  Css VARCHAR(45) NOT NULL,
  Sueldo DECIMAL NOT NULL,
  Antiguedad INT NOT NULL,
  DNI VARCHAR(9) NOT NULL,
  EmpleadoTrabajaZona_Fecha_Inicio DATE NOT NULL,
  EmpleadoTrabajaZona_Zona_Nombre VARCHAR(50) NOT NULL,
  EmpleadoTrabajaZona_Zona_Vivero_Nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (DNI),
  INDEX fk_Empleado_EmpleadoTrabajaZona1_idx (EmpleadoTrabajaZona_Fecha_Inicio ASC, EmpleadoTrabajaZona_Zona_Nombre ASC, EmpleadoTrabajaZona_Zona_Vivero_Nombre ASC) VISIBLE,
  CONSTRAINT fk_Empleado_EmpleadoTrabajaZona1
    FOREIGN KEY (EmpleadoTrabajaZona_Fecha_Inicio , EmpleadoTrabajaZona_Zona_Nombre)
    REFERENCES EmpleadoTrabajaZona (Fecha_Inicio , Zona_Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
DROP TABLE IF EXISTS Cliente ;

CREATE TABLE IF NOT EXISTS Cliente (
  DNI VARCHAR(9) NOT NULL,
  Bonificacion DECIMAL NULL,
  Total_mensual DECIMAL NULL,
  PRIMARY KEY (DNI))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table Producto
-- -----------------------------------------------------
DROP TABLE IF EXISTS Producto ;

CREATE TABLE IF NOT EXISTS Producto (
  Codigo_Producto INT NOT NULL,
  Precio DECIMAL NOT NULL,
  Stock INT NULL,
  Zona_Nombre VARCHAR(50) NOT NULL,
  PRIMARY KEY (Codigo_Producto, Zona_Nombre),
  INDEX fk_Producto_Zona1_idx (Zona_Nombre ASC) VISIBLE,
  CONSTRAINT fk_Producto_Zona1
    FOREIGN KEY (Zona_Nombre)
    REFERENCES Zona (Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table ClienteCompraEmpleadoProducto
-- -----------------------------------------------------
DROP TABLE IF EXISTS ClienteCompraEmpleadoProducto ;

CREATE TABLE IF NOT EXISTS ClienteCompraEmpleadoProducto (
  Cantidad INT NOT NULL,
  Fecha DATE NOT NULL,
  Empleado_DNI VARCHAR(9) NOT NULL,
  Producto_Codigo_Producto INT NOT NULL,
  Producto_Zona_Nombre VARCHAR(50) NOT NULL,
  Producto_Zona_Vivero_Nombre VARCHAR(30) NOT NULL,
  Cliente_DNI VARCHAR(9) NOT NULL,
  PRIMARY KEY (Fecha, Empleado_DNI, Producto_Codigo_Producto, Producto_Zona_Nombre, Producto_Zona_Vivero_Nombre, Cliente_DNI),
  INDEX fk_ClienteCompraEmpleadoProducto_Empleado1_idx (Empleado_DNI ASC) VISIBLE,
  INDEX fk_ClienteCompraEmpleadoProducto_Producto1_idx (Producto_Codigo_Producto ASC, Producto_Zona_Nombre ASC, Producto_Zona_Vivero_Nombre ASC) VISIBLE,
  INDEX fk_ClienteCompraEmpleadoProducto_Cliente1_idx (Cliente_DNI ASC) VISIBLE,
  CONSTRAINT fk_ClienteCompraEmpleadoProducto_Empleado1
    FOREIGN KEY (Empleado_DNI)
    REFERENCES Empleado (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ClienteCompraEmpleadoProducto_Producto1
    FOREIGN KEY (Producto_Codigo_Producto , Producto_Zona_Nombre)
    REFERENCES Producto (Codigo_Producto , Zona_Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ClienteCompraEmpleadoProducto_Cliente1
    FOREIGN KEY (Cliente_DNI)
    REFERENCES Cliente (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table Vivero
-- -----------------------------------------------------
START TRANSACTION;
USE mydb;
INSERT INTO Vivero (Nombre, Latitud, Longitud, Localidad) VALUES ('Vivero La Laguna', 5, 21, 'La Laguna');
INSERT INTO Vivero (Nombre, Latitud, Longitud, Localidad) VALUES ('Vivero Santa Cruz', 14, 74, 'Santa Cruz de Tenerife');

COMMIT;


-- -----------------------------------------------------
-- Data for table Zona
-- -----------------------------------------------------
START TRANSACTION;
USE mydb;
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Almacén', 'Vivero La Laguna');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Cajas', 'Vivero La Laguna');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Exterior', 'Vivero La Laguna');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Exterior', 'Vivero Santa Cruz');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Cajas', 'Vivero Santa Cruz');
INSERT INTO Zona (Nombre, Vivero_Nombre) VALUES ('Almacén', 'Vivero Santa Cruz');

COMMIT;


-- -----------------------------------------------------
-- Data for table EmpleadoTrabajaZona
-- -----------------------------------------------------
START TRANSACTION;
USE mydb;
INSERT INTO EmpleadoTrabajaZona (Fecha_Inicio, Fecha_Fin, Ventas, Zona_Nombre) VALUES ('01/01/2019', '01/01/2021', NULL, 'Almacén');
INSERT INTO EmpleadoTrabajaZona (Fecha_Inicio, Fecha_Fin, Ventas, Zona_Nombre) VALUES ('03/01/2020', '03/01/2021', NULL, 'Cajas ');
INSERT INTO EmpleadoTrabajaZona (Fecha_Inicio, Fecha_Fin, Ventas, Zona_Nombre) VALUES ('02/01/2017', '02/01/2021', NULL, 'Exterior');

COMMIT;


-- -----------------------------------------------------
-- Data for table Empleado
-- -----------------------------------------------------
START TRANSACTION;
USE mydb;
INSERT INTO Empleado (Css, Sueldo, Antiguedad, DNI, EmpleadoTrabajaZona_Fecha_Inicio, EmpleadoTrabajaZona_Zona_Nombre, EmpleadoTrabajaZona_Zona_Vivero_Nombre) VALUES ('XXXX123456789012', 1200, 2, '12345678A', '01/01/2019', 'Almacén', 'Vivero La Laguna');
INSERT INTO Empleado (Css, Sueldo, Antiguedad, DNI, EmpleadoTrabajaZona_Fecha_Inicio, EmpleadoTrabajaZona_Zona_Nombre, EmpleadoTrabajaZona_Zona_Vivero_Nombre) VALUES ('XXXZ123456789012', 1150, 1, '12345678B', '03/01/2020', 'Cajas', 'Vivero La Laguna');
INSERT INTO Empleado (Css, Sueldo, Antiguedad, DNI, EmpleadoTrabajaZona_Fecha_Inicio, EmpleadoTrabajaZona_Zona_Nombre, EmpleadoTrabajaZona_Zona_Vivero_Nombre) VALUES ('XXXY123456789012', 1300, 4, '12345678C', '02/01/2017', 'Exterior', 'Vivero Santa Cruz');

COMMIT;


-- -----------------------------------------------------
-- Data for table Cliente
-- -----------------------------------------------------
START TRANSACTION;
USE mydb;
INSERT INTO Cliente (DNI, Bonificacion, Total_mensual) VALUES ('23456789A', NULL, NULL);
INSERT INTO Cliente (DNI, Bonificacion, Total_mensual) VALUES ('23456789B', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table Producto
-- -----------------------------------------------------
START TRANSACTION;
USE mydb;
INSERT INTO Producto (Codigo_Producto, Precio, Stock, Zona_Nombre) VALUES (0001, 15.99, , 'Almacén');
INSERT INTO Producto (Codigo_Producto, Precio, Stock, Zona_Nombre) VALUES (0002, 12.36, NULL, 'Almacén');
INSERT INTO Producto (Codigo_Producto, Precio, Stock, Zona_Nombre) VALUES (0003, 9.45, NULL, 'Cajas');
INSERT INTO Producto (Codigo_Producto, Precio, Stock, Zona_Nombre) VALUES (0004, 2.36, NULL, 'Exterior');

COMMIT;


-- -----------------------------------------------------
-- Data for table ClienteCompraEmpleadoProducto
-- -----------------------------------------------------
START TRANSACTION;
USE mydb;
INSERT INTO ClienteCompraEmpleadoProducto (Cantidad, Fecha, Empleado_DNI, Producto_Codigo_Producto, Producto_Zona_Nombre, Producto_Zona_Vivero_Nombre, Cliente_DNI) VALUES (2, '04/04/2020', '12345678A', 0001, 'Almacén', 'Vivero La Laguna', '23456789A');

COMMIT;
