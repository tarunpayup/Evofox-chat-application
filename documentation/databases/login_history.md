# Login History Table Documentation

## Table Information

| Property | Value |
|----------|--------|
| **Table Name** | `login_history` |
| **Purpose** | Stores an audit trail of all user login attempts, including both successful and failed authentication requests. |
| **Primary Key** | `id` |
| **Foreign Key** | `user_id → users.id` (Nullable) |

---

# Description

The `login_history` table records every login attempt made by users. It captures successful logins, failed authentication attempts, client information, IP addresses, and failure reasons.

This table is primarily used for:

- Security auditing
- Login activity monitoring
- Failed login analysis
- Brute-force attack detection
- User activity reporting
- Incident investigation

Unlike the `user_sessions` table, this table is **read-only** after insertion and acts as an immutable audit log.

---

# Schema

| Column | Type | Nullable | Default | Description |
|---------|------|----------|----------|-------------|
| id | INT | No | AUTO_INCREMENT | Primary Key |
| user_id | INT | Yes | NULL | Reference to the user if identified |
| login_value | VARCHAR(150) | Yes | NULL | Username, email, or mobile number entered during login |
| ip_address | VARCHAR(45) | Yes | NULL | Client IP address |
| user_agent | TEXT | Yes | NULL | Browser, operating system, or application details |
| login_status | ENUM('SUCCESS','FAILED') | No | — | Login attempt status |
| failure_reason | VARCHAR(255) | Yes | NULL | Reason for login failure |
| created_at | TIMESTAMP | No | CURRENT_TIMESTAMP | Login attempt timestamp |

---

# Relationships

| Related Table | Relationship |
|---------------|-------------|
| `users` | Many Login Records → One User |

> **Note:** `user_id` may remain `NULL` when the supplied username, email, or phone number does not match any registered user.

---

# Login Activity Lifecycle

```text
User Attempts Login
         │
         ▼
Receive Credentials
         │
         ▼
Validate User
         │
         ▼
Authenticate Password
         │
         ▼
Record Login Attempt
         │
         ├──────────────► SUCCESS
         │
         └──────────────► FAILED
```

---

# Login Attempt Flow

```text
Login Request
      │
      ▼
Validate Input
      │
      ▼
Find User
      │
      ├──────────────► User Not Found
      │                     │
      │                     ▼
      │              Record Failed Login
      │
      ▼
Verify Password
      │
      ├──────────────► Invalid Password
      │                     │
      │                     ▼
      │              Record Failed Login
      │
      ▼
Successful Login
      │
      ▼
Record Successful Login
```

---

# Login Status

| Status | Description |
|--------|-------------|
| **SUCCESS** | User authenticated successfully |
| **FAILED** | Authentication failed |

---

# Common Failure Reasons

| Failure Reason | Description |
|---------------|-------------|
| User not found | No user exists with the supplied login value |
| Invalid password | Password verification failed |
| Email not verified | User account has not completed email verification |
| Account locked | Account is temporarily locked due to multiple failed login attempts |
| Invalid credentials | Authentication failed due to incorrect login information |

---

# Business Rules

- Every login attempt must be recorded.
- Both successful and failed logins are stored.
- Failed login attempts include the failure reason.
- Login history records are never updated after creation.
- Login history should not be deleted except as part of a data retention policy.
- The login value entered by the user is always recorded.
- Unknown users may have a `NULL` value for `user_id`.
- Login history does not represent active sessions.

---

# Constraints

| Constraint | Description |
|------------|-------------|
| Primary Key | `id` |
| Foreign Key | `user_id` references `users.id` |
| Nullable Foreign Key | Allowed for unknown users |

---

# Sample Record (Successful Login)

```json
{
    "id": 101,
    "user_id": 5,
    "login_value": "tarun@gmail.com",
    "ip_address": "192.168.1.25",
    "user_agent": "Android 15 / Chat App v1.0.0",
    "login_status": "SUCCESS",
    "failure_reason": null,
    "created_at": "2026-07-27 19:45:20"
}
```

---

# Sample Record (Failed Login)

```json
{
    "id": 102,
    "user_id": 5,
    "login_value": "tarun@gmail.com",
    "ip_address": "192.168.1.25",
    "user_agent": "Android 15 / Chat App v1.0.0",
    "login_status": "FAILED",
    "failure_reason": "Invalid password",
    "created_at": "2026-07-27 19:48:05"
}
```

---

# API Usage

| API | Purpose |
|-----|---------|
| `login.php` | Records every successful and failed login attempt |

---

# Indexes

| Index | Columns | Purpose |
|-------|---------|---------|
| PRIMARY | `id` | Primary key lookup |
| FOREIGN KEY | `user_id` | User relationship |

---

# Record Lifecycle

```text
User Login Attempt
         │
         ▼
Create Login History Record
         │
         ▼
Permanent Audit Record
         │
         ▼
Available for Reporting & Security Analysis
```

---

# Notes

- This table is intended for auditing and security monitoring.
- Records should be treated as immutable and should not be modified after insertion.
- Historical login data can be used to identify suspicious login patterns or brute-force attacks.
- IP address and user agent information help identify the origin of login attempts.
- The `failure_reason` field simplifies troubleshooting and security investigations.
- This table should not be used for authentication or session validation; active sessions are managed in the `user_sessions` table.
- Depending on organizational policies, old login history records may be archived or purged after the defined retention period.