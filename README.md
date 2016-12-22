# setphpfwperms.sh
Script meant to lessen the pain of setting permissions after a new PHP project from popular frameworks is created. 
Intended for those who don't like to `chmod -R 777 something`
No worries about who is the HTTPD user, the script will find it for you.

## Can be used for these frameworks / applications
 * Laravel 5
 * Fat Free Framework (f3)
 * Cake 3
 * Wordpress
 * Prestashop

## Known issues
No issues has been reported at this moment.

## Requirements
You must have `setfacl` command installed and available in your OS.
 * Debian/Ubuntu: `sudo apt-get install setfacl`

## Installation
You can put this script wherever you want, as in your `/home/your_user/scripts` folder, then include the folder into your `$PATH` environment variable.

## Usage (example: Laravel 5)
 * You must be in the root folder of your PHP project
 * `sudo sh /route/to/this/script/setphpfwperms.sh laravel5`

And permissions will be set.

 * Type `sudo sh /route/to/this/script/setphpfwperms.sh` without arguments to get a list of available frameworks.
 
(or just check the source code and look out).

## Other stuff

Feel free to improve this script! It was just made with a bare knowledge of ShellScript.
