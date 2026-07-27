# Verify Reset OTP API Documentation

## API Information

| Property | Value |
|----------|--------|
| **API Name** | Verify Password Reset OTP |
| **Endpoint** | `agencyanalytics.in/api/auth/api/verify_reset_otp.php` |
| **Method** | `POST` |
| **Authentication** | Not Required |
| **Content-Type** | `application/json` |
| **Response Format** | `application/json` |

---

# Description

Validates the One-Time Password (OTP) generated during the password reset process. If the submitted OTP is valid and has not expired, the password reset request is marked as verified, allowing the user to reset their password using the Reset Password API.

This API does **not** change the user's password.

---

# Request Headers

| Header | Value | Required |
|---------|-------|----------|
| Content-Type | `application/json` | Yes |

---

# Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| email | String | Yes | Registered email address |
| otp | String | Yes | Six-digit password reset OTP |

---

# Sample Request

```http
POST /api/verify_reset_otp.php
Content-Type: application/json
```

```json
{
    "email": "tarun@gmail.com",
    "otp": "563812"
}
```

---

# Success Response

**HTTP Status:** `200 OK`

```json
{
    "status": true,
    "message": "OTP verified successfully."
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

## OTP Missing

```json
{
    "status": false,
    "message": "OTP is required."
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

## Password Reset Request Not Found

```json
{
    "status": false,
    "message": "Password reset request not found."
}
```

---

## Invalid OTP

```json
{
    "status": false,
    "message": "Invalid OTP."
}
```

---

## OTP Expired

```json
{
    "status": false,
    "message": "OTP has expired."
}
```

---

## OTP Already Used

```json
{
    "status": false,
    "message": "Password reset request has already been completed."
}
```

---

## OTP Verification Failed

```json
{
    "status": false,
    "message": "Unable to verify OTP."
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

# OTP Verification Process

After successful verification:

- The submitted OTP is validated against the latest password reset request.
- The OTP expiration time is verified.
- The password reset request is marked as **OTP Verified**.
- The verification timestamp is recorded.
- The request becomes eligible for password reset using the Reset Password API.

---

# Database Tables Used

| Table | Operation |
|--------|-----------|
| `users` | Validate user account and email verification status |
| `password_reset` | Validate OTP and mark it as verified |

---

# Processing Flow

1. Validate HTTP request method.
2. Read the JSON request body.
3. Validate the email address.
4. Validate the OTP.
5. Verify that the user exists.
6. Confirm that the email address has been verified.
7. Retrieve the latest password reset request.
8. Check whether the password reset request has already been used.
9. Verify that the submitted OTP matches the stored OTP.
10. Verify that the OTP has not expired.
11. Mark the OTP as verified.
12. Record the OTP verification timestamp.
13. Return a success response.

---

# Business Rules

- Password reset is allowed only for verified email accounts.
- Only the latest password reset OTP is accepted.
- Password reset OTPs expire after the configured validity period.
- OTP verification must be completed before resetting the password.
- A password reset request can be used only once.
- OTP verification does not change the user's password.
- Each successful OTP verification authorizes exactly one password reset operation.

---

# HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| **200** | OTP verified successfully |
| **400** | Validation failed |
| **401** | Invalid or expired OTP |
| **403** | Email not verified |
| **404** | User or password reset request not found |
| **405** | Invalid HTTP method |
| **409** | Password reset request already completed |
| **500** | Internal server error |

---

# Security Considerations

- OTP verification is allowed only for registered and verified users.
- Only the most recently generated OTP is accepted.
- Expired OTPs are rejected.
- Verified OTPs cannot be reused after the password reset process is completed.
- SQL Injection protection is implemented using prepared statements.
- Passwords are never transmitted or modified during OTP verification.
- Sensitive account information is never exposed in API responses.
- OTP verification is required before allowing password reset operations.