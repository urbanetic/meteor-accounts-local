AccountsLocal =

  config: (users) ->
    env = process.env

    # Create an admin user from environment variables if needed.
    unless users.admin
      METEOR_ADMIN_PASSWORD = env.METEOR_ADMIN_PASSWORD
      METEOR_ADMIN_EMAIL = env.METEOR_ADMIN_EMAIL
      unless METEOR_ADMIN_PASSWORD
        throw new Error('Admin user details not provided in AccountsLocal.config() or with ' +
          'environment variables.')
      users.admin =
        name: 'Admin'
        password: env.METEOR_ADMIN_PASSWORD
        email: env.METEOR_ADMIN_EMAIL
        roles: ['admin']
        # Admin password and email will always update on server restart based on the environment
        # variables.
        update: true

    # Create all other users in the user.json.
    _.each users, (userArgs, username) ->
      return unless users.hasOwnProperty(username)
      selector = {username: username}
      existing = Meteor.users.findOne(username: username)
      # Only update user if reset is set to true or the user doesn't exist. This allows changing
      # the user details when they are changed in user.json.
      return if existing && userArgs.update == false
      emails = userArgs.emails ? userArgs.email
      unless emails? then emails = []
      unless Types.isArray(emails) then emails = [emails]
      emails = _.map emails, (email) ->
        if Types.isString(email)
          # Considered verified since this method is called from the server.
          {address: email, verified: true}
        else
          email
      userModifier =
        username: username
        emails: emails
        'profile.name': userArgs.name
      Meteor.users.upsert selector, {$set: userModifier}
      user = Meteor.users.findOne(selector)
      # Setting password must take place through Accounts module.
      Accounts.setPassword(user._id, userArgs.password)
      # Don't show the password in logs.
      delete user.password
      Roles.setUserRoles(user._id, userArgs.roles)
      action = if existing then 'Created' else 'Updated'
      Logger.debug(action + ' user:', username)
