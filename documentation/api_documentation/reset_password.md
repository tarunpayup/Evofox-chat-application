# Reset Password API Documentation

## API Information

| Property | Value |
|----------|--------|
| **API Name** | Reset Password |
| **Endpoint** | `agencyanalytics.in/api/auth/api/reset_password.php` |
| **Method** | `POST` |
| **Authentication** | Not Required |
| **Content-Type** | `application/json` |
| **Response Format** | `application/json` |

---

# Description

Resets the user's account password after successful OTP verification. The API validates the password reset request, updates the user's password with a securely hashed value, marks the password reset request as completed, invalidates all active user sessions, and requires the user to log in again.

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
| new_password | String | Yes | New account password |
| confirm_password | String | Yes | Confirmation of the new password |

---

# Sample Request

```http
POST /api/reset_password.php
Content-Type: application/json
```

```json
{
    "email": "tarun@gmail.com",
    "new_password": "Password@123",
    "confirm_password": "Password@123"
}
```

---

# Success Response

**HTTP Status:** `200 OK`

```json
{
    "status": true,
    "message": "Password has been reset successfully. Please login again."
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

## New Password Missing

```json
{
    "status": false,
    "message": "New Password is required."
}
```

---

## Confirm Password Missing

```json
{
    "status": false,
    "message": "Confirm Password is required."
}
```

---

## Password Too Short

```json
{
    "status": false,
    "message": "Password must be at least 8 characters."
}
```

---

## Passwords Do Not Match

```json
{
    "status": false,
    "message": "Passwords do not match."
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

## Password Reset Request Not Found

```json
{
    "status": false,
    "message": "Password reset request not found."
}
```

---

## OTP Not Verified

```json
{
    "status": false,
    "message": "Please verify OTP first."
}
```

---

## Password Already Reset

```json
{
    "status": false,
    "message": "Password has already been reset."
}
```

---

## Same Password

```json
{
    "status": false,
    "message": "New password cannot be same as old password."
}
```

---

## Password Reset Failed

```json
{
    "status": false,
    "message": "Unable to update password."
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

After a successful password reset:

- The new password is hashed using PHP Password Hash API.
- The user's password is updated.
- Failed login attempts are reset.
- Any account lock is removed.
- The password reset request is marked as completed.
- All active user sessions are invalidated.
- The user must authenticate again using the new password.

---

# Database Tables Used

| Table | Operation |
|--------|-----------|
| `users` | Update password and reset account security status |
| `password_reset` | Validate reset request and mark it as completed |
| `user_sessions` | Invalidate all active sessions |

---

# Processing Flow

1. Validate HTTP request method.
2. Read the JSON request body.
3. Validate all required fields.
4. Validate the email address format.
5. Validate password length.
6. Verify that both passwords match.
7. Verify that the user exists.
8. Retrieve the latest password reset request.
9. Verify that the OTP has already been verified.
10. Ensure the password reset request has not already been used.
11. Ensure the new password is different from the current password.
12. Hash the new password.
13. Start a database transaction.
14. Update the user's password.
15. Reset failed login attempts.
16. Remove any account lock.
17. Mark the password reset request as completed.
18. Invalidate all active login sessions.
19. Commit the transaction.
20. Return a success response.

---

# Business Rules

- Password reset is allowed only after successful OTP verification.
- Each password reset request can be used only once.
- The new password must be at least 8 characters long.
- The new password and confirmation password must match.
- The new password cannot be the same as the existing password.
- All active sessions are terminated after a successful password reset.
- Users must log in again after resetting their password.
- Database updates are executed within a transaction to ensure consistency.

---

# HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| **200** | Password reset completed successfully |
| **400** | Validation failed |
| **401** | OTP not verified |
| **404** | User or password reset request not found |
| **405** | Invalid HTTP method |
| **409** | Password reset request already used |
| **500** | Internal server error |

---

# Security Considerations

- Passwords are securely hashed using `password_hash()`.
- Plain-text passwords are never stored or returned.
- Password reset is permitted only after OTP verification.
- Used password reset requests cannot be reused.
- Existing passwords are verified using `password_verify()`.
- SQL Injection protection is implemented using prepared statements.
- All active sessions are invalidated after a successful password reset.
- Database transactions prevent partial updates and maintain data integrity.
- Sensitive account information is never exposed in API responses.