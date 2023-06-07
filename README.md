# README

### <ins>Arreglar los botones de destroy de todas las paginas</ins>

Pasar todos los Links a botones

### <ins>Arreglar los forms de todas las paginas</ins>

Areglar las paginas ("views") a lo que se quiere hacer

### <ins>Agregar nuevamente a Ticket el attached files</ins>

Que Ticket show e index le muestren al usuario correpondiente los datos que le corresponden

### <ins>Delimitar el forms the Tickets, para que Usuarios,Executivos, Supervisores y Administradores no editen o crear lo que no deben</ins>

Que al destruir un usuario se borre 

        El usuario;
        La Ticket List associada;
        La Assign List associada;
        Todos los tickets asociados a TicketList y AssignList

### <ins>Arreglar el metodo de destroy del controlador de Tickets, ya que un Executive en AssignTickets no debe de poder borrar un ticket</ins>

Revisar que todos los metodos de ticket funcionen correctamente

Ver como hacer mas facil el ingreso de fechas en la app


###  Hacer que ticket_id sea unico en AssignTicket, para que asi no haya un problema ente ticket.assign_list y assign_list.ticket