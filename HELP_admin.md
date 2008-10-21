If you would like to make the settings tab invisible to certain users,
You may edit the `roles.settings` value.

You have several options to display the tab, but keep in mind that deleting
this setting or saving it as an empty value will allow **all** users to see 
the "Settings" tab.

Here are the possible values that you may use:

1. `admin` (for admin only)
2. `developer` (for developers only)
3. `admin, developer` (for both developers and admin users)
4. `all` (for everyone)

After making these changes, you'll need to restart the application to see
the access changed in production.