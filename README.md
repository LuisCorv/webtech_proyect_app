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

    Agregar la searchbar -> index agregar el input, una vez aprete 'enter' o 'buscar' redireccione a otra view, esta view llamemosla results.html.erb , en ella tenemos que desplegar los tickets que tengan user_mail, ticket_title o ticket_incident_description LIKE el input que se ingreso por la searchbar. Para obtener estos tickets, se tiene que hacer un nuevo metodo en el controlador de ticket (llamemoslo search), dentro de el se tiene que hacer una query para obtener los tickets 'similares' al input. Y ademas generar una vista (llamada search.html.erb) que tenga estos datos, para poder hacer el fetch a esta pagina.

    Agregar los sorts a los tickets, esto quiere decir, que hayan 'botones' en esta view que permitan hacen dinamica la vista de los tickets (es decir trabajar con javascript). Estos sort tiene que ser de priority (urgent, high, normal, low), closing_date y response_date.

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