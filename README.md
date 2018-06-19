# spoof-sudo
Security oriented tool used to steal sudo password

To get best experience use the dropper - it will replace sudo with the stub. When the stub harvests the correct credentials it will dump it to /tmp/pass_dump and remove itself to leave no trace. Of course dumping to /tmp/pass_dump is only PoC and only shows the posibilites of this tool (installing rootkit, runing command as sudo etc.) 

Usage:
```
./dropper
```
Then invoke any command with sudo
Example:
```
sudo cat /etc/shadow
```

Your password shoud be now in /tmp/pass_dump
##### Notes:
The file priv_esc.sh is not really needed beacause the file content is already base64 encoded in the dropper, I put it just so you can get better view over the source code

**This tool doesn't need any special priviledges (but it gains them)**


## Author

* @Srakai
