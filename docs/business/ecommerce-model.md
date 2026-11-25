# ForgeTrace – E-commerce Model

## 1. Type
**B2B marketplace** (many buyers ↔ many manufacturers) with **request-for-quotation (RFQ) commerce**:
prices are negotiated per job, not listed in a catalogue.

## 2. Transaction flow
1. Buyer posts RFQ (process, material, quantity, specs, drawings, deadline).
2. System notifies only **verified** manufacturers whose processes + materials match (async, after DB commit).
3. Manufacturers submit quotations (unit price, tax %, lead time, validity). Expired quotes are closed by a scheduled job.
4. Buyer compares and **accepts one** → production order (row lock prevents accepting two quotes at once).
5. Manufacturer books machine time → production → batches → inspection.
6. Buyer **pays** the order total (sandbox gateway).
7. Manufacturer ships (only if paid and ready) → delivered → buyer marks completed → can review.

## 3. Payments
| Aspect | Implementation |
|---|---|
| Gateway | `PaymentGateway` interface; `SandboxPaymentGateway` for demo (card Luhn check, UPI, net banking, wallet). A real gateway (Razorpay/Stripe) = one new class implementing the same interface. |
| No double charge | Every checkout page carries a unique **idempotency key**; the same key returns the original payment (tested – FT-023). |
| Failures | Declined payment stored as FAILED with reason; order stays unpaid; buyer can retry (FT-024). |
| Data protection | Card numbers are never stored or logged; only reference IDs. |
| Concurrency | Order row locked (`PESSIMISTIC_WRITE`) while paying. |
| Production next step | Escrow-style flow: hold funds until delivery confirmed; payout to manufacturer minus commission. |

## 4. Trust & safety
Manufacturer verification by admin · verified-purchase reviews only after a completed order (one per order) ·
dispute process with resolution recorded · recalls with buyer acknowledgement · public passports · full audit log.

## 5. Revenue (proposed)
Commission on completed order value + subscription tiers for manufacturers + traceability add-on (see Business Model Canvas).

## 6. Legal & compliance notes (India)
GST invoices on platform fees · terms & privacy pages (included) · data protection under the DPDP Act 2023 ·
RBI rules apply to holding customer funds (use a licensed payment aggregator rather than holding money directly).