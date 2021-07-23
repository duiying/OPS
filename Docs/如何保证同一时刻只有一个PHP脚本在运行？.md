# 如何保证同一时刻只有一个 PHP 脚本在运行？

**业务场景**：防止脚本由于莫名的原因卡住了不退出，新的脚本又启动了，这样多个脚本就产生了并发。  

**解决方法**：  

```php
#!/bin/env php
<?php
if (PHP_SAPI !== 'cli') {
    exit('ONLY CLI' . PHP_EOL);
}

set_time_limit(0);

/********************************************* 常量定义 begin ***********************************************************/
// 当前进程名称
const CURRENT_PROCESS_NAME  = 'test-process';
/********************************************* 常量定义 end *************************************************************/

// 保证进程唯一
uniqueProcess();

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
