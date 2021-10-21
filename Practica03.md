# Introducción PostgreSQL

En la práctica se nos pide instalar el SGDB postgresql y crear una base de datos de prueba. La entrega corresponderá al histórico de comandos ejecutados hasta concluir la tarea. Estos deben estar en el repositorio GitHub de la asignatura.

Para la realización del ejercicio, dberemos acceder a la máquina virtual que se nos a asignado para la realización de las prácticas de la asignatura. El objetivo principal de la práctica es instalar el SGBD postgresql.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

En primer lugar comenzamos con los comandos de instalacion: 

  * sudo apt-get install postgresql

![Intro postgre](Postgre_Intro/install.jpg)

A continuacion, depues de realizar la instalacion, deberemos acceder con el superusuario de postgre y crear un usuario con los siguientes comandos:

  * sudo su postgres password: XXXXXXXXXX
 
![Intro postgre](Postgre_Intro/misudo.jpg) 
 
 Para entrar en la línea de comandos de postgre y así poder crear " mi usuario", deberemos escribir " psql " y ya dentro escribir lo siguiente: 
 
  * createuser miusuario
  * alter role miusuario with password 'mipassword';
 
 
![Intro postgre](Postgre_Intro/miusuario2.jpg)
 
 Para terminar con la parte de introduccion, se ralizo la prueba de algunos de los comandos mas basicos de postgre: 
 
![Intro postgre](Postgre_Intro/interesante.jpg)
 
 
 Pasando a la segunda parte de la practica, pasamos a crear la tabla que se nos ha pedido en el enunciado:
 
  * Priemro Creamos la tabla
  * 
![Intro postgre](Postgre_Intro/tabla.jpg)

  * En segundo lugar realizamos los insert
  
![Intro postgre](Postgre_Intro/insert.jpg)

  * Mostramos la tabla resultante
 
 ![Intro postgre](Postgre_Intro/tablafinal.jpg)
 
