-- Removes the orders/payments loaded by demo-orders.sql (reference numbers ...-2026-D...).
-- If you later added bookings, batches, shipments etc. to these orders in the app, delete those first
-- or reset the dev database (docker compose down -v, then docker compose up -d).
BEGIN;
DELETE FROM payments WHERE payment_reference LIKE 'PAY-2026-D%';
DELETE FROM production_orders WHERE order_number LIKE 'ORD-2026-D%';
DELETE FROM quotations WHERE quotation_number LIKE 'QTN-2026-D%';
DELETE FROM rfqs WHERE rfq_number LIKE 'RFQ-2026-D%';
COMMIT;