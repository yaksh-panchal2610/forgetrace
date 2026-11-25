# ForgeTrace – AWS Monthly Cost Estimate

Region ap-south-1 (Mumbai), On-Demand, 730 hours/month, prices checked November 2026.
Verify final numbers in the AWS Pricing Calculator (calculator.aws) before submission.

## 1. Student / demo deployment (what we run)

| Service | Configuration | Est. USD / month |
|---|---|---|
| EC2 | t4g.small (2 vCPU, 2 GB, ARM) – $0.0112/hr | 8.20 |
| EBS | 20 GB gp3 for EC2 | ~1.90 |
| Public IPv4 | 1 Elastic IP – $0.005/hr | 3.65 |
| RDS PostgreSQL | db.t4g.micro Single-AZ – ~$0.021/hr | ~15.30 |
| RDS storage | 20 GB gp3, 7-day backups (backup ≤ DB size is free) | ~2.70 |
| S3 | < 1 GB files + requests | < 0.10 |
| CloudWatch | ~1 GB logs, 4 alarms | ~1.00 |
| Data transfer out | first 100 GB/month free | 0.00 |
| Domain + TLS | DuckDNS + Let's Encrypt | 0.00 |
| GitHub Actions + GHCR | private repo free minutes / storage | 0.00 |
| **Total** | | **≈ $33 / month (≈ ₹2,800)** |

New AWS accounts (opened after 15 July 2025) receive up to **$200 in Free Tier credits for 6 months**
($100 at sign-up + up to $100 for activities such as launching EC2 and creating an RDS database).
At ~$33/month the credits cover the whole demo period. Stopping EC2 and RDS outside demos lowers it further.

## 2. Small production (first paying customers)

| Service | Configuration | Est. USD / month |
|---|---|---|
| EC2 | 2 × t4g.medium behind an Application Load Balancer | ~33 + ALB ~20 |
| RDS | db.t4g.small **Multi-AZ** (automatic failover) | ~62 |
| RDS storage | 50 GB gp3 | ~7 |
| S3 + CloudFront | 20 GB files + CDN | ~5 |
| CloudWatch, SNS, backups | | ~8 |
| **Total** | | **≈ $135 / month (≈ ₹11,500)** |

## 3. Cost controls in place
- AWS Budget alert at $10 (student) with email at 80 %.
- ARM Graviton (t4g) instances – cheaper than x86 equivalents.
- Single-AZ RDS for the demo; Multi-AZ only when uptime matters.
- Logs retention: set CloudWatch log groups to 14 days.
- Stop EC2/RDS when idle; tear everything down after grading.