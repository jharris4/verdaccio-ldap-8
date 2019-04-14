-----

## Add a user:

This may be needed if the `.npmrc` in this folder does not respect the `user:password@` in the registry url.

- `npm adduser --registry=http://0.0.0.0:4873/ --always-auth`

At the prompt enter the following:

- `Username: ` `tesla`
- `Password: ` `password`
- `Email: (this IS public) ` `tesla@ldap.forumsys.com`

This will create the following line in your `~/.npmrc`

```
//0.0.0.0:4873/:_authToken="Uzj13f/7E46fz2a3NmvF4Q=="
```

-----

## Install a package

To test the running verdaccio server for package installation, run the following from the root of this repository:

- `cd local_package`
- `yarn install`

-----

## Bootstrap the verdaccio storage database

Once verdaccio has initialized, it should create a `/volumes/storage/.sinopia-db.json` file.

You can edit or create this file (path is relative to the root of this repository), with content like the following:

`{"list":["@porterjs/app"],"secret":"8d57151eda0521ed849837f06098558ae6e9c9be8f92b781415b437edec40d25"}`

-----

## Searching LDAP

The `ldapsearch` command is very useful for troubleshooting LDAP issues, here are some handy commands:

### Search for all users:

- `ldapsearch -w password -h ldap.forumsys.com -D "uid=tesla,dc=example,dc=com" -b "dc=example,dc=com"`

### Search for a user:

- `ldapsearch -w password -h ldap.forumsys.com -D "uid=tesla,dc=example,dc=com" -b "dc=example,dc=com" "(uid=einstein)" "*" "memberOf"`

### Search for a user's groups:

- `ldapsearch -x -w password -h ldap.forumsys.com -D cn=read-only-admin,dc=example,dc=com -b dc=example,dc=com "(uniqueMember=uid=tesla,dc=example,dc=com)"`




