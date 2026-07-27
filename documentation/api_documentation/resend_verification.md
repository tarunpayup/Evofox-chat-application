# Resend Verification API Documentation

## API Information

| Property | Value |
|----------|--------|
| **API Name** | Resend Email Verification OTP |
| **Endpoint** | `/api/resend_verification.php` |
| **Method** | `POST` |
| **Authentication** | Not Required |
| **Content-Type** | `application/json` |
| **Response Format** | `application/json` |

---

# Description

Generates and sends a new email verification OTP to a registered user's email address. This API is intended for users who have registered but have not yet verified their email address.

To prevent abuse, OTP resend requests are restricted by a configurable cooldown period.

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

---

# Sample Request

```http
POST /api/resend_verification.php
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
    "message": "Verification OTP has been sent successfully."
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

## Email Already Verified

```json
{
    "status": false,
    "message": "Email is already verified."
}
```

---

## OTP Resend Limit Exceeded

```json
{
    "status": false,
    "message": "Please wait before requesting another verification OTP."
}
```

---

## Unable to Send Verification OTP

```json
{
    "status": false,
    "message": "Unable to send verification email."
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

After a successful request:

- A new six-digit verification OTP is generated.
- The previous verification OTP is replaced.
- A new expiration time is assigned to the OTP.
- The updated OTP is stored in the `email_verifications` table.
- A verification email is sent to the registered email address.

---

# Database Tables Used

| Table | Operation |
|--------|-----------|
| `users` | Validate user account and verification status |
| `email_verifications` | Update verification OTP |

---

# Processing Flow

1. Validate HTTP request method.
2. Read the JSON request body.
3. Validate the email address.
4. Verify that the user exists.
5. Check whether the email has already been verified.
6. Verify that the resend cooldown period has expired.
7. Generate a new six-digit OTP.
8. Update the verification OTP and expiration time.
9. Send the verification email.
10. Return a success response.

---

# Business Rules

- Only registered users can request a new verification OTP.
- Verified accounts cannot request another verification OTP.
- Only one active verification OTP exists per user.
- A resend cooldown period is enforced to prevent excessive requests.
- Every resend request generates a new OTP.
- Previous verification OTPs become invalid immediately.
- Verification OTPs expire after the configured validity period.

---

# HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| **200** | Verification OTP sent successfully |
| **400** | Validation failed |
| **404** | User not found |
| **403** | Email already verified |
| **429** | OTP resend rate limit exceeded |
| **405** | Invalid HTTP method |
| **500** | Internal server error |

---

# Security Considerations

- Verification emails are sent only to registered email addresses.
- A new random OTP is generated for every resend request.
- Previous verification OTPs are invalidated automatically.
- Resend requests are rate-limited to prevent abuse.
- SQL Injection protection is implemented using prepared statements.
- OTP expiration minimizes the risk of unauthorized verification.
- No sensitive user information is returned in the API response.