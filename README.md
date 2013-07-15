Pinkpress
=========

Introduction
------------

Pinkpress is a super-simple system for managing content (for example, a blog)
on minimal hardware. It does this using Blogger-style, that is, formatting
HTML once to create static pages offline.


Installation
------------

Because this system is to run on a Raspberry Pi, the installation instructions
are for a fresh install on Raspbian with no additional packages.

h3. Required packages

The following packages are needed:

The web server:

* apache2
* apahce2-suexec

Some perl-related packages

* libtemplate-perl (the Template Toolkit)
* libtemplate-perl-doc (Template Toolkit documentation, optional)
* libtext-markdown-perl (for formatting posts easily) 


Web server configuration
------------------------

The goal of this service is to run something light-weight, and that also means
that installation should be lightweight. So perferably as little changes
to the system and everything in userspace.

Before we can run cgi scripts as a user, we must configure the webserver
to allow running cgi scripts as normal user and before that, we have to 
enable userdirs.

In /etc/apache2/mods_enabled, we make symbolic links to
/etc/apache2/modules_available/userdir.load and userdir.conf:

  sudo -s   # become root
  cd /etc/apache2/mods_enabled
  ln -s ../mods_available/userdir.load .
  ln -s ../mods_available/userdir.conf .
  service apache2 reload

Create a directory in pi's home directory with sufficient access rights:

  cd
  mkdir public_html
  chmod a+rx public_html

