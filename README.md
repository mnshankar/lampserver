lampserver
==========

My preferred lampserver setup for PHP/Laravel development. 

1. Ensure you have both Virtualbox and Vagrant setup on your computer (FYI, I have tested it on Vagrant 1.4.3 and Virtualbox 4.2.22 on Windows 7 host)

2. Copy BOTH "Vagrantfile" and "install.sh" into a folder of your choice, and from the command prompt (within the dir), do :

```vagrant up```

3. On your browser, navigate to localhost:8080, and you should see the apache/debian index page. Any content that you put in the "html" folder (created by the script) will be exposed at localhost:8080

4. You can ssh into your server at localhost:2222 (On windows, 

5. You can access the mysql server using a client (mysql workbench, navicat etc) at localhost:8306 (username:root, password:root)

Credits
=======
1. Jeffrey Way's vagrant setup (https://github.com/JeffreyWay/Vagrant-Setup). Most lines are copied verbatim from his script. I made a couple of edits to the web, db and shell installs.

2. Vaprobash: I have incorporated several snippets from vaprobash source (https://github.com/fideloper/Vaprobash).
