/* RFQ form: add/remove specification rows and warn about too many files. */
(function () {
    'use strict';

    const container = document.querySelector('[data-spec-rows]');
    const addButton = document.querySelector('[data-spec-add]');
    const MAX_ROWS = 10;

    if (container && addButton) {
        // Give every row consecutive names: specs[0].name, specs[0].value, specs[1].name ...
        function renumber() {
            const rows = container.querySelectorAll('[data-spec-row]');
            rows.forEach(function (row, index) {
                row.querySelectorAll('input[data-field]').forEach(function (input) {
                    input.name = 'specs[' + index + '].' + input.dataset.field;
                    input.id = 'specs' + index + '.' + input.dataset.field;
                });
            });
            addButton.disabled = rows.length >= MAX_ROWS;
        }

        function addRow() {
            const row = document.createElement('div');
            row.className = 'row g-2 mb-2';
            row.setAttribute('data-spec-row', '');
            row.innerHTML =
                '<div class="col-5"><input type="text" class="form-control" data-field="name" maxlength="60" placeholder="e.g. Thickness"></div>' +
                '<div class="col-6"><input type="text" class="form-control" data-field="value" maxlength="200" placeholder="e.g. 2 mm"></div>' +
                '<div class="col-1 d-grid"><button type="button" class="btn btn-ghost" data-spec-remove aria-label="Remove row"><i class="bi bi-x-lg"></i></button></div>';
            container.appendChild(row);
            renumber();
            row.querySelector('input').focus();
        }

        addButton.addEventListener('click', addRow);
        container.addEventListener('click', function (event) {
            const removeButton = event.target.closest('[data-spec-remove]');
            if (removeButton) {
                removeButton.closest('[data-spec-row]').remove();
                renumber();
            }
        });

        if (!container.querySelector('[data-spec-row]')) {
            addRow();
        }
        renumber();
    }

    // Warn before submit if more than 5 files are selected (the server checks too)
    const fileInput = document.querySelector('input[name="attachments"]');
    const warning = document.querySelector('[data-file-warning]');
    if (fileInput && warning) {
        fileInput.addEventListener('change', function () {
            warning.classList.toggle('d-none', fileInput.files.length <= 5);
        });
    }
})();