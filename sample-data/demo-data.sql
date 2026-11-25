-- =====================================================================
-- ForgeTrace orders + payments data set (development only)
-- Needs: at least 1 buyer and 1 verified manufacturer (load demo-data.sql first for best results)
--   60 awarded RFQs -> accepted quotations -> production orders in all 10 statuses
--   ~60 extra competing quotations (REJECTED) so the comparison page has data
--   25 open RFQs with 2-3 submitted quotations each
--   ~55 payments over the last 14 days (mostly paid, some failed)
-- Reference numbers use the prefix ...-2026-D  (easy to find / remove)
-- =====================================================================
BEGIN;

DO $$
DECLARE
    titles text[] := ARRAY['Steel flange DN50','Pump housing','Gearbox cover','Motor shaft 25 mm','Valve body 2 inch',
        'Mounting bracket','Control panel enclosure','Bearing housing','Drive pulley','Hydraulic manifold block',
        'Connecting rod','Brake drum','Impeller 150 mm','Battery tray','Heat sink plate','Bush sleeve',
        'Tractor axle hub','Solar panel clamp','Drone arm bracket','Cable gland body'];
    units  text[] := ARRAY['pcs','pcs','pcs','pcs','sets','kg'];
    methods text[] := ARRAY['CARD','UPI','NET_BANKING','UPI','CARD','WALLET'];
    statuses text[] := ARRAY[
        'CONFIRMED','CONFIRMED','CONFIRMED','CONFIRMED','CONFIRMED','CONFIRMED','CONFIRMED','CONFIRMED',
        'SCHEDULED','SCHEDULED','SCHEDULED','SCHEDULED','SCHEDULED','SCHEDULED','SCHEDULED',
        'IN_PRODUCTION','IN_PRODUCTION','IN_PRODUCTION','IN_PRODUCTION','IN_PRODUCTION','IN_PRODUCTION','IN_PRODUCTION','IN_PRODUCTION','IN_PRODUCTION',
        'QUALITY_CHECK','QUALITY_CHECK','QUALITY_CHECK','QUALITY_CHECK','QUALITY_CHECK','QUALITY_CHECK','QUALITY_CHECK',
        'READY_TO_SHIP','READY_TO_SHIP','READY_TO_SHIP','READY_TO_SHIP','READY_TO_SHIP','READY_TO_SHIP',
        'SHIPPED','SHIPPED','SHIPPED','SHIPPED','SHIPPED','SHIPPED',
        'DELIVERED','DELIVERED','DELIVERED','DELIVERED','DELIVERED',
        'COMPLETED','COMPLETED','COMPLETED','COMPLETED','COMPLETED','COMPLETED','COMPLETED','COMPLETED',
        'ON_HOLD','ON_HOLD','CANCELLED','CANCELLED'];

    buyers bigint[]; mfrs bigint[];
    n_b int; n_m int;
    k int; j int;
    b_org bigint; b_user bigint; m_org bigint; m_user bigint; o_org bigint; o_user bigint;
    p_id bigint; mat_id bigint;
    rfq_id bigint; q_id bigint; ord_id bigint;
    qty numeric; unit_price numeric; setup numeric; subtotal numeric; tax numeric; total numeric;
    lead int; created timestamptz; paid timestamptz; v_status text; v_city text; v_unit text;
BEGIN
    PERFORM setseed(0.42);

    IF EXISTS (SELECT 1 FROM rfqs WHERE rfq_number LIKE 'RFQ-2026-D%') THEN
        RAISE EXCEPTION 'Order demo data is already loaded. Run demo-orders-remove.sql first to reload it.';
    END IF;

    SELECT array_agg(o.id ORDER BY o.id) INTO buyers
    FROM organizations o
    WHERE o.organization_type = 'BUYER'
      AND EXISTS (SELECT 1 FROM organization_members m WHERE m.organization_id = o.id AND m.active);

    SELECT array_agg(o.id ORDER BY o.id) INTO mfrs
    FROM organizations o
    WHERE o.organization_type = 'MANUFACTURER' AND o.verification_status = 'VERIFIED'
      AND EXISTS (SELECT 1 FROM organization_members m WHERE m.organization_id = o.id AND m.active);

    n_b := coalesce(array_length(buyers, 1), 0);
    n_m := coalesce(array_length(mfrs, 1), 0);
    IF n_b = 0 OR n_m = 0 THEN
        RAISE EXCEPTION 'Need at least one buyer and one VERIFIED manufacturer (found % buyers, % verified manufacturers).', n_b, n_m;
    END IF;

    -- ------------------------------------------------------------------
    -- 60 awarded RFQs with orders (and payments)
    -- ------------------------------------------------------------------
    FOR k IN 1 .. 60 LOOP
        b_org := buyers[1 + (k * 7) % n_b];
        m_org := mfrs[1 + (k * 11) % n_m];
        SELECT user_id INTO b_user FROM organization_members WHERE organization_id = b_org AND active ORDER BY id LIMIT 1;
        SELECT user_id INTO m_user FROM organization_members WHERE organization_id = m_org AND active ORDER BY id LIMIT 1;
        SELECT city INTO v_city FROM organizations WHERE id = b_org;

        -- use a process + material the manufacturer offers (fallback: any active one)
        SELECT process_id INTO p_id FROM manufacturer_processes WHERE manufacturer_id = m_org ORDER BY process_id LIMIT 1 OFFSET (k % 2);
        IF p_id IS NULL THEN SELECT process_id INTO p_id FROM manufacturer_processes WHERE manufacturer_id = m_org LIMIT 1; END IF;
        IF p_id IS NULL THEN SELECT id INTO p_id FROM manufacturing_processes WHERE active ORDER BY id LIMIT 1; END IF;
        SELECT material_id INTO mat_id FROM manufacturer_materials WHERE manufacturer_id = m_org ORDER BY material_id LIMIT 1 OFFSET (k % 3);
        IF mat_id IS NULL THEN SELECT material_id INTO mat_id FROM manufacturer_materials WHERE manufacturer_id = m_org LIMIT 1; END IF;
        IF mat_id IS NULL THEN SELECT id INTO mat_id FROM materials WHERE active ORDER BY id LIMIT 1; END IF;

        v_status   := statuses[k];
        v_unit     := units[1 + k % 6];
        qty        := (ARRAY[50,100,200,250,500,750,1000,1500,2000,5000])[1 + (k * 3) % 10];
        unit_price := round((40 + random() * 1960)::numeric, 2);
        setup      := (ARRAY[0,0,1500,2500,5000,7500])[1 + k % 6];
        subtotal   := round(qty * unit_price + setup, 2);
        tax        := round(subtotal * 0.18, 2);
        total      := subtotal + tax;
        lead       := 7 + (k * 5) % 40;
        created    := now() - ((2 + (60 - k) * 0.45) || ' days')::interval - ((k % 9) || ' hours')::interval;

        INSERT INTO rfqs (rfq_number, buyer_organization_id, created_by, title, description, process_id, material_id,
                          quantity, quantity_unit, specifications, tolerance_notes, delivery_date, delivery_address,
                          quote_deadline, status, created_at, updated_at)
        VALUES ('RFQ-2026-D' || lpad(k::text, 6, '0'), b_org, b_user, titles[1 + k % 20],
                'Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.',
                p_id, mat_id, qty, v_unit, NULL, 'General tolerance ISO 2768-m unless stated.',
                (created + ((lead + 20) || ' days')::interval)::date,
                'Stores, Gate 2, ' || coalesce(v_city, 'Pune'),
                created + interval '5 days', 'AWARDED', created, created + interval '6 days')
        RETURNING id INTO rfq_id;

        INSERT INTO quotations (quotation_number, rfq_id, manufacturer_organization_id, submitted_by, version_number,
                                unit_price, setup_fee, tax_amount, total_amount, currency, lead_time_days, valid_until,
                                terms, status, created_at, updated_at)
        VALUES ('QTN-2026-D' || lpad(k::text, 6, '0'), rfq_id, m_org, m_user, 1,
                unit_price, setup, tax, total, 'INR', lead, created + interval '20 days',
                '50% advance, balance before dispatch. Ex-works.', 'ACCEPTED',
                created + interval '2 days', created + interval '6 days')
        RETURNING id INTO q_id;

        -- one competing quotation from another manufacturer that was not chosen
        IF n_m > 1 THEN
            o_org := mfrs[1 + (k * 11 + 1) % n_m];
            SELECT user_id INTO o_user FROM organization_members WHERE organization_id = o_org AND active ORDER BY id LIMIT 1;
            INSERT INTO quotations (quotation_number, rfq_id, manufacturer_organization_id, submitted_by, version_number,
                                    unit_price, setup_fee, tax_amount, total_amount, currency, lead_time_days, valid_until,
                                    terms, status, created_at, updated_at)
            VALUES ('QTN-2026-D' || lpad((1000 + k)::text, 6, '0'), rfq_id, o_org, o_user, 1,
                    round(unit_price * 1.12, 2), setup, round((qty * round(unit_price * 1.12, 2) + setup) * 0.18, 2),
                    round(qty * round(unit_price * 1.12, 2) + setup, 2) + round((qty * round(unit_price * 1.12, 2) + setup) * 0.18, 2),
                    'INR', lead + 5, created + interval '20 days', '100% against delivery.', 'REJECTED',
                    created + interval '3 days', created + interval '6 days');
        END IF;

        INSERT INTO production_orders (order_number, accepted_quotation_id, rfq_id, buyer_organization_id,
                                       manufacturer_organization_id, quantity, total_amount, currency,
                                       expected_completion, status, created_at, updated_at)
        VALUES ('ORD-2026-D' || lpad(k::text, 6, '0'), q_id, rfq_id, b_org, m_org, qty, total, 'INR',
                (created + ((lead + 6) || ' days')::interval)::date, v_status,
                created + interval '6 days', now() - ((k % 5) || ' hours')::interval)
        RETURNING id INTO ord_id;

        -- payments: paid for everything past CONFIRMED (except cancelled), some failed attempts first
        IF v_status NOT IN ('CONFIRMED', 'CANCELLED') OR k % 3 = 0 THEN
            paid := now() - ((k * 37 % 330) || ' hours')::interval;   -- spread over the last ~14 days

            IF k % 4 = 0 THEN
                INSERT INTO payments (production_order_id, payment_reference, provider, provider_reference, idempotency_key,
                                      amount, currency, payment_method, status, failure_reason, paid_at, created_at, updated_at)
                VALUES (ord_id, 'PAY-2026-D' || lpad((5000 + k)::text, 6, '0'), 'SANDBOX', NULL, gen_random_uuid()::text,
                        total, 'INR', 'CARD', 'FAILED', 'Card declined by the bank (sandbox test card).', NULL,
                        paid - interval '20 minutes', paid - interval '20 minutes');
            END IF;

            IF v_status <> 'CONFIRMED' THEN
                INSERT INTO payments (production_order_id, payment_reference, provider, provider_reference, idempotency_key,
                                      amount, currency, payment_method, status, failure_reason, paid_at, created_at, updated_at)
                VALUES (ord_id, 'PAY-2026-D' || lpad(k::text, 6, '0'), 'SANDBOX',
                        'sbx_' || upper(substr(md5(k::text || 'pay'), 1, 14)), gen_random_uuid()::text,
                        total, 'INR', methods[1 + k % 6], 'SUCCEEDED', NULL, paid, paid, paid);
            END IF;
        END IF;
    END LOOP;

    -- ------------------------------------------------------------------
    -- 25 open RFQs, each with 2-3 submitted quotations to compare
    -- ------------------------------------------------------------------
    FOR k IN 61 .. 85 LOOP
        b_org := buyers[1 + (k * 5) % n_b];
        SELECT user_id INTO b_user FROM organization_members WHERE organization_id = b_org AND active ORDER BY id LIMIT 1;
        SELECT city INTO v_city FROM organizations WHERE id = b_org;
        m_org := mfrs[1 + (k * 3) % n_m];

        SELECT process_id INTO p_id FROM manufacturer_processes WHERE manufacturer_id = m_org ORDER BY process_id LIMIT 1;
        IF p_id IS NULL THEN SELECT id INTO p_id FROM manufacturing_processes WHERE active ORDER BY id LIMIT 1; END IF;
        SELECT material_id INTO mat_id FROM manufacturer_materials WHERE manufacturer_id = m_org ORDER BY material_id LIMIT 1;
        IF mat_id IS NULL THEN SELECT id INTO mat_id FROM materials WHERE active ORDER BY id LIMIT 1; END IF;

        qty     := (ARRAY[100,250,500,1000,2000])[1 + k % 5];
        created := now() - ((k % 4) || ' days')::interval - ((k % 7) || ' hours')::interval;

        INSERT INTO rfqs (rfq_number, buyer_organization_id, created_by, title, description, process_id, material_id,
                          quantity, quantity_unit, specifications, tolerance_notes, delivery_date, delivery_address,
                          quote_deadline, status, created_at, updated_at)
        VALUES ('RFQ-2026-D' || lpad(k::text, 6, '0'), b_org, b_user, titles[1 + k % 20],
                'Looking for a reliable supplier for a repeat monthly requirement.',
                p_id, mat_id, qty, 'pcs', NULL, 'Critical dimensions marked on drawing; others ISO 2768-m.',
                (now() + interval '45 days')::date, 'Receiving dock, ' || coalesce(v_city, 'Pune'),
                now() + ((3 + k % 6) || ' days')::interval, 'OPEN', created, created)
        RETURNING id INTO rfq_id;

        FOR j IN 0 .. LEAST(n_m, 2 + k % 2) - 1 LOOP
            o_org := mfrs[1 + (k * 3 + j) % n_m];
            SELECT user_id INTO o_user FROM organization_members WHERE organization_id = o_org AND active ORDER BY id LIMIT 1;
            unit_price := round((60 + random() * 900)::numeric, 2);
            setup      := (ARRAY[0,2000,4500])[1 + j % 3];
            subtotal   := round(qty * unit_price + setup, 2);
            tax        := round(subtotal * 0.18, 2);
            INSERT INTO quotations (quotation_number, rfq_id, manufacturer_organization_id, submitted_by, version_number,
                                    unit_price, setup_fee, tax_amount, total_amount, currency, lead_time_days, valid_until,
                                    terms, status, created_at, updated_at)
            VALUES ('QTN-2026-D' || lpad((2000 + k * 10 + j)::text, 6, '0'), rfq_id, o_org, o_user, 1,
                    unit_price, setup, tax, subtotal + tax, 'INR', 10 + j * 6 + k % 9,
                    now() + ((10 + j) || ' days')::interval,
                    (ARRAY['30% advance, 70% before dispatch.','100% against delivery.','50% advance, 50% on delivery.'])[1 + j % 3],
                    'SUBMITTED', created + ((j + 1) || ' hours')::interval, created + ((j + 1) || ' hours')::interval);
        END LOOP;
    END LOOP;

    RAISE NOTICE 'Orders and payments loaded.';
END $$;

COMMIT;

-- Summary
SELECT status, count(*) AS orders FROM production_orders GROUP BY status ORDER BY 2 DESC;
SELECT status, count(*) AS payments, sum(amount) AS total_inr FROM payments GROUP BY status;
SELECT status, count(*) AS rfqs FROM rfqs GROUP BY status;