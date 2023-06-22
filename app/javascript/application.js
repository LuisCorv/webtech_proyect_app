// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import Chart from 'chart.js/auto'

//--------------------------------------------------------------------------------------

//To get date of the Time
function parseDateString(dateString) {
  var parts = dateString.split(' ');
  var datePart = parts[0];
  return new Date(datePart);
}

//To get the value associate to priority
function getPriorityValue(priority) {
  switch (priority) {
  case 'Low':
      return 0;
  case 'Normal':
      return 1;
  case 'High':
      return 2;
  case 'Urgent':
      return 3;
  default:
      return 9999; // Handle unknown priority values
  }
}


//--------------------------------------------------------------------------------------

//histogram
document.addEventListener('turbo:load', () => {
  const myChartElement = document.getElementById('myChart');
  if (!myChartElement) {
    console.log("no myChart found");
    return;
  }
  console.log("myChart found");
  const ctx = myChartElement.getContext('2d');
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: JSON.parse(ctx.canvas.dataset.labels),
      datasets: [{
        data: JSON.parse(ctx.canvas.dataset.data),
        label: ctx.canvas.dataset.title,
        backgroundColor: ctx.canvas.dataset.backgroundColor,
        borderColor: ctx.canvas.dataset.borderColor,
        borderWidth: ctx.canvas.dataset.borderWidth,
      }],
    },
    options: JSON.parse(ctx.canvas.dataset.options)
  });
});


//--------------------------------------------------------------------------------------
//sort_priority
document.addEventListener('turbo:load', () => {
    const sortButtonPriority = document.getElementById('sortButtonPriority');
    let sortOrder = 'asc'; // Initial sort order

    if (!sortButtonPriority) {
      console.log("no sort button priority found");
      return;
    }
    console.log("sorted priority found");

    // Priority Sort
    sortButtonPriority.onclick = function() {
      sortOrder = sortOrder === 'asc' ? 'desc' : 'asc'; // Toggle sort order

      let tickets = Array.from(document.getElementsByClassName('ticket'));
      tickets.sort(function(a, b) {
        let priorityA = a.getAttribute('data-priority');
        let priorityB = b.getAttribute('data-priority');

        if (priorityA === priorityB) {
            return 0;
        } else if (sortOrder === 'asc') {
            return getPriorityValue(priorityA) - getPriorityValue(priorityB);
        } else {
            return getPriorityValue(priorityB) - getPriorityValue(priorityA);
        }
      });

      let container = document.getElementById('ticketContainer');
      tickets.forEach(function(ticket) {
        container.appendChild(ticket);
      });
  }
});

//--------------------------------------------------------------------------------------

//sort_closing
document.addEventListener('turbo:load', () => {
  const sortButtonClosing = document.getElementById('sortButtonClosing');
    let sortOrderClosing= "asc" // Initial sort order

  if (!sortButtonClosing) {
    console.log("no sort button closing found");
    return;
  }
  console.log("sorted closing found");
  

  // Closing Sort
  sortButtonClosing.onclick = function() {
    sortOrderClosing = sortOrderClosing === 'asc' ? 'desc' : 'asc'; // Toggle sort order

    sortTicketsClosing();
  }

  function sortTicketsClosing() {
      let tickets = Array.from(document.getElementsByClassName('ticket'));
      tickets.sort(function(a, b) {
      let valueA = parseDateString(a.getAttribute('data-resolution_date'));
      // console.log(valueA);
      let valueB = parseDateString(b.getAttribute('data-resolution_date'));

      if (sortOrderClosing === 'asc') {
          return valueA - valueB;
      } else {
          return valueB - valueA;
      }
      });

      let container = document.getElementById('ticketContainer');
      tickets.forEach(function(ticket) {
        container.appendChild(ticket);
      });
  } 
});

//--------------------------------------------------------------------------------------

//sort_response
document.addEventListener('turbo:load', () => {
  const sortButtonResponse = document.getElementById('sortButtonResponse');
    let sortOrderResponse = 'asc'; // Initial sort order

  if (!sortButtonResponse) {
    console.log("no sort button response found");
    return;
  }
  console.log("sorted response found");
  

  // Response Sort
  sortButtonResponse.onclick = function() {
    sortOrderResponse = sortOrderResponse === 'asc' ? 'desc' : 'asc'; // Toggle sort order

    sortTickets();
  }

  function sortTickets() {
      let tickets = Array.from(document.getElementsByClassName('ticket'));
      tickets.sort(function(a, b) {
      let valueA = parseDateString(a.getAttribute('data-response_to_user_date'));
      // console.log(valueA);
      let valueB = parseDateString(b.getAttribute('data-response_to_user_date'));

      if (sortOrderResponse === 'asc') {
          return valueA - valueB;
      } else {
          return valueB - valueA;
      }
      });

      let container = document.getElementById('ticketContainer');
      tickets.forEach(function(ticket) {
        container.appendChild(ticket);
      });
  } 
});

    

//--------------------------------------------------------------------------------------
    


//searchbar
document.addEventListener('turbo:load', () =>{
  
  searchbaar= document.getElementById('searchbar');

  if (!searchbaar) {
    console.log("no searchbar found");
    return;
  }
  console.log("searchbar found");

  // Cerrar el dropdown cuando se hace clic fuera del input o del dropdown
  document.onclick = function(event) {
    document.getElementById('results-menu').classList.remove('show');
  }
  searchbaar.addEventListener('keyup', event => {
    let inputbar = document.getElementById('searchbar').value;
    let result = document.getElementById('results');
    //console.log(inputbar)
    if (inputbar === "") {
      document.getElementById('results-menu').classList.remove('show');
    }
    else {
      fetch('/tickets/search?query='+inputbar)
      .then(response => response.text())
      .then(html => {
        // Analizar el HTML obtenido
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        // Obtener el elemento <div> con el nombre "datos"
        const datosDiv = doc.querySelector('div#datos');
        
        if (datosDiv) {
          document.getElementById('results-menu').classList.add('show');
          if (datosDiv.innerHTML.trim() === '') {
            // El div "datos" está vacío
            // Realiza la acción deseada aquí
            result.innerHTML = '<li><span class="dropdown-item-text">Not Found</span></li>';
          } else {
            // El div "datos" contiene contenido
            
            result.innerHTML = datosDiv.innerHTML

            //Change the color of the links
            let links=document.getElementsByClassName("nav-link dropdown-item");
            for (var i = 0, len = links.length; i < len; i++) {
                links[i].style.color = "#000000 ";
            }
            
          }
        } else {
          console.log('No se encontró el div con el nombre "datos"');
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
    }
  });
});