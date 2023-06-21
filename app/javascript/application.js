// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import Chart from 'chart.js/auto'

document.addEventListener('turbo:load', () => {
  const myChartElement = document.getElementById('myChart');
  if (!myChartElement) {
    console.log("no myChart found");
    return;
  }
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
})