# Conexión inalámbrica entre ROS y Matlab



## Tabla de Contenidos

1. [Comentarios generales](#Comentarios-generales)
2. [Configuración de la IP estática](#Configuración-de-la-IP-estática)
    1. [En la computadora con Windows](#En-la-computadora-con-Windows)
    2. [En la Jetson Nano](#En-la-Jetson-Nano)
3. [Prueba de conexión](#Prueba-de-conexión)
3. [Gráficos generados](#Gráficos-generados)


## Comentarios generales
Para poder crear la conexión entre la computadora con Matlab (Instalada en Windows en este caso) y la JETSON tenemos que tener claro que la IP cambian, si no se tiene configurada una IP estática, al ser modifaca no permite establecer la conexión. Por lo que se configurara la IP estática tanto para la JETSON como para la computadora.

   
## Configuración de IP estática 

### En la computadora con Windows



Configurar una IP estática en el dispositivo que se utilizara Matlab.
Nos conectamos a la red que se esta conectando el TurtleBot2

Posteriormente ir a la terminal y ejecutar ipconfig

<p align='center'>
    <img src=./IMÁGENES/s1.png alt="drawing" width="600"/>
</p>

Observamos la IP que nos asigna, en la máscara de red y de la ip del Enrutador.

Posteriormente nos vamos a configuraciones de esa red y pulsamos en editar red y configuración en modo manual.
<p align='center'>
    <img src=./IMÁGENES/s4.png alt="drawing" width="200"/>
</p>

Guardamos los cambios y nos debe de mostrar en configuraciones de esa red los cambios realizados.

<p align='center'>
    <img src=./IMÁGENES/s3.png alt="drawing" width="550"/>
</p>

Y estos también  se deben de mostrar en la terminal.
<p align='center'>
    <img src=./IMÁGENES/s2.png alt="drawing" width="600"/>
</p>

### En la Jetson Nano

Podemos seguir los mismos pasos que la configuración de Wi-Fi entre la Jetson y la computadora en la que se ejecutará Matlab, en este caso se seguirán los pasos para la configuración de wifi de la Jetson en caso de aún no tener configurado. Para ello se puede consultar en el siguiente [enlace](https://github.com/itzchav/AUTOSTART) para el autostart y la conexión con la computadora  [enlace](https://github.com/itzchav/SSH) https://github.com/itzchav/SSH

## Configuración en matlab

Primero se tiene que ingresar a Matlab y desde el equipo que se realize se tiene que 
que ejecutar en el **Command Window**



```
 setenv('ROS_IP','192.168.43.100')          %IP de la computadora
 rosinit('http://192.168.43.178:11311');    %Conexión al nodo maestro   
 rostopic list                              % Comando para revisar los topicos
```
## Prueba de conexión

Ejecutar en el **Command Window** de Matlab

```
rostopic list
```

Y nos debe de mostrar la lista de los tópicos 

## Gráficos generados

### A continuación se muestran los gráficos que se generaron cuando se ejecutó el script de MATLAB de control de punto. 




<p align='center'>
    <img src=./IMÁGENES/P1.png alt="drawing" width="600"/>
</p>


<p align='center'>
    <img src=./IMÁGENES/P2.png alt="drawing" width="600"/>
</p>


<p align='center'>
    <img src=./IMÁGENES/P3.png alt="drawing" width="600"/>
</p>

### A continuación se muestran los gráficos que se generaron cuando se ejecutó el script de MATLAB de control de trayectoria.


<p align='center'>
    <img src=./IMÁGENES/T1.png alt="drawing" width="600"/>
</p>

<p align='center'>
    <img src=./IMÁGENES/T2.png alt="drawing" width="600"/>
</p>
