# How to update i-MSCP translation files

## System Requirements

  * gettext
  * Transifex client

In order, to be able to update translation files, you must have the gettext
tool and the Transifex client installed on your system.

## Installation process (Debian/Ubuntu)

### As root user:

  Gettext installation

```bash
# aptitude install gettext
```
  Transifex client installation

```bash
# aptitude install python-setuptools
# easy_install --upgrade transifex-client
```

### As normal user:

Creation of Transifex configuration file

```bash
$ touch ~/.transifexrc
```

and put the following content in it:

```
[https://www.transifex.com]
hostname = https://www.transifex.com
password = <PASSWORD>
token =
username = <USERNAME>
```

Of course, you have to change <PASSWORD> and <USERNAME> with your own Transifex
login data.

## Updating translation files

### As normal user:

  Run the "makemsgs" shell script to get all translation strings from the
    php, phtml and xml files within the i18n/iMSCP.pot file

```bash
$ cd {YOUR_WORKING_COPY}/i18n/tools
$ sh ./makemsgs
```

  Push the new iMSCP.pot on Transifex

```bash
$ cd {YOUR_WORKING_COPY}/i18n
$ tx push -s
```

**Note:** The *.po files will be automatically updated by Transifex and no more
checking is needed from your side.

  Getting updated *.po files from Transifex

```bash
$ cd {YOUR_WORKING_COPY}/i18n
$ tx pull -af
```

## Compiling translation files

### As normal user

  Use the shell script "compilePo" to compile all *.po files

```bash
$ cd {YOUR_WORKING_COPY}/i18n/tools
$ sh ./compilePo
```

Once it's done, you commit the resulting files in your git repository.
