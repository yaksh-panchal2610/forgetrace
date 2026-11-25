# ForgeTrace – Test Plan

## 1. Objective
Verify that ForgeTrace's business rules, security and integrations work correctly before deployment,
and record defects with root cause and fix.

## 2. Scope
**In scope:** order & batch state machines, batch quantity limits, inspection tolerance rules, passports & QR,
payments (idempotency, failures), shipments, disputes, reports & file export, role-based access, CSRF, CSV safety.
**Out of scope:** load testing at production scale, real payment gateway, cross-browser UI automation.

## 3. Test levels
| Level | Tool | What | Count |
|---|---|---|---|
| Unit – pure logic | JUnit 5, AssertJ, parameterized tests | Enums, gateway, CSV, QR, PDF/CSV export | 39 |
| Unit – services | JUnit 5 + Mockito (repositories mocked) | Payment, Batch, Inspection, Passport, Shipment, Dispute, Report | 38 |
| Integration | `@SpringBootTest` + MockMvc + Spring Security Test + real PostgreSQL | Security rules, redirects, CSRF, 404 passport | 6 |
| System / manual | Browser | Full journeys per role (TC-41 – TC-44) | 4+ |
| CI | GitHub Actions | All automated tests on every push | – |

## 4. Techniques
Equivalence partitioning (valid / invalid card, UPI) · boundary values (batch qty = remaining vs remaining + 1) ·
state-transition testing (order & batch lifecycles) · negative testing (wrong role, missing CSRF, path traversal) ·
mocking external dependencies.

## 5. Environment
Windows 11 · Java 21 (Temurin) · Maven wrapper · PostgreSQL 17 in Docker · tests run with `-Duser.timezone=UTC`.
CI: ubuntu-latest + postgres:17 service container.

## 6. Entry / exit criteria
**Entry:** code compiles, DB migrations V1–V8 apply.
**Exit:** 100 % of automated tests pass · no open Critical/High defects · line coverage of `service` package ≥ [your %] ·
all blueprint test IDs FT-023 – FT-032 covered.

## 7. Results
| Metric | Value |
|---|---|
| Automated tests | 83 |
| Passed / Failed | 83 / 0 |
| Overall line coverage (JaCoCo) | [ % ] |
| `service` package coverage | [ % ] |
| Defects logged | 9 (D-01 – D-09), all closed |

## 8. Risks
| Risk | Mitigation |
|---|---|
| Integration tests depend on local DB | Docker compose for DB; CI uses service container |
| Timezone differences between OS and DB | Force UTC in JVM (app + tests + Docker) |
| Mock-heavy tests miss integration bugs | Integration tests + manual end-to-end journeys |

## 9. Deliverables
`test-cases.md` · `defect-log.md` · JaCoCo HTML report · CI run screenshots · this plan.