Running the Server
==================

Installing bundles:
```console
bundle install
```

Updating the database:
```console
sudo -u postgres psql
psql (9.3.9)
Type "help" for help.

postgres=# ALTER USER postgres PASSWORD 'root';
ALTER ROLE
postgres=# 
```

```console
rake db:create db:migrate
```

## Set .ENV
```console
cp .env-sample .env
```

Now, you are able to start the server:
```console
rails server
```
##Cloned
https://github.com/igordeoliveirasa/social-login-rails
