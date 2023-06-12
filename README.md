# Por Hacer


User index 

    -> Habilitar la opcion de editar otros usuarios(User, Executive y/o SUpervisor), si el current_user es admin o supervisor.
    ->Mostrar los metodos correctos para cada usuario

Ticket model

    ->Agregar validacion del phone

User "rutas a otros modelos"

    -> Hacer que si el current_user es Supervisor o Administrator, y este 'ingresa' a traves de otro usuario de la tabla User. Ellos puedan acceder al index , show, back y 'next' de esos usuarios


### <ins>Arreglar los botones de destroy de todas las paginas</ins>



### <ins>Arreglar los forms de todas las paginas</ins>

Areglar las paginas ("views") a lo que se quiere hacer

    Hacer que se puedan eliminar archivos que se encuentren en el Ticket, si es que uno es el usuario
    (Para lograr el eliminar uno en especifico puede servir el @ticket.files.id_archivo.purge   -> el id_archivo puede ser mas cacho de obtener)


Como modificar a otros usuarios siendo Admin y Supervisor

Revisar que todos los metodos de ticket funcionen correctamente