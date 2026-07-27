# Forgot Password API Documentation

## API Information

| Property | Value |
|----------|--------|
| **API Name** | Forgot Password |
| **Endpoint** | `agencyanalytics.in/api/forgot_password.php` |
| **Method** | `POST` |
| **Authentication** | Not Required |
| **Content-Type** | `application/json` |
| **Response Format** | `application/json` |

---

# Description

Initiates the password reset process by generating a One-Time Password (OTP) for the registered email address. The OTP is stored in the database with an expiration time and sent to the user's verified email address.

Only users with verified email addresses are allowed to request a password reset.

---

# Request Headers

| Header | Value | Required |
|---------|-------|----------|
| Content-Type | application/json | Yes |

---

# Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| email | String | Yes | Registered email address |

---

# Sample Request

```http
POST /api/forgot_password.php
Content-Type: application/json
```

```json
{
    "email": "tarun@gmail.com"
}
```

---

# Success Response

**HTTP Status:** `200 OK`

```json
{
    "status": true,
    "message": "Password reset OTP has been sent to your registered email address."
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

## Email Missing

```json
{
    "status": false,
    "message": "Email is required."
}
```

---

## Invalid Email Address

```json
{
    "status": false,
    "message": "Invalid Email Address."
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
    "message": "Please verify your email first."
}
```

---

## Unable to Send OTP

```json
{
    "status": false,
    "message": "Unable to send password reset OTP."
}
```

---

## Internal Server Error

```json
{
    "status": false,
    "message": "Something went wrong."
}
```

---

# Password Reset Process

After a successful request:

- Any previously generated password reset OTPs for the user are removed.
- A new six-digit OTP is generated.
- The OTP is stored in the `password_reset` table.
- An expiration time is assigned to the OTP.
- A password reset email containing the OTP is sent to the registered email address.

---

# Database Tables Used

| Table | Operation |
|--------|-----------|
| `users` | Validate user account |
| `password_reset` | Store password reset OTP |

---

# Processing Flow

1. Validate HTTP request method.
2. Read JSON request body.
3. Validate the email address.
4. Verify that the user exists.
5. Verify that the email address has been verified.
6. Remove any existing password reset requests for the user.
7. Generate a new six-digit OTP.
8. Set the OTP expiration time.
9. Store the password reset request.
10. Send the password reset email.
11. Return a success response.

---

# Business Rules

- Password reset is allowed only for registered users.
- Email verification is mandatory before requesting a password reset.
- Only one active password reset request is maintained per user.
- Existing password reset requests are removed before creating a new one.
- A new OTP is generated for every password reset request.
- OTPs expire after the configured validity period.
- Password reset emails are sent only to the registered email address.

---

# HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| **200** | Password reset OTP sent successfully |
| **400** | Validation failed |
| **404** | User not found |
| **403** | Email not verified |
| **405** | Invalid HTTP method |
| **500** | Internal server error |

---

# Security Considerations

- Password reset is allowed only for verified accounts.
- OTPs are randomly generated for every request.
- Previous OTPs are invalidated before issuing a new one.
- OTPs have a predefined expiration time.
- SQL Injection protection is implemented using prepared statements.
- Password reset emails are delivered only to the registered email address.
- No password information is exposed in the API response.