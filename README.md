DbConnect
=========

Quickly connect to a MySQL database instance
--------------------------------------------

Simplify the management of several concurrent databases

```bash
$ ./db_connect.rb connect -p fozzie
"Running mysql -h1.2.3.4 -P3306 -uuser -ppass dev_fozzie"
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 6409878
Server version: 5.5.25a-log MySQL Community Server (GPL)

Copyright (c) 2000, 2014, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> Bye
$
```