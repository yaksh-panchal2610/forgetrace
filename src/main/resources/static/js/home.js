(function () {
    const root = document.querySelector('.fx-home');
    if (!root) return;
    const reduce = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    const video = root.querySelector('.fx-hero-video');
    if (video) {
        const source = video.querySelector('source');
        if (source) source.addEventListener('error', function () { video.style.display = 'none'; });
        if (reduce) video.pause();
    }

    root.querySelectorAll('.fx-media img').forEach(function (img) {
        const mark = function () { img.closest('.fx-media').classList.add('is-missing'); };
        if (img.complete && img.naturalWidth === 0) mark();
        img.addEventListener('error', mark);
    });

    function countUp(el) {
        const target = parseInt(el.dataset.count, 10);
        const suffix = el.dataset.suffix || '';
        if (reduce || isNaN(target)) return;
        const start = performance.now();
        const duration = 1400;
        function frame(now) {
            const p = Math.min((now - start) / duration, 1);
            const eased = 1 - Math.pow(1 - p, 3);
            el.textContent = Math.round(target * eased) + suffix;
            if (p < 1) requestAnimationFrame(frame);
        }
        el.textContent = '0' + suffix;
        requestAnimationFrame(frame);
    }

    const revealItems = root.querySelectorAll('[data-reveal]');
    if ('IntersectionObserver' in window && !reduce) {
        root.classList.add('fx-js');
        const io = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (!entry.isIntersecting) return;
                entry.target.classList.add('is-in');
                entry.target.querySelectorAll('[data-count]').forEach(countUp);
                io.unobserve(entry.target);
            });
        }, { threshold: 0.15 });
        revealItems.forEach(function (el) { io.observe(el); });
    }

    const track = document.getElementById('fxTrack');
    if (track) {
        const steps = track.querySelectorAll('li');
        let active = 0;
        function paint() {
            steps.forEach(function (li, i) {
                li.classList.toggle('is-done', i < active);
                li.classList.toggle('is-active', i === active);
            });
        }
        paint();
        if (!reduce) {
            setInterval(function () {
                active = (active + 1) % steps.length;
                paint();
            }, 1600);
        }
    }
})();