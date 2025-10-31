ALTER TABLE ea_appointments
  ADD COLUMN stripe_invoice_id VARCHAR(64) NULL,
  ADD COLUMN payment_status VARCHAR(16) NULL;
