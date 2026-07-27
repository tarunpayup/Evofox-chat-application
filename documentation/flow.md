# Authentication API Flow

This document describes the complete authentication workflow and the order in which each API should be invoked by the client application.

---

# Authentication Flow

```text
                    User Opens Application
                              │
                              ▼
                    Does User Have Account?
                     ┌─────────┴─────────┐
                     │                   │
                    No                  Yes
                     │                   │
                     ▼                   ▼
             Register Account        Login
                     │                   │
                     ▼                   ▼
          Email Verification?     Credentials Valid?
                     │                   │
          ┌──────────┴──────────┐        │
          │                     │        │
         No                    Yes       │
          │                     │        │
          ▼                     ▼        ▼
Resend Verification OTP      Verify Email   Login Success
          │                     │               │
          ▼                     ▼               ▼
      Verify Email         Email Verified   Dashboard
                              │
                              ▼
                          Login Again
```

---

# Forgot Password Flow

```text
          User Forgot Password
                   │
                   ▼
          Forgot Password API
                   │
                   ▼
        OTP Sent to Email Address
                   │
                   ▼
         Verify Password Reset OTP
                   │
                   ▼
          OTP Successfully Verified
                   │
                   ▼
            Reset Password API
                   │
                   ▼
          Password Updated Successfully
                   │
                   ▼
              Login with New Password
```

---

# API Execution Order

## New User Registration

```text
register.php
      │
      ▼
verify_email.php
      │
      ▼
login.php
```

---

## Email Verification Failed

```text
register.php
      │
      ▼
resend_verification.php
      │
      ▼
verify_email.php
      │
      ▼
login.php
```

---

## Existing User Login

```text
login.php
```

---

## Forgot Password

```text
forgot_password.php
          │
          ▼
verify_reset_otp.php
          │
          ▼
reset_password.php
          │
          ▼
login.php
```

---

# Complete API Sequence

| Step | API | Purpose |
|------|-----|---------|
| 1 | `register.php` | Create new user account |
| 2 | `verify_email.php` | Verify email using OTP |
| 3 | `login.php` | Authenticate user |
| 4 | `forgot_password.php` | Generate password reset OTP |
| 5 | `verify_reset_otp.php` | Verify password reset OTP |
| 6 | `reset_password.php` | Update account password |
| 7 | `login.php` | Login with new password |
| 8 | `resend_verification.php` | Generate a new email verification OTP (if required) |

---

# Authentication State Flow

```text
                 Registration
                      │
                      ▼
              Account Created
                      │
                      ▼
             Email Verified?
               │           │
              No          Yes
               │           │
               ▼           ▼
      Resend Verification  Login
               │
               ▼
        Verify Email OTP
               │
               ▼
         Email Verified
               │
               ▼
             Login
               │
               ▼
      Authentication Token
               │
               ▼
      Authenticated Requests
               │
               ▼
             Logout
```

---

# Password Recovery State Flow

```text
        Forgot Password
               │
               ▼
      Generate Reset OTP
               │
               ▼
      Verify Reset OTP
               │
               ▼
      OTP Verification Success
               │
               ▼
        Reset Password
               │
               ▼
     Invalidate All Sessions
               │
               ▼
      Login Using New Password
```

---

# API Dependency Diagram

```text
                   register.php
                         │
                         ▼
                verify_email.php
                         │
                         ▼
                     login.php
                         │
          ┌──────────────┴──────────────┐
          │                             │
          ▼                             ▼
Authenticated APIs             forgot_password.php
                                            │
                                            ▼
                               verify_reset_otp.php
                                            │
                                            ▼
                                  reset_password.php
                                            │
                                            ▼
                                        login.php

resend_verification.php
          │
          ▼
verify_email.php
```

---

# Authentication Lifecycle

```text
Start
 │
 ▼
Register
 │
 ▼
Email Verification
 │
 ▼
Login
 │
 ▼
Authenticated Session
 │
 ▼
Use Protected APIs
 │
 ▼
Logout / Session Expired
 │
 ▼
Login Again
 │
 ├───────────────► Forgot Password
 │                     │
 │                     ▼
 │              Verify Reset OTP
 │                     │
 │                     ▼
 │               Reset Password
 │                     │
 └─────────────────────┘
```

---

# API Usage Summary

| Scenario | API Sequence |
|----------|--------------|
| New Registration | `register.php` → `verify_email.php` → `login.php` |
| Verification OTP Expired | `resend_verification.php` → `verify_email.php` |
| User Login | `login.php` |
| Forgot Password | `forgot_password.php` → `verify_reset_otp.php` → `reset_password.php` → `login.php` |
| Password Changed | `login.php` |
| Verified User | Access Protected APIs |