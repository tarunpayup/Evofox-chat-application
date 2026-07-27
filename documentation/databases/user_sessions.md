# User Sessions Table Documentation

## Table Information

| Property | Value |
|----------|--------|
| **Table Name** | `user_sessions` |
| **Purpose** | Stores authenticated user sessions and manages active login sessions across multiple devices. |
| **Primary Key** | `id` |
| **Foreign Key** | `user_id → users.id` |

---

# Description

The `user_sessions` table maintains all authenticated user sessions created after a successful login.

Each login generates a unique authentication token that represents an authenticated session. The table also stores device information, IP address, login time, logout time, session expiration, and session status.

This table enables support for:

- Multi-device login
- Session management
- User authentication
- Session invalidation
- Device tracking

---

# Schema

| Column | Type | Nullable | Default | Description |
|---------|------|----------|----------|-------------|
| id | INT | No | AUTO_INCREMENT | Primary Key |
| user_id | INT | No | — | Reference to the authenticated user |
| auth_token | VARCHAR(255) | No | — | Unique authentication token |
| device_type | VARCHAR(30) | Yes | NULL | Device platform (Android, iOS, Web, Windows, macOS, Linux, etc.) |
| device_token | TEXT | Yes | NULL | Push notification device token |
| ip_address | VARCHAR(45) | Yes | NULL | Client IP address |
| user_agent | TEXT | Yes | NULL | Browser or application information |
| login_at | DATETIME | Yes | NULL | Login timestamp |
| expires_at | DATETIME | Yes | NULL | Session expiration time |
| logout_at | DATETIME | Yes | NULL | Logout timestamp |
| is_active | TINYINT | No | 1 | Session status (1 = Active, 0 = Inactive) |

---

# Relationships

| Related Table | Relationship |
|---------------|-------------|
| `users` | One User → Many Sessions |

---

# Session Lifecycle

```text
User Login
     │
     ▼
Generate Authentication Token
     │
     ▼
Create User Session
     │
     ▼
Authenticated API Requests
     │
     ▼
Session Active
     │
     ├──────────────► Session Expired
     │
     ├──────────────► User Logout
     │
     ├──────────────► Password Reset
     │
     ▼
Session Deactivated
```

---

# Authentication Flow

```text
Login
   │
   ▼
Validate Credentials
   │
   ▼
Generate Auth Token
   │
   ▼
Insert Session
   │
   ▼
Client Stores Token
   │
   ▼
Authenticated Requests
   │
   ▼
Validate Token
   │
   ▼
Authorized Access
```

---

# Session States

| Status | is_active | Description |
|---------|-----------|-------------|
| Active | 1 | User session is valid and authenticated |
| Logged Out | 0 | User explicitly logged out |
| Expired | 0 | Session validity period has expired |
| Revoked | 0 | Session invalidated due to password reset or administrative action |

---

# Business Rules

- Every successful login creates a new authenticated session.
- Multiple active sessions are allowed for the same user.
- Every session has a unique authentication token.
- Authentication tokens must never be duplicated.
- Sessions can be invalidated individually or collectively.
- Password reset invalidates all active sessions.
- Device information is stored for every login.
- Push notification tokens are associated with the session.
- Expired sessions must not be accepted for authentication.

---

# Constraints

| Constraint | Description |
|------------|-------------|
| Primary Key | `id` |
| Unique Key | `auth_token` |
| Foreign Key | `user_id` references `users.id` |
| Cascade Policy | Application-managed |

---

# Sample Record

```json
{
    "id": 35,
    "user_id": 5,
    "auth_token": "2d57f872f5f3d5d2ea4fdbf36a5d87dcfd7db3d3e6e8d93f",
    "device_type": "Android",
    "device_token": "fcm_device_token_123456789",
    "ip_address": "192.168.1.25",
    "user_agent": "Android 15 / Chat App v1.0.0",
    "login_at": "2026-07-27 19:40:15",
    "expires_at": "2026-08-26 19:40:15",
    "logout_at": null,
    "is_active": 1
}
```

---

# API Usage

| API | Purpose |
|-----|---------|
| `login.php` | Creates a new authenticated session |
| `reset_password.php` | Invalidates all active sessions after password reset |
| `logout.php` *(Future)* | Marks the current session as logged out |
| `refresh_token.php` *(Future)* | Renews or extends an existing authenticated session |

---

# Indexes

| Index | Columns | Purpose |
|-------|---------|---------|
| PRIMARY | `id` | Primary key lookup |
| UNIQUE | `auth_token` | Fast authentication token validation |
| FOREIGN KEY | `user_id` | User relationship |

---

# Record Lifecycle

```text
Successful Login
        │
        ▼
Create Session
        │
        ▼
Active Session
        │
        ├──────────────► User Logout
        │
        ├──────────────► Session Expired
        │
        ├──────────────► Password Reset
        │
        ▼
Mark Session Inactive
```

---

# Notes

- Each authentication token uniquely identifies one authenticated session.
- Authentication middleware should validate both the authentication token and the session's active status.
- Device tokens should be updated whenever a user logs in from a new device.
- Inactive sessions should not be accepted for API authentication.
- Session expiration should be enforced by the application or scheduled cleanup jobs.
- Historical session records may be retained for auditing and security analysis.
- The `user_sessions` table should never store passwords or sensitive user credentials.