# 如何使用 PHP 脚本来保证其他进程的 KeepAlive？

**业务场景**：  

目前系统中存在一些常驻脚本任务，需要保证这些脚本不会挂掉。  

**实现**：  

写一个 `process-keepalive.php` 脚本，使用 Crontab 定时任务每分钟执行一次该脚本。  

```php

```
