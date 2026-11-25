(function () {
    if (typeof Chart === 'undefined' || !window.ftCharts) return;
    const d = window.ftCharts;
    Chart.defaults.color = getComputedStyle(document.body).color || '#cbd5e1';
    Chart.defaults.borderColor = 'rgba(148, 163, 184, .15)';
    Chart.defaults.font.family = getComputedStyle(document.body).fontFamily;

    const orders = document.getElementById('ordersChart');
    if (orders) {
        new Chart(orders, {
            type: 'bar',
            data: { labels: d.statusLabels, datasets: [{ label: 'Orders', data: d.statusCounts,
                backgroundColor: 'rgba(34, 211, 238, .6)', borderRadius: 6 }] },
            options: { maintainAspectRatio: false, plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true, ticks: { precision: 0 } } } }
        });
    }

    const revenue = document.getElementById('revenueChart');
    if (revenue) {
        new Chart(revenue, {
            type: 'line',
            data: { labels: d.dayLabels, datasets: [{ label: 'Paid (INR)', data: d.dayAmounts,
                borderColor: '#4ade80', backgroundColor: 'rgba(74, 222, 128, .15)', fill: true, tension: .3, pointRadius: 3 }] },
            options: { maintainAspectRatio: false, plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true } } }
        });
    }
})();