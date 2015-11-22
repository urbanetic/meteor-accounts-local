Package.describe({
  name: 'urbanetic:accounts-local',
  summary: 'Creates local users and an admin.',
  git: 'https://github.com/urbanetic/meteor-accounts-local.git',
  version: '0.1.2'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@0.9.0');
  api.use([
    'coffeescript',
    'underscore',
    'accounts-password',
    'aramk:utility@0.8.3',
    'digilord:roles@1.2.12'
  ], 'server');
  api.imply(['digilord:roles']);
  api.addFiles([
    'src/AccountsLocal.coffee'
  ], 'server');
  api.export('AccountsLocal', 'server');
});
