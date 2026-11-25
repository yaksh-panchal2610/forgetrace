(function () {
    const form = document.getElementById('paymentForm');
    if (!form) return;

    const panels = form.querySelectorAll('[data-method-panel]');
    const radios = form.querySelectorAll('input[name="method"]');
    const mainPay = document.getElementById('mainPayButton');
    const upiInput = document.getElementById('upiId');
    const qrBox = document.getElementById('upiQrBox');
    const idBox = document.getElementById('upiIdBox');
    const qrImage = document.getElementById('upiQrImage');
    const qrTimer = document.getElementById('qrTimer');
    const qrTimerText = document.getElementById('qrTimerText');
    const qrExpiredText = document.getElementById('qrExpiredText');
    const qrRefresh = document.getElementById('qrRefresh');
    const qrButtons = form.querySelectorAll('[data-qr-result]');
    const QR_SECONDS = 300;

    let upiMode = 'qr';
    let secondsLeft = 0;
    let timerId = null;
    let qrLoaded = false;

    function currentMethod() {
        const checked = form.querySelector('input[name="method"]:checked');
        return checked ? checked.value : '';
    }

    function showPanel() {
        const method = currentMethod();
        panels.forEach(function (p) {
            p.classList.toggle('d-none', p.dataset.methodPanel !== method);
        });
        form.querySelectorAll('.pay-method').forEach(function (label) {
            const input = label.querySelector('input');
            label.classList.toggle('active', input && input.checked);
        });
        const qrActive = method === 'UPI' && upiMode === 'qr';
        if (mainPay) mainPay.classList.toggle('d-none', qrActive);
        if (qrActive && !qrLoaded) newQr();
    }

    function applyUpiMode() {
        form.querySelectorAll('[data-upi-mode]').forEach(function (b) {
            b.classList.toggle('active', b.dataset.upiMode === upiMode);
        });
        if (qrBox) qrBox.classList.toggle('d-none', upiMode !== 'qr');
        if (idBox) idBox.classList.toggle('d-none', upiMode !== 'id');
        showPanel();
    }

    function formatTime(s) {
        const m = Math.floor(s / 60);
        const r = s % 60;
        return String(m).padStart(2, '0') + ':' + String(r).padStart(2, '0');
    }

    function setExpired(expired) {
        qrTimerText.classList.toggle('d-none', expired);
        qrExpiredText.classList.toggle('d-none', !expired);
        qrImage.style.opacity = expired ? '0.2' : '1';
        qrButtons.forEach(function (b) { b.disabled = expired; });
    }

    function tick() {
        secondsLeft -= 1;
        if (secondsLeft <= 0) {
            clearInterval(timerId);
            setExpired(true);
            return;
        }
        qrTimer.textContent = formatTime(secondsLeft);
    }

    function newQr() {
        if (!qrImage) return;
        qrImage.src = qrImage.dataset.src + '?v=' + Date.now();
        qrLoaded = true;
        secondsLeft = QR_SECONDS;
        qrTimer.textContent = formatTime(secondsLeft);
        setExpired(false);
        clearInterval(timerId);
        timerId = setInterval(tick, 1000);
    }

    radios.forEach(function (r) { r.addEventListener('change', showPanel); });

    form.querySelectorAll('[data-upi-mode]').forEach(function (b) {
        b.addEventListener('click', function () {
            upiMode = b.dataset.upiMode;
            if (upiMode === 'id' && upiInput) upiInput.value = '';
            applyUpiMode();
        });
    });

    if (qrRefresh) qrRefresh.addEventListener('click', newQr);

    qrButtons.forEach(function (b) {
        b.addEventListener('click', function () {
            if (upiInput) upiInput.value = b.dataset.qrResult;
        });
    });

    applyUpiMode();

    const card = document.getElementById('cardNumber');
    if (card) {
        card.addEventListener('input', function () {
            const digits = card.value.replace(/\D/g, '').slice(0, 19);
            card.value = digits.replace(/(.{4})/g, '$1 ').trim();
        });
    }

    form.querySelectorAll('[data-fill]').forEach(function (btn) {
        btn.addEventListener('click', function () {
            const target = document.getElementById(btn.dataset.target);
            if (target) target.value = btn.dataset.fill;
        });
    });

    let submitted = false;
    form.addEventListener('submit', function (e) {
        if (submitted) {
            e.preventDefault();
            return;
        }
        submitted = true;
    });
})();