document.addEventListener("turbolinks:load", function () {
    const labels = [
        '',
        'February',
        'March',
        'April',
        'May'
    ];
    const data = {
        labels: labels,
        datasets: [{
            label: 'Earning statistic',
            backgroundColor: 'rgb(255, 99, 132)',
            borderColor: 'rgb(255, 99, 132)',
            data: [3, 2, 4, 3, 4.2],
            tension: 0.4
        }]
    };

    const config = {
        type: 'line',
        data: data,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    max: 6,
                    min: 0,
                    ticks: {
                        stepSize: 1,
                        // Include a dollar sign in the ticks
                        callback: function(value, index, values) {
                            return '$' + value + "k";
                        }
                    }
                }
            }
        }
    };

    let myChart = new Chart(
        document.getElementById('myChart'),
        config,
    );
})
