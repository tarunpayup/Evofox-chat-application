# Users Table Documentation

## Table Information

| Property | Value |
|----------|--------|
| **Table Name** | `users` |
| **Purpose** | Stores all registered user accounts. |
| **Primary Key** | `id` |
| **Unique Keys** | `uuid`, `username`, `email`, `phone` |

---

# Description

The `users` table is the master table containing profile information, authentication details, account status, and security information for every registered user.

---

# Schema

| Column | Type | Nullable | Default | Description |
|---------|------|----------|----------|-------------|
| id | INT | No | AUTO_INCREMENT | Primary Key |
| uuid | VARCHAR(80) | No | — | Globally unique user identifier |
| full_name | VARCHAR(100) | No | — | User's full name |
| username | VARCHAR(50) | No | — | Unique username |
| email | VARCHAR(150) | No | — | Registered email |
| phone | VARCHAR(20) | No | — | Registered mobile number |
| password | VARCHAR(255) | No | — | Hashed password |
| profile_photo | VARCHAR(255) | Yes | NULL | Profile image path |
| bio | VARCHAR(255) | No | "Hey there! I am using Chat App." | User bio |
| email_verified | TINYINT(1) | No | 0 | Email verification status |
| email_verified_at | DATETIME | Yes | NULL | Verification timestamp |
| status | ENUM('Online','Offline') | No | Offline | Current user status |
| last_seen | DATETIME | Yes | NULL | Last active time |
| failed_login_attempts | INT | No | 0 | Failed login counter |
| account_locked_until | DATETIME | Yes | NULL | Account lock expiration |
| created_at | TIMESTAMP | No | CURRENT_TIMESTAMP | Record creation time |
| updated_at | TIMESTAMP | No | CURRENT_TIMESTAMP | Last update time |

---

# Relationships

| Related Table | Relationship |
|---------------|-------------|
| email_verifications | One User → Many Verification Records |
| password_reset | One User → Many Password Reset Requests |
| user_sessions | One User → Many Sessions |
| login_history | One User → Many Login Logs |

---

# Business Rules

- Username must be unique.
- Email must be unique.
- Mobile number must be unique.
- Password must always be hashed.
- Email verification is mandatory before login.
- User status is either Online or Offline.
- Failed login attempts are tracked.
- Account lock is temporary.
- UUID never changes.

---

# Sample Record

```json
{
    "id": 1,
    "uuid": "USR_66B7A9C23FA91",
    "full_name": "Tarun Bansal",
    "username": "tarunbansal",
    "email": "tarun@gmail.com",
    "phone": "9876543210",
    "profile_photo": null,
    "bio": "Hey there! I am using Chat App.",
    "email_verified": 1,
    "email_verified_at": "2026-07-27 10:30:45",
    "status": "Online",
    "last_seen": "2026-07-27 19:15:10",
    "failed_login_attempts": 0,
    "account_locked_until": null,
    "created_at": "2026-07-27 09:20:30",
    "updated_at": "2026-07-27 19:15:10"
}
```