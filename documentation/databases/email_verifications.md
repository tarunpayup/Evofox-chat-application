# Email Verifications Table Documentation

## Table Information

| Property | Value |
|----------|--------|
| **Table Name** | `email_verifications` |
| **Purpose** | Stores email verification OTPs generated during user registration and email verification requests. |
| **Primary Key** | `id` |
| **Foreign Key** | `user_id → users.id` |

---

# Description

The `email_verifications` table stores One-Time Passwords (OTPs) generated for verifying a user's email address. Each OTP has an expiration time and is linked to a specific user account.

This table is used during:

- New User Registration
- Email Verification
- Resend Verification OTP

Once an email is successfully verified, all associated OTP records are removed from this table.

---

# Schema

| Column | Type | Nullable | Default | Description |
|---------|------|----------|----------|-------------|
| id | INT | No | AUTO_INCREMENT | Primary Key |
| user_id | INT | No | — | Reference to the registered user |
| email | VARCHAR(150) | Yes | NULL | Email address associated with the verification request |
| otp | VARCHAR(6) | Yes | NULL | Six-digit verification OTP |
| expires_at | DATETIME | Yes | NULL | OTP expiration date and time |
| verified_at | DATETIME | Yes | NULL | Date and time when the email was successfully verified |
| created_at | TIMESTAMP | No | CURRENT_TIMESTAMP | Record creation timestamp |

---

# Relationships

| Related Table | Relationship |
|---------------|-------------|
| `users` | Many Verification Records → One User |

---

# Verification Lifecycle

```text
User Registration
        │
        ▼
Generate Verification OTP
        │
        ▼
Store OTP in email_verifications
        │
        ▼
Send Verification Email
        │
        ▼
User Enters OTP
        │
        ▼
Verify OTP
        │
        ▼
Update users.email_verified
        │
        ▼
Delete Verification Record(s)
```

---

# OTP Lifecycle

```text
Generate OTP
      │
      ▼
Store OTP
      │
      ▼
Send Email
      │
      ▼
OTP Valid Until expires_at
      │
      ├──────────────► Expired
      │
      ▼
Verify OTP
      │
      ▼
Email Verified
      │
      ▼
Delete OTP Record(s)
```

---

# Business Rules

- Every OTP belongs to exactly one user.
- Email verification OTPs are six digits.
- OTPs expire after the configured validity period.
- Only the latest generated OTP should be accepted.
- A verified email cannot request another verification OTP.
- Previous OTPs become invalid after a new OTP is generated.
- Verification records are removed after successful email verification.
- OTP verification updates the user's `email_verified` status in the `users` table.

---

# Constraints

| Constraint | Description |
|------------|-------------|
| Primary Key | `id` |
| Foreign Key | `user_id` references `users.id` |
| Cascade Policy | Application-managed |

---

# Sample Record

```json
{
    "id": 12,
    "user_id": 5,
    "email": "tarun@gmail.com",
    "otp": "458921",
    "expires_at": "2026-07-27 19:30:00",
    "verified_at": null,
    "created_at": "2026-07-27 19:20:05"
}
```

---

# API Usage

| API | Purpose |
|-----|---------|
| `register.php` | Creates a verification OTP during user registration |
| `resend_verification.php` | Generates and stores a new verification OTP |
| `verify_email.php` | Validates the OTP and completes email verification |

---

# Indexes

| Index | Columns | Purpose |
|-------|---------|---------|
| PRIMARY | `id` | Primary key lookup |
| FOREIGN KEY | `user_id` | User relationship |

---

# Record Lifecycle

```text
Registration
      │
      ▼
Insert Verification Record
      │
      ▼
Email Sent
      │
      ├──────────────► OTP Expired
      │
      ▼
Email Verified
      │
      ▼
Delete Verification Record(s)
```

---

# Notes

- This table stores only temporary email verification data.
- OTP values should never be reused.
- Expired OTPs should be periodically cleaned up using a scheduled background job.
- Verification requests are linked to a registered user through the `user_id` foreign key.
- The `verified_at` column records the successful verification timestamp before the verification records are removed, if applicable to the implementation.
- This table should never be used for user authentication or session management.
```**