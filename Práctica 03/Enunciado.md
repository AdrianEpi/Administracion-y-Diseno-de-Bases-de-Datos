# Introducción a PostgreSQL

El alumno debe instalar el SGDB postgresql y crear una base de datos de prueba. La entrega corresponderá al histórico de comandos ejecutados hasta concluir la tarea. Estos deben estar en el repositorio GitHub de la asignatura.

Accede a la máquina virtual que se te ha asignado para la realización de prácticas de la asignatura. El objetivo de la práctica es instalar el SGBD postgresql

## Comando para la instalación:

```
$ sudo apt-get install postgresql
```

## Acceder con el superusuario postgres y crear un usuario:

```
$ sudo su postgres
password: XXXXXXXXXX

$ psql

$ createuser miusuario

$ alter role miusuario with password 'mipassword';
```

## Algunos comando útiles

* Listar las basees de datos en el servidor
   ```
   \l
   ```

* Conectar a una base de datos
   ```
   \c dbname username
   ```

* Listar las tablas en el la base de datos actual
   ```
   \dt
   ```

* Ayuda
   ```
   \?
   \h nombre comando
   ```

* Grabar el histórico de comandos a un fichero
   ```
   \s
   ```

* Ejecutar comandos desde un fichero
   ```
   \i
   ```

* Salir
   ```
   \q
   ```

## Crear un ejemplo de pruebas:

``` SQL
CREATE DATABASE pract1;

create table usuarios (
  nombre varchar(30),
  clave varchar(10)
 );

insert into usuarios (nombre, clave) values ('Isa','asdf');
insert into usuarios (nombre, clave) values ('Pablo','jfx344');
insert into usuarios (nombre, clave) values ('Ana','tru3fal');
```
