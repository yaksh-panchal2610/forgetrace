# ForgeTrace – AWS Deployment Guide

Region: **ap-south-1 (Mumbai)** · Server: EC2 t4g.small (ARM) · DB: RDS PostgreSQL 17 · Files: S3 · TLS: Let's Encrypt

## A. Put the code on GitHub
1. Create an empty repo `forgetrace` on github.com (Private is fine).
2. In the project folder:
   git init
   git add .
   git commit -m "ForgeTrace initial"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/forgetrace.git
   git push -u origin main
3. GitHub → **Actions** tab: the `test` and `docker` jobs run (deploy fails until step K – that is expected).
4. 📸 Screenshot: green `test` + `docker` jobs.

## B. Protect the AWS account
1. Sign in as root once → enable **MFA** on root.
2. IAM → create user `yourname-admin` (AdministratorAccess) with MFA; use it from now on, never root.
3. Billing → **Budgets** → create a **$10 monthly cost budget** with email alert at 80 %.

## C. S3 bucket (uploaded files, QR images)
1. S3 → Create bucket `forgetrace-files-yourname` in ap-south-1.
2. Keep **Block all public access = ON**. Default encryption **SSE-S3**. Enable **Versioning**.

## D. IAM role for the server (no access keys anywhere)
1. IAM → Policies → Create → JSON → paste `deploy/aws/iam-ec2-policy.json` (replace bucket name) → name `ForgeTraceEc2Policy`.
2. IAM → Roles → Create → **AWS service: EC2** → attach `ForgeTraceEc2Policy` → name `forgetrace-ec2-role`.
   The AWS SDK on the server picks up this role automatically.

## E. Security groups (firewall)
| Name | Inbound rules |
|------|---------------|
| `forgetrace-web` | 80 and 443 from 0.0.0.0/0 · 22 from **My IP** only |
| `forgetrace-db`  | 5432 from **security group `forgetrace-web`** only |

## F. RDS PostgreSQL
1. RDS → Create database → **Standard create** → PostgreSQL **17**.
2. Template **Free tier / Dev-Test**, instance **db.t4g.micro**, storage 20 GB gp3.
3. Master username `forgetrace_app`, strong password (save it).
4. Initial database name: `forgetrace`. **Public access: No**. Security group: `forgetrace-db`.
5. Backups: 7 days. Encryption: enabled.
6. Copy the **Endpoint** after it is "Available". Flyway creates all tables on first start.

## G. EC2 server
1. EC2 → Launch instance: **Amazon Linux 2023 (64-bit Arm)**, type **t4g.small**, 20 GB gp3.
2. Key pair: create `forgetrace-key` (.pem) – keep it safe, never commit it.
3. Security group `forgetrace-web`. Advanced → IAM instance profile: `forgetrace-ec2-role`.
4. EC2 → **Elastic IPs** → Allocate → Associate with the instance (fixed public IP).

## H. Free domain name
1. https://www.duckdns.org → sign in → add subdomain e.g. `forgetrace-yourname`.
2. Set its IP to your **Elastic IP**. Your domain is `forgetrace-yourname.duckdns.org`.

## I. Prepare the server
From your PC (PowerShell, in the folder with the .pem):
   scp -i forgetrace-key.pem deploy/ec2-setup.sh ec2-user@ELASTIC_IP:~
   ssh -i forgetrace-key.pem ec2-user@ELASTIC_IP
On the server:
   bash ec2-setup.sh forgetrace-yourname.duckdns.org you@example.com
   exit          # log out and back in so the docker group applies

## J. Create the server's .env
1. On your PC, list every variable your prod config needs:
   Select-String -Path src\main\resources\application-prod.properties -Pattern '\$\{([A-Z0-9_]+)' -AllMatches |
     ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
2. On the server: `nano /opt/forgetrace/.env` → paste `deploy/.env.prod.example`, fill real values,
   and add one line for **each** variable printed above (S3 bucket, admin email/password …).
3. `chmod 600 /opt/forgetrace/.env`

## K. Connect GitHub to the server
GitHub repo → Settings → **Environments** → New `production`, then Settings → Secrets and variables → Actions → New repository secret:
| Secret | Value |
|--------|-------|
| `EC2_HOST` | Elastic IP |
| `EC2_USER` | `ec2-user` |
| `EC2_SSH_KEY` | full content of `forgetrace-key.pem` |

Actions → **CI/CD** → *Run workflow*. All three jobs turn green. 📸 Screenshot.

## L. Verify
- https://forgetrace-yourname.duckdns.org → padlock 🔒 in browser. 📸
- http:// … redirects to https://.
- https://…/actuator/health → `{"status":"UP"}`. 📸
- https://…/actuator/env → 404 (blocked by Nginx).
- Upload an RFQ drawing → S3 bucket shows the object. 📸
- Sign in as admin, change the seeded admin password immediately.

## M. Monitoring (CloudWatch)
1. CloudWatch → **Log groups** → `/forgetrace/app` and `/forgetrace/nginx` already receive logs. 📸
2. SNS → Create topic `forgetrace-alerts` → email subscription → confirm the email.
3. CloudWatch → Alarms → create (action: SNS topic):
   - EC2 `CPUUtilization` > 80 % for 10 min
   - EC2 `StatusCheckFailed` ≥ 1 for 2 min
   - RDS `FreeStorageSpace` < 2 GB
   - RDS `CPUUtilization` > 80 % for 10 min
4. Optional: CloudWatch → Logs Insights query
   `fields @timestamp, @message | filter @message like /ERROR/ | sort @timestamp desc | limit 50` 📸

## N. Saving credits
- Not demoing? EC2 → **Stop** instance; RDS → **Stop temporarily** (auto-restarts after 7 days).
- Elastic IP is billed while associated; keep it so the domain stays valid.
- After grading: delete RDS (final snapshot optional), terminate EC2, release Elastic IP, empty+delete S3 bucket.

## Security summary (for the report)
HTTPS only (TLS 1.2/1.3, HSTS) · RDS private, reachable only from the web security group · IAM role with least-privilege policy (one bucket, one log-group prefix) · no AWS keys in code or env · secrets only in server `.env` (chmod 600) and GitHub Secrets · S3 private + encrypted + versioned · actuator endpoints blocked except health · app runs as non-root user in the container · SSH only from your IP.