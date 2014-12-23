# accounts-local

Creates local users and an admin from a private asset.

## Usage

Call `AccountsLocal.setup(users)` on the server with the users configuration, which should be a map of usernames to user details:

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

A `private/users.json` file could be used for this along with the following code on the server:

```
Meteor.startup(function() {
  var users = JSON.parse(Assets.getText('users.json'));
  AccountsLocal.setup(users);
});
```

A single admin user with the username "admin" is expected. The details can be passed in the users configuration or set using the following environment variables: `METEOR_ADMIN_PASSWORD`, `METEOR_ADMIN_EMAIL`.

Updating the `users.json` file and restarting the server will update the details of the users. To prevent this, add the following property to the user details: `update: false`.
