Package.describe({
  name: 'urbanetic:accounts-local',
  summary: 'Creates local users and an admin from a private asset.',
  version: '0.1.0'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@0.9.0');
  api.use(['coffeescript', 'underscore', 'accounts-password'], 'server');
  api.use(['digilord:roles'], 'server', {weak:true});
  api.add_files([
    'src/server.coffee'
  ], 'server');
  api.export('AccountsLocal', 'server');
});