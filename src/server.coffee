# Creates and updates the locally managed users.
Meteor.startup ->

  env = process.env

  # This expects users.json to reside in the "private" directory.
  users = JSON.parse(Assets.getText('users.json') || '{}')

  # Create an admin user from environment variables if needed.
  unless users.admin
    AUTH_AURIN_ADMIN_PASSWORD = env.METEOR_ADMIN_PASSWORD
    AUTH_AURIN_ADMIN_EMAIL = env.METEOR_ADMIN_EMAIL
    unless AUTH_AURIN_ADMIN_PASSWORD
      throw new Error('Admin user password not set with AUTH_AURIN_ADMIN_EMAIL environment variable.')
    users.admin =
      name: 'Admin'
      password: env.AUTH_AURIN_ADMIN_PASSWORD
      email: env.AUTH_AURIN_ADMIN_EMAIL
      roles: ['admin']
      # Admin password and email will always update on server restart based on the environment
      # variables.
      update: true

  # Create all other users in the user.json.
  _.each users, (userArgs, username) ->
    if users.hasOwnProperty(username)
      selector = {username: username}
      existing = Meteor.users.findOne(username: username)
      # Only update user if reset is set to true or the user doesn't exist. This allows changing
      # the user details when they are changed in user.json.
      return if existing && userArgs.update == false
      Meteor.users.upsert(selector, {$set: {
        username: username
        email: userArgs.email
        'profile.name': userArgs.name
      }})
      user = Meteor.users.findOne(selector)
      # Setting password must take place through Accounts module.
      Accounts.setPassword(user._id, userArgs.password)
      # Don't show the password in logs.
      delete user.password
      Roles.setUserRoles(user._id, userArgs.roles)
      console.log('Created user:', user)
