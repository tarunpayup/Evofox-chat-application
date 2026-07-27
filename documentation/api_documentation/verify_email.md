# Verify Email API Documentation

## API Information

| Property | Value |
|----------|--------|
| **API Name** | Verify Email |
| **Endpoint** | `agencyanalytics.in/api/auth/api/verify_email.php` |
| **Method** | `POST` |
| **Authentication** | Not Required |
| **Content-Type** | `application/json` |
| **Response Format** | `application/json` |

---

# Description

Verifies a user's email address using the One-Time Password (OTP) sent during the registration process. Upon successful verification, the user's email verification status is updated, the verification timestamp is recorded, and all pending verification OTPs are removed.

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
| otp | String | Yes | Six-digit email verification OTP |

---

# Sample Request

```http
POST /api/verify_email.php
Content-Type: application/json
```

```json
{
    "email": "tarun@gmail.com",
    "otp": "458921"
}
```

---

# Success Response

**HTTP Status:** `200 OK`

```json
{
    "status": true,
    "message": "Email verified successfully."
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

## Email Already Verified

```json
{
    "status": false,
    "message": "Email is already verified."
}
```

---

## Verification Request Not Found

```json
{
    "status": false,
    "message": "Verification request not found."
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

## Email Verification Failed

```json
{
    "status": false,
    "message": "Unable to verify email."
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

# Email Verification Process

After successful verification:

- The user's email verification status is updated.
- The email verification timestamp is recorded.
- All pending verification OTP records are removed.
- The account becomes eligible for authentication.

---

# Database Tables Used

| Table | Operation |
|--------|-----------|
| `users` | Update email verification status |
| `email_verifications` | Validate OTP and remove verification records |

---

# Processing Flow

1. Validate HTTP request method.
2. Read the JSON request body.
3. Validate the email address.
4. Validate the OTP.
5. Verify that the user exists.
6. Check whether the email is already verified.
7. Retrieve the latest email verification request.
8. Verify that the submitted OTP matches the stored OTP.
9. Verify that the OTP has not expired.
10. Start a database transaction.
11. Update the user's email verification status.
12. Record the email verification timestamp.
13. Remove all verification OTP records for the user.
14. Commit the transaction.
15. Return a success response.

---

# Business Rules

- Email verification is mandatory before user login.
- Only the latest verification OTP is accepted.
- Verification OTPs expire after the configured validity period.
- Each verification OTP can be used only once.
- After successful verification, all pending verification OTPs are deleted.
- An already verified account cannot be verified again.
- Database operations are executed within a transaction.

---

# HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| **200** | Email verified successfully |
| **400** | Validation failed |
| **401** | Invalid or expired OTP |
| **404** | User or verification request not found |
| **405** | Invalid HTTP method |
| **409** | Email already verified |
| **500** | Internal server error |

---

# Security Considerations

- Email verification is performed only for registered users.
- Only the latest generated OTP is considered valid.
- Expired OTPs cannot be used.
- Verification records are removed after successful verification.
- SQL Injection protection is implemented using prepared statements.
- Database transactions ensure data consistency.
- Sensitive account information is never returned in API responses.
- Verified accounts are protected against duplicate verification attempts.