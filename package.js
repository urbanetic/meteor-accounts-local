Package.describe({
  name: 'urbanetic:accounts-local',
  summary: 'Creates local users and an admin.',
  git: 'https://github.com/urbanetic/meteor-accounts-local.git',
  version: '2.0.0'
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1.6.1');
  api.use([
    'coffeescript@2.2.1_1',
    'underscore',
    'accounts-password@2.3.1',
    'urbanetic:utility@3.0.0',
    'alanning:roles@3.4.0'
  ], 'server');
  api.imply(['alanning:roles']);
  api.addFiles([
    'src/AccountsLocal.coffee'
  ], 'server');
  api.export('AccountsLocal', 'server');
});
