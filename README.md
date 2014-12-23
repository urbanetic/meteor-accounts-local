# accounts-local

Creates local users and an admin from a private asset.

## Usage

A `private/users.json` file must exist from the application root. It is a map of usernames to user details:

```
{
  "admin": {
    "name": "Admin",
    "password": "password",
    "email": "admin@test.com",
    "roles": ["admin"]
  },
  "other": {
    "name": "Other User",
    "password": "foobar",
    "email": "other@test.com",
    "roles": ["user"]
  }
}
```

The admin user credentials must be set in either the `users.json` or using the following environment variables (recommended): `METEOR_ADMIN_PASSWORD`, `METEOR_ADMIN_EMAIL`.

Updating the `users.json` file and restarting the server will update the details of the users. To prevent this, add the following property to the user details: `update: false`.
