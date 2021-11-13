# Práctica 5: Modelo Lógico Relacional (Disparadores): Viveros

## Enunciado de la practica

1. Dada la base de dato de viveros, crear un procedimiento: crear_email devuelva una dirección de correo electrónico con el siguiente formato:

    * Un conjunto de caracteres del nombre y/o apellidos
    * El carácter @
    * El dominio pasado como parámetro.

Una vez creada la tabla escriba un disparador con las siguientes características "trigger_crear_email_before_insert":
    
     - Se ejecuta sobre la tabla clientes.
        
     - Se ejecuta antes de una operación de inserción.
        
     - Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.
        
     - Si el nuevo valor del atributo email no es NULL se comprobará que el valor se corresponde con un email.

Nota: Para crear la nueva dirección de email se deberá hacer uso del procedimiento crear_email.

* 2. Crear un disparador que permita verificar que las personas en el Municipio del catastro no pueden vivir en dos viviendas diferentes.

* 3. Crear el o los disparadores que permitan mantener actualizado el stock de la base de dato de viveros.

Debes entregar enlace a repositorio de GitHub que incluya al menos:

* - Script SQL generado para construir la base de datos (fichero con extensión .sql) que incluya los disparadores. Este script debe poder ejecutarse mediante "\i NOMBRE_SCRIPT.sql" (donde 'NOMBRE_SCRIPT.sql.' sea el script creado).  

* - Imagen con la salida de un SELECT de cada tabla de la base de datos

------------------------------------------------------------------------------------------------------------------------------------------------------------------


   En primer lugar, se ha realizado la creación de la función " crear_email ". El objetivo de la función, es el de comprobar si nuestro usuario ha escrito un correo correcto, o sí no lo ha metido en tal caso se le crea uno nuevo concatenando el nombre y los apellidos del usuario.
   
```bash
-- --------------------------------------
-- Function crear_email
-- --------------------------------------
DROP FUNCTION IF EXISTS crear_email;
CREATE OR REPLACE FUNCTION crear_email() RETURNS TRIGGER AS $crear_email$
  DECLARE newEmail VARCHAR(100);
  BEGIN
    IF ((new.Email NOT LIKE '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$') AND (new.Email IS NOT NULL)) THEN
        RAISE EXCEPTION 'El correo no es valido';
    END IF;
    
    IF new.Email IS NULL THEN
      new.Email := CONCAT(
        LOWER(new.Nombre),
        LOWER(new.Apellido1),
        LOWER(new.Apellido2),
        '@',
        LOWER(TG_ARGV[0])
      );
    END IF;
    
    
    RETURN NEW;
  END;
$crear_email$ LANGUAGE plpgsql;
-- --------------------------------------
-- Trigger trigger_crear_email_before_insert
-- --------------------------------------
CREATE TRIGGER trigger_crear_email_before_insert
  BEFORE INSERT ON Cliente
  FOR EACH ROW EXECUTE PROCEDURE crear_email('ull.edu.es');
```

En segundo lugar, se realizo la creacion de la funcion " comprobar_zona " cuya funcion principal es comprobar que dos trabajadores no trabajan en la misma zona, sacando asi un mensaje de error en caso de que sucediera.

```bash
-- --------------------------------------
-- Function comprobar_zona
-- --------------------------------------
DROP FUNCTION IF EXISTS comprobar_zona;
CREATE OR REPLACE FUNCTION comprobar_zona() RETURNS TRIGGER AS $comprobar_zona$
  BEGIN
    IF EXISTS(SELECT * FROM Empleado WHERE (Empleado.EmpleadoTrabajaZona_Zona_Codigo = new.EmpleadoTrabajaZona_Zona_Codigo)) THEN
        RAISE EXCEPTION 'No pueden trabajar en la misma zona';
    END IF;
    RETURN NEW;
  END;
$comprobar_zona$ LANGUAGE plpgsql;
-- --------------------------------------
-- Trigger trigger_Empleado_Trabaja_Una_zona
-- --------------------------------------
-- Crear un disparador que permita verificar que en cada zona de un vivero no pueden trabajar dos personas diferentes.
CREATE TRIGGER trigger_Empleado_Trabaja_Una_zona 
  BEFORE INSERT ON Empleado
    FOR EACH ROW EXECUTE PROCEDURE comprobar_zona();
END;

```

   Por ultimo, se ha creado la funcion " actualizar stock ", su objetivo es el de actualizar el stock de nuestra base de datos de disparadores, teniendo un control asi de nuestro stock en todo momento.
 
```bash

-- --------------------------------------
-- Function actualizar_Stock
-- --------------------------------------
DROP FUNCTION IF EXISTS actualizar_Stock;
CREATE OR REPLACE FUNCTION actualizar_Stock() RETURNS TRIGGER AS $actualizar_Stock$
  BEGIN
    IF EXISTS(SELECT * FROM Producto WHERE ((Producto.Codigo_Producto = new.Producto_Codigo_Producto) AND (Producto.Zona_Codigo = new.Producto_Zona_Codigo) AND (Producto.Stock >= new.Cantidad))) THEN
      UPDATE Producto SET Stock = (Producto.Stock - new.Cantidad) WHERE ((Producto.Codigo_Producto = new.Producto_Codigo_Producto) AND (Producto.Zona_Codigo = new.Producto_Zona_Codigo) AND (Producto.Stock >= new.Cantidad));
    END IF;
    RETURN NEW;
  END;
$actualizar_Stock$ LANGUAGE plpgsql;
-- --------------------------------------
-- Trigger trigger_actualizar_stock
-- --------------------------------------
-- Crear un disparador que permita verificar que en cada zona de un vivero no pueden trabajar dos personas diferentes.
CREATE TRIGGER trigger_actualizar_stock 
  BEFORE INSERT ON ClienteCompraEmpleadoProducto
    FOR EACH ROW EXECUTE PROCEDURE actualizar_Stock();
END;

```

## Capturas de las tablas tras las inserciones

<div align="center">
  <br>
  <img src="img/vivero.png" alt="Markdownify">
  <br>
  <br>
</div>

---

<div align="center">
  <br>
  <img src="img/zona.png" alt="Markdownify">
  <br>
  <br>
</div>

---

<div align="center">
  <br>
  <img src="img/empleadoTrabajaZona.png" alt="Markdownify">
  <br>
  <br>
</div>

---

<div align="center">
  <br>
  <img src="img/empleado.png" alt="Markdownify">
  <br>
  <br>
</div>

---

<div align="center">
  <br>
  <img src="img/producto.png" alt="Markdownify">
  <br>
  <br>
</div>

---

<div align="center">
  <br>
  <img src="img/cliente.png" alt="Markdownify">
  <br>
  <br>
</div>

---

<div align="center">
  <br>
  <img src="img/clienteCompraProducto.png" alt="Markdownify">
  <br>
  <br>
</div>