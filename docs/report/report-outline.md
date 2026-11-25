# ForgeTrace – Final Report Outline

1. **Title page, certificate, acknowledgement, abstract** (abstract ≤ 250 words)
2. **Introduction** – problem, objectives, scope, team roles
3. **Requirements** – functional requirements per role, non-functional (security, performance, availability), use-case diagram
4. **System design**
   4.1 Architecture diagram (README) · 4.2 ER diagram (generate from DB: DBeaver → ER Diagram) ·
   4.3 Class diagram of key hierarchies (entities, exceptions, storage, exporters) ·
   4.4 State diagrams (order, batch) · 4.5 Sequence diagram: accept quotation & payment
5. **Implementation (Java)**
   5.1 OOP – inheritance, abstraction, polymorphism, encapsulation (with code snippets)
   5.2 Custom exceptions & global handling · 5.3 Multithreading & concurrency · 5.4 File save/load (CSV, PDF, QR, S3)
   5.5 Security (Spring Security, BCrypt, CSRF, role checks, 404-not-403 rule) · 5.6 Screenshots of each portal
6. **Testing** – test plan, 44 test cases table, 83 automated tests, JaCoCo screenshot, defect log (9 defects)
7. **Cloud deployment** – Docker, AWS architecture, IAM least privilege, S3, RDS, HTTPS, CloudWatch, CI/CD pipeline screenshots, cost estimate
8. **E-commerce & startup** – e-commerce model, Business Model Canvas, Lean Canvas, market sizing, revenue model, pitch summary
9. **Conclusion & future work** – real gateway + escrow, mobile app, analytics, multi-region
10. **References** – Spring docs, AWS docs, PostgreSQL docs, market sources (cite every number)
11. **Appendix** – setup guide, API endpoints, test case list

## Requirement → evidence checklist
| Assignment requirement | Evidence in project | Screenshot / file |
|---|---|---|
| OOP & inheritance | `entity/base`, `exception/` hierarchy | class diagram |
| Custom exceptions | 14 exception classes + handlers | code snippet |
| Multithreading | `AsyncConfig`, `ManufacturerNotifier`, `ReportTaskRunner` | terminal log “finished on task-1” |
| File save/load | CSV import/export, PDF reports, uploads | report download |
| 30+ test cases | `test-cases.md` (44) | table |
| JUnit | 83 tests | `BUILD SUCCESS` screenshot |
| JaCoCo | `target/site/jacoco` | coverage screenshot |
| Defect log | `defect-log.md` | table |
| Docker | `Dockerfile`, compose | `docker run` screenshot |
| AWS + managed DB | EC2, RDS | console screenshots |
| IAM | `iam-ec2-policy.json`, role | IAM role screenshot |
| S3 | file storage | bucket object screenshot |
| HTTPS | Nginx + Let's Encrypt | browser padlock |
| Monitoring | CloudWatch logs + alarms | log group + alarm screenshot |
| CI/CD | `.github/workflows/ci-cd.yml` | Actions run screenshot |
| Cost estimate | `cost-estimate.md` | table |
| E-commerce | `ecommerce-model.md`, payment flow | checkout screenshots |
| Startup docs | BMC, Lean Canvas, pitch deck | canvases |