/* ForgeTrace - small shared behaviours. No frameworks needed. */
(function () {
    'use strict';

    // 1. Mobile sidebar open / close
    document.addEventListener('click', function (event) {
        if (event.target.closest('[data-sidebar-toggle]')) {
            document.body.classList.toggle('sidebar-open');
        } else if (event.target.closest('[data-sidebar-close]')) {
            document.body.classList.remove('sidebar-open');
        }
    });

    // 2. Confirmation dialog: <form data-confirm="Are you sure?"> shows a modal before submitting
    const modalElement = document.getElementById('confirmModal');
    if (modalElement && window.bootstrap) {
        const modal = new bootstrap.Modal(modalElement);
        let pendingForm = null;

        document.addEventListener('submit', function (event) {
            const form = event.target;
            if (!(form instanceof HTMLFormElement) || !form.dataset.confirm || form.dataset.confirmed === 'true') {
                return;
            }
            event.preventDefault();
            pendingForm = form;
            modalElement.querySelector('[data-confirm-message]').textContent = form.dataset.confirm;
            modal.show();
        });

        modalElement.querySelector('[data-confirm-ok]').addEventListener('click', function () {
            if (!pendingForm) {
                return;
            }
            pendingForm.dataset.confirmed = 'true';
            modal.hide();
            if (pendingForm.requestSubmit) {
                pendingForm.requestSubmit();
            } else {
                pendingForm.submit();
            }
        });
    }

    // 3. Prevent double submission: <button type="submit" data-loading-text="Saving...">
    document.addEventListener('submit', function (event) {
        if (event.defaultPrevented) {
            return;
        }
        const button = event.target.querySelector('button[type="submit"][data-loading-text]');
        if (button) {
            button.disabled = true;
            button.textContent = button.dataset.loadingText;
        }
    });

    // 4. Success messages disappear after 6 seconds
    document.querySelectorAll('.alert-autohide').forEach(function (alert) {
        setTimeout(function () {
            if (window.bootstrap) {
                bootstrap.Alert.getOrCreateInstance(alert).close();
            }
        }, 6000);
    });

    // 5. Helper for JavaScript fetch() calls to the API - adds the CSRF header
    window.ForgeTrace = {
        csrfHeaders: function () {
            const token = document.querySelector('meta[name="_csrf"]');
            const header = document.querySelector('meta[name="_csrf_header"]');
            if (token && header && token.content) {
                const headers = {};
                headers[header.content] = token.content;
                return headers;
            }
            return {};
        }
    };
})();