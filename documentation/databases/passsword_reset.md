# Password Reset Table Documentation

## Table Information

| Property | Value |
|----------|--------|
| **Table Name** | `password_reset` |
| **Purpose** | Stores One-Time Password (OTP) requests used for resetting user passwords. |
| **Primary Key** | `id` |
| **Foreign Key** | `user_id → users.id` |

---

# Description

The `password_reset` table stores password reset requests generated when a user initiates the **Forgot Password** process.

Each password reset request contains a unique OTP, its expiration time, verification status, and usage status. Once the password is successfully reset, the request is marked as used and cannot be reused.

---

# Schema

| Column | Type | Nullable | Default | Description |
|---------|------|----------|----------|-------------|
| id | INT | No | AUTO_INCREMENT | Primary Key |
| user_id | INT | No | — | Reference to the registered user |
| otp | VARCHAR(6) | No | — | Six-digit password reset OTP |
| otp_verified | TINYINT(1) | No | 0 | Indicates whether the OTP has been successfully verified |
| otp_verified_at | DATETIME | Yes | NULL | Timestamp when the OTP was verified |
| expires_at | DATETIME | No | — | OTP expiration date and time |
| used_at | DATETIME | Yes | NULL | Timestamp when the password reset request was completed |
| created_at | TIMESTAMP | No | CURRENT_TIMESTAMP | Record creation timestamp |

---

# Relationships

| Related Table | Relationship |
|---------------|-------------|
| `users` | Many Password Reset Requests → One User |

---

# Password Reset Lifecycle

```text
Forgot Password Request
          │
          ▼
Generate OTP
          │
          ▼
Store OTP
          │
          ▼
Send OTP via Email
          │
          ▼
User Enters OTP
          │
          ▼
Verify OTP
          │
          ▼
OTP Verified
          │
          ▼
Reset Password
          │
          ▼
Mark Request as Used
```

---

# OTP Lifecycle

```text
Generate OTP
      │
      ▼
Store Request
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
otp_verified = 1
      │
      ▼
Reset Password
      │
      ▼
used_at = NOW()
```

---

# Request Status Flow

| Stage | otp_verified | used_at | Description |
|--------|--------------|----------|-------------|
| OTP Generated | 0 | NULL | Waiting for OTP verification |
| OTP Verified | 1 | NULL | Password can now be reset |
| Password Reset Completed | 1 | NOT NULL | Request completed and cannot be reused |

---

# Business Rules

- Password reset is allowed only for registered users.
- Only one active password reset request should exist per user.
- Each OTP consists of six digits.
- OTPs expire after the configured validity period.
- Only the latest password reset request is considered valid.
- OTP verification must be completed before resetting the password.
- A password reset request can be used only once.
- After successful password reset, the request is permanently marked as used.
- A new password reset request invalidates any previous pending request.

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
    "id": 18,
    "user_id": 5,
    "otp": "563812",
    "otp_verified": 1,
    "otp_verified_at": "2026-07-27 19:35:10",
    "expires_at": "2026-07-27 19:45:00",
    "used_at": null,
    "created_at": "2026-07-27 19:30:15"
}
```

---

# API Usage

| API | Purpose |
|-----|---------|
| `forgot_password.php` | Generates and stores a password reset OTP |
| `verify_reset_otp.php` | Verifies the password reset OTP |
| `reset_password.php` | Updates the user's password and marks the request as completed |

---

# Indexes

| Index | Columns | Purpose |
|-------|---------|---------|
| PRIMARY | `id` | Primary key lookup |
| FOREIGN KEY | `user_id` | User relationship |

---

# Record Lifecycle

```text
Forgot Password
        │
        ▼
Insert Password Reset Request
        │
        ▼
OTP Sent to User
        │
        ├──────────────► OTP Expired
        │
        ▼
OTP Verified
        │
        ▼
Password Reset
        │
        ▼
Mark Request as Used
```

---

# Notes

- This table stores only temporary password reset requests.
- OTP values should never be reused.
- Password reset requests should expire automatically after the configured validity period.
- Used requests must never be accepted again.
- Expired or completed requests can be periodically removed using a scheduled cleanup job.
- This table does not store passwords; it only manages the password reset workflow.
- Password updates are performed exclusively in the `users` table after successful OTP verification.