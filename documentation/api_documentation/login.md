# Login API Documentation

## API Information

| Property | Value |
|----------|--------|
| **API Name** | User Login |
| **Endpoint** | `agencyanalytics.in/api/auth/api/login.php` | 
| **Method** | `POST` |
| **Authentication** | Not Required |
| **Content-Type** | `application/json` |
| **Response Format** | `application/json` |

---

# Description

Authenticates a user using their **Username**, **Email Address**, or **Mobile Number** along with their password.

Upon successful authentication, a new authenticated session is created, an authentication token is generated, the user's online status is updated, and the login activity is recorded.

---

# Request Headers

| Header | Value | Required |
|---------|-------|----------|
| Content-Type | application/json | Yes |

---

# Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| login | String | Yes | Username, Email Address, or Mobile Number |
| password | String | Yes | User account password |
| device_type | String | No | Device platform (Android, iOS, Web, Windows, macOS, Linux, etc.) |
| device_token | String | No | Push notification device token |

---

# Sample Request

```http
POST /api/login.php
Content-Type: application/json
```

```json
{
    "login": "tarun@gmail.com",
    "password": "Password@123",
    "device_type": "Android",
    "device_token": "fcm_device_token_here"
}
```

---

# Success Response

**HTTP Status:** `200 OK`

```json
{
    "status": true,
    "message": "Login Successful.",
    "data": {
        "user_id": 15,
        "uuid": "USR_66B7A9C23FA91",
        "full_name": "Tarun Bansal",
        "username": "tarunbansal",
        "email": "tarun@gmail.com",
        "phone": "9876543210",
        "profile_photo": "uploads/profile/profile.jpg",
        "bio": "Hey there! I am using Chat App.",
        "status": "Online",
        "auth_token": "2d57f872f5f3d5d2ea4fdbf36a5d87dcfd7db3d3..."
    }
}
```

---

# Error Responses

## Invalid Request Method

```json
{
    "status": false,
    "message": "Invalid Request Method"
}
```

---

## Login Field Missing

```json
{
    "status": false,
    "message": "Username, Email or Phone is required."
}
```

---

## Password Missing

```json
{
    "status": false,
    "message": "Password is required."
}
```

---

## User Not Found

```json
{
    "status": false,
    "message": "User not found."
}
```

---

## Email Not Verified

```json
{
    "status": false,
    "message": "Please verify your email before login."
}
```

---

## Invalid Password

```json
{
    "status": false,
    "message": "Invalid Password."
}
```

---

## Account Locked

```json
{
    "status": false,
    "message": "Account is temporarily locked. Please try again later."
}
```

---

## Internal Server Error

```json
{
    "status": false,
    "message": "Unable to login."
}
```

---

# Authentication Token

On successful login, an authentication token is generated and stored in the `user_sessions` table.

The client application must securely store this token and include it in authenticated API requests.

---

# Database Tables Used

| Table | Operation |
|--------|-----------|
| `users` | Validate credentials, update login status, reset failed attempts |
| `user_sessions` | Create authenticated session |
| `login_history` | Store login audit log |

---

# Processing Flow

1. Validate HTTP request method.
2. Read JSON request body.
3. Validate required fields.
4. Search user using Username, Email, or Mobile Number.
5. Verify account existence.
6. Verify email verification status.
7. Check account lock status.
8. Verify password using password hash.
9. Reset failed login attempts after successful authentication.
10. Generate secure authentication token.
11. Create user session.
12. Update user online status.
13. Store login history.
14. Return authenticated user information.

---

# Business Rules

- Login supports Username, Email Address, or Mobile Number.
- Passwords are verified using PHP Password Hash API.
- Email verification is mandatory before login.
- Five consecutive failed login attempts temporarily lock the account.
- Failed login attempts are reset after successful authentication.
- Every successful login generates a new authentication token.
- Multiple active sessions are supported.
- Every login attempt is recorded in the login history.
- User status is updated to **Online** after successful authentication.

---

# HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| **200** | Login successful |
| **400** | Validation failed |
| **401** | Invalid credentials |
| **403** | Email not verified or account locked |
| **405** | Invalid HTTP method |
| **500** | Internal server error |

---

# Security Considerations

- Passwords are never returned in API responses.
- Password verification uses `password_verify()`.
- Authentication tokens are generated using cryptographically secure random values.
- SQL Injection protection is implemented using prepared statements.
- Login history is maintained for security auditing.
- Device information is stored for session management.
- Account lock mechanism protects against brute-force attacks.