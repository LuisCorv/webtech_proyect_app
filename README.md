# Por Hacer



Ticket edit 

    -> delimitar los parametros que cada usuario puede modificar

Ticket new 

    -> delimitar los parametros que cada usuario puede modificar
    -> Solo poder crear tickets desde ticketList

Ticket _form  

    -> hacer fechas mas amigables para el usuario

Ticket _ticket -

    > Muestre al usuario solo lo que le es debido mostrar

User index 

    -> Habilitar la opcion de editar otros usuarios(User, Executive y/o SUpervisor), si el current_user es admin o supervisor.
    ->Mostrar los metodos correctos para cada usuario

Ticket model

    ->Agregar validacion del phone

Ticket index

    Agregar la searchbar

User "rutas a otros modelos"

    -> Hacer que si el current_user es Supervisor o Administrator, y este 'ingresa' a traves de otro usuario de la tabla User. Ellos puedan acceder al index , show, back y 'next' de esos usuarios

User Administrator y Supervisor

    -> Agregar un metodo que permita editar y crear AssignTickets en el index de AssignTicket

    ->Agregar un boton para ingresar al AssignTicket index desde el show del user (Similar al de "See all tickets")

### <ins>Arreglar los botones de destroy de todas las paginas</ins>

Pasar todos los Links a botones

### <ins>Arreglar los forms de todas las paginas</ins>

Areglar las paginas ("views") a lo que se quiere hacer

    Hacer que se puedan eliminar archivos que se encuentren en el Ticket, si es que uno es el usuario
    (Para lograr el eliminar uno en especifico puede servir el @ticket.files.id_archivo.purge   -> el id_archivo puede ser mas cacho de obtener)


### <ins>Delimitar el forms the Tickets, para que Usuarios,Executivos, Supervisores y Administradores no editen o crear lo que no deben</ins>

Como modificar a otros usuarios siendo Admin y Supervisor

Revisar que todos los metodos de ticket funcionen correctamente