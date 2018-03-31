Package.describe({
  name: 'urbanetic:accounts-local',
  summary: 'Creates local users and an admin.',
  git: 'https://github.com/urbanetic/meteor-accounts-local.git',
  version: '1.0.0'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@1.6.1');
  api.use([
    'coffeescript@1.2.3',
    'underscore',
    'accounts-password',
    'urbanetic:utility@2.0.0',
    'digilord:roles@1.2.12'
  ], 'server');
  api.imply(['digilord:roles']);
  api.addFiles([
    'src/AccountsLocal.coffee'
  ], 'server');
  api.export('AccountsLocal', 'server');
});
