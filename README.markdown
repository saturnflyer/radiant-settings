Radiant Settings Extension
==========================

A simple configuration editor for Radiant.  It adds a simple "Settings" tab that allows manage the configuration settings.

After installation be sure to update your instance of radiant!

    rake radiant:extensions:settings:update
    rake radiant:extensions:settings:migrate

Extension Developers
--------------------

If you are using Radiant::Config to store settings for your extensions, then you can add some textile formatted text into
the "description" attribute the Radiant::Config model.  This prose will show up on the the edit setting page making it
more clear just what that setting does.


Radius-Tags
-----------

Radiant Settings Extension allows you to access Radiant::Config via &lt;r:config:settings key="key" /&gt;.

    Use <r:config:setting key="admin.title" /> for Radiant::Config['admin.title'].
