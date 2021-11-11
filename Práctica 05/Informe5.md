# Práctica 5: Modelo Lógico Relacional (Disparadores): Viveros

## Enunciado de la practica

1. Dada la base de dato de viveros, crear un procedimiento: crear_email devuelva una dirección de correo electrónico con el siguiente formato:

    * Un conjunto de caracteres del nombre y/o apellidos
    * El carácter @
    * El dominio pasado como parámetro.

Una vez creada la tabla escriba un disparador con las siguientes características:

    Disparador: trigger_crear_email_before_insert
    
        * Se ejecuta sobre la tabla clientes.
        * Se ejecuta antes de una operación de inserción.
        * Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.
        * Si el nuevo valor del atributo email no es NULL se comprobará que el valor se corresponde con un email. En el siguiente enlace puedes encontrar una expresión regular para un email: https://regexr.com/3e48o

Nota: Para crear la nueva dirección de email se deberá hacer uso del procedimiento crear_email.

* 2. Crear un disparador que permita verificar que las personas en el Municipio del catastro no pueden vivir en dos viviendas diferentes.

* 3. Crear el o los disparadores que permitan mantener actualizado el stock de la base de dato de viveros.

Debes entregar enlace a repositorio de GitHub que incluya al menos:

* - Script SQL generado para construir la base de datos (fichero con extensión .sql) que incluya los disparadores. Este script debe poder ejecutarse mediante "\i NOMBRE_SCRIPT.sql" (donde 'NOMBRE_SCRIPT.sql.' sea el script creado).  

* - Imagen con la salida de un SELECT de cada tabla de la base de datos
