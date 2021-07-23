# 如何使用 PHP 脚本来保证其他进程的 KeepAlive？

**业务场景**：  

目前系统中存在一些常驻脚本任务，需要保证这些脚本不会挂掉。  

**实现**：  

写一个 `process-keepalive.php` 脚本，使用 Crontab 定时任务每分钟执行一次该脚本。  

```php
#!/bin/env php
<?php
if (PHP_SAPI !== 'cli') {
    exit('ONLY CLI' . PHP_EOL);
}

set_time_limit(0);

/********************************************* 常量定义 begin ***********************************************************/
// 当前进程名称
const CURRENT_PROCESS_NAME  = 'process-keepalive';
/********************************************* 常量定义 end *************************************************************/

// 保证进程唯一
uniqueProcess();

/********************************************* 逻辑 begin **************************************************************/
// file_name 是 PHP 文件名称，写绝对路径；process_name 是对应脚本文件的进程名称，用来检测进程是否挂掉。
$processList = [
    ['file_name' => 'process_1.php',                'process_name' => 'process_1'],
    ['file_name' => 'process_2.php',                'process_name' => 'process_2'],
];

foreach ($processList as $processInfo) {
    $processName    = $processInfo['process_name'];
    $fileName       = $processInfo['file_name'];

    $exec = "ps -ef | grep $processName | grep -v 'grep' | wc -l";
    $count = shell_exec($exec);
    if (intval($count) === 0) {
        $exec = "php $fileName &";
        shell_exec($exec);
    }
}
/********************************************* 逻辑 end ****************************************************************/

/**
 * 保证进程的唯一性，防止进程不退出造成系统中存在多个相同的进程
 */
function uniqueProcess()
{
    // 当前进程名称
    $currentProcessName = CURRENT_PROCESS_NAME;
    // 设置当前进程名称
    cli_set_process_title($currentProcessName);
    // 当前进程 ID
    $pid = posix_getpid();
    // 除了当前进程 ID，杀掉其他同名进程，保证同一时刻进程的唯一性
    $exec = "ps aux | grep {$currentProcessName} | grep -v 'grep' | grep -v {$pid} | awk '{print $2}' | xargs kill -9";
    shell_exec($exec);
}
```
