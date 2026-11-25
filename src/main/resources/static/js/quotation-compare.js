/* 1. Click a column header to sort a quotation table.
   2. Live price preview on the quotation form (the server recalculates the real total). */
(function () {
    'use strict';

    // ---------- 1. Sortable tables: <table data-sortable> with <th data-sort="number|text"> ----------
    document.querySelectorAll('table[data-sortable]').forEach(function (table) {
        const headers = table.querySelectorAll('th[data-sort]');
        headers.forEach(function (header) {
            header.style.cursor = 'pointer';
            header.title = 'Click to sort';
            header.addEventListener('click', function () {
                const columnIndex = Array.prototype.indexOf.call(header.parentNode.children, header);
                const ascending = header.dataset.dir !== 'asc';
                headers.forEach(function (h) { delete h.dataset.dir; h.classList.remove('sorted-asc', 'sorted-desc'); });
                header.dataset.dir = ascending ? 'asc' : 'desc';
                header.classList.add(ascending ? 'sorted-asc' : 'sorted-desc');

                const body = table.tBodies[0];
                const rows = Array.from(body.rows);
                rows.sort(function (a, b) {
                    const cellA = a.cells[columnIndex];
                    const cellB = b.cells[columnIndex];
                    const valueA = cellA.dataset.value !== undefined ? cellA.dataset.value : cellA.textContent.trim();
                    const valueB = cellB.dataset.value !== undefined ? cellB.dataset.value : cellB.textContent.trim();
                    let result;
                    if (header.dataset.sort === 'number') {
                        result = (parseFloat(valueA) || 0) - (parseFloat(valueB) || 0);
                    } else {
                        result = valueA.localeCompare(valueB);
                    }
                    return ascending ? result : -result;
                });
                rows.forEach(function (row) { body.appendChild(row); });
            });
        });
    });

    // ---------- 2. Live price preview: <form data-price-preview data-quantity="100"> ----------
    const form = document.querySelector('[data-price-preview]');
    if (form) {
        const quantity = parseFloat(form.dataset.quantity) || 0;
        const money = new Intl.NumberFormat('en-IN', { style: 'currency', currency: 'INR' });

        function numberFrom(name) {
            const input = form.querySelector('[name="' + name + '"]');
            const value = parseFloat(input ? input.value : '');
            return isNaN(value) ? 0 : value;
        }

        function show(name, value) {
            const target = document.querySelector('[data-out="' + name + '"]');
            if (target) {
                target.textContent = money.format(value);
            }
        }

        function update() {
            const subtotal = Math.round((numberFrom('unitPrice') * quantity + numberFrom('setupFee')) * 100) / 100;
            const tax = Math.round(subtotal * numberFrom('taxRatePercent')) / 100;
            show('subtotal', subtotal);
            show('tax', tax);
            show('total', subtotal + tax);
        }

        form.addEventListener('input', update);
        update();
    }
})();