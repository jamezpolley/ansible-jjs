Role Name
=========

Installs and configures
[jenkins-job-scraper](https://github.com/jamezpolley/jenkins-job-scraper)
to create reports about the OpenStack periodic-stable jobs.

Requirements
------------

None

Role Variables
--------------

jjs_source_location: location of jjs repo.

Dependencies
------------

none

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: jjs, jjs_source_location: http://my_git_server/username/jjs.git }

License
-------

Apache 2

Author Information
------------------

James Polley <jp@jamezpolley.com>
