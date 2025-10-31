# Booking → Stripe (Free, Optional)

This module is **optional** and runs beside the app. It gives you:
- Easy!Appointments (booking UI)
- Node-RED (flows)
- MariaDB
- Stripe invoice creation + payment status writeback

No changes to the Django app.

⚠️ **Security Note**: Change all default passwords (`change-me`) in `docker-compose.yml` before production use. Set your Stripe API keys securely.

## Quick start
1) Install Docker Desktop (Windows).
2) Open PowerShell in this folder: `integrations/booking-stack/`
3) `docker compose up -d`
4) Visit http://localhost:8080 and finish Easy!Appointments installer:
   - Host: db  |  DB: easyappt  |  User: eauser  |  Pass: change-me
5) Run the DB patch:

```
docker compose cp ./sql/alter_ea.sql db:/alter_ea.sql
docker compose exec db bash -lc "mariadb -u eauser -pchange-me easyappt -e \"SOURCE /alter_ea.sql\""
```

6) Set Stripe secrets in `docker-compose.yml` (nodered service), then:

```
docker compose up -d
```

## Configure services
Create services in Easy!Appointments with names that start with the code:
- `SOLO30 – Solo Walk (30m)`
- `SOLO60 – Solo Walk (60m)`
- `GROUP30 – Group Walk (30m)`
- `GROUP60 – Group Walk (60m)`

Update prices in `nodered/flows.json` → node "Map EA → Stripe" → `PRICE_MAP` (amounts are cents).

## Webhooks
- Easy!Appointments (Admin → Webhooks):
  - POST `https://YOUR_PUBLIC_FLOWS_DOMAIN/webhooks/ea` for "Appointment Created"
- Stripe Dashboard → Webhooks:
  - URL `https://YOUR_PUBLIC_FLOWS_DOMAIN/webhooks/stripe`
  - Events: `invoice.finalized`, `invoice.sent`, `invoice.payment_succeeded`, `invoice.voided`

Use Cloudflare Tunnel or a reverse proxy to publish:
- `bookings.YOURDOMAIN.com` → `http://localhost:8080`
- `flows.YOURDOMAIN.com`    → `http://localhost:1880`
