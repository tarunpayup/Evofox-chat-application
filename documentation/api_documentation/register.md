# Register API Documentation

## API Information

| Property | Value |
|----------|--------|
| **API Name** | User Registration |
| **Endpoint** | `/api/register.php` |
| **Method** | `POST` |
| **Authentication** | Not Required |
| **Content-Type** | `application/json` |
| **Response Format** | `application/json` |

---

# Description

Registers a new user account by creating a user profile, generating a unique user identifier, creating an email verification OTP, and sending a verification email to the registered email address.

The user account remains unverified until the email verification process is successfully completed.

---

# Request Headers

| Header | Value | Required |
|---------|-------|----------|
| Content-Type | application/json | Yes |

---

# Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| full_name | String | Yes | Full name of the user |
| username | String | Yes | Unique username |
| email | String | Yes | Unique email address |
| phone | String | Yes | Unique mobile number |
| password | String | Yes | Account password |

---

# Sample Request

```http
POST /api/register.php
Content-Type: application/json
```

```json
{
    "full_name": "Tarun Bansal",
    "username": "tarunbansal",
    "email": "tarun@gmail.com",
    "phone": "9876543210",
    "password": "Password@123"
}
```

---

# Success Response

**HTTP Status:** `201 Created`

```json
{
    "status": true,
    "message": "Registration successful. Please verify your email."
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

## Full Name Missing

```json
{
    "status": false,
    "message": "Full Name is required."
}
```

---

## Username Missing

```json
{
    "status": false,
    "message": "Username is required."
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

## Invalid Email

```json
{
    "status": false,
    "message": "Invalid Email Address."
}
```

---

## Phone Missing

```json
{
    "status": false,
    "message": "Phone Number is required."
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

## Username Already Exists

```json
{
    "status": false,
    "message": "Username already exists."
}
```

---

## Email Already Exists

```json
{
    "status": false,
    "message": "Email already exists."
}
```

---

## Phone Already Exists

```json
{
    "status": false,
    "message": "Phone number already exists."
}
```

---

## Registration Failed

```json
{
    "status": false,
    "message": "Unable to register user."
}
```

---

# Email Verification

After successful registration:

- A six-digit OTP is generated.
- The OTP is stored in the `email_verifications` table.
- A verification email is sent to the registered email address.
- The account remains inactive until email verification is completed.

---

# Database Tables Used

| Table | Operation |
|--------|-----------|
| `users` | Create new user account |
| `email_verifications` | Store email verification OTP |

---

# Processing Flow

1. Validate HTTP request method.
2. Read JSON request body.
3. Validate all required fields.
4. Validate email format.
5. Check username uniqueness.
6. Check email uniqueness.
7. Check phone number uniqueness.
8. Generate a unique user UUID.
9. Hash the password using PHP Password Hash API.
10. Create the user account.
11. Generate a six-digit email verification OTP.
12. Store the OTP with an expiration time.
13. Send verification email.
14. Commit the database transaction.
15. Return success response.

---

# Business Rules

- Username must be unique.
- Email address must be unique.
- Mobile number must be unique.
- Password is securely hashed before storage.
- Email verification is mandatory before login.
- Registration is completed only if the verification email is successfully sent.
- OTP is generated for every new registration.
- User status is initially set to **Offline**.
- User profile is created with the default bio if not provided.

---

# HTTP Status Codes

| Status Code | Description |
|-------------|-------------|
| **201** | User registered successfully |
| **400** | Validation failed |
| **409** | Username, email, or phone already exists |
| **405** | Invalid HTTP method |
| **500** | Internal server error |

---

# Security Considerations

- Passwords are stored using `password_hash()`.
- Plain-text passwords are never stored or returned.
- SQL Injection protection is implemented using prepared statements.
- Duplicate user records are prevented through uniqueness validation.
- Email verification OTP has an expiration time.
- Database transactions ensure data consistency.
- User registration is rolled back if email delivery fails.
- Every user is assigned a globally unique UUID.