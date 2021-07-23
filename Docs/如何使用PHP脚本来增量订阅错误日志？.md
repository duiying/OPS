# 如何使用 PHP 脚本来增量订阅错误日志？

**业务场景**：  

目前公司中自己负责的后端系统采用的是 PHP 语言实现，写代码避免不了出现一些 BUG，此时 PHP 就会将错误日志写到指定的错误日志文件中，如果能够及时的看到这些错误日志，就能及时发现和解决问题，故写了一个脚本来**增量订阅 PHP 的错误日志**。  

```php
#!/bin/env php
<?php
if (PHP_SAPI !== 'cli') {
    exit('ONLY CLI' . PHP_EOL);
}

set_time_limit(0);

/********************************************* 常量定义 begin ***********************************************************/
// 错误日志文件位置
const ERROR_LOG_PATH        = '/data/logs/php/error.log';
// 当前进程名称
const CURRENT_PROCESS_NAME  = 'php-log-subscribe';
// 打日志文件目录
const LOG_DIR               = '/data/logs/' . CURRENT_PROCESS_NAME . '/';
/********************************************* 常量定义 end *************************************************************/

// 保证进程唯一
uniqueProcess();
if (!file_exists(ERROR_LOG_PATH)) exit('日志文件不存在' . PHP_EOL);

/********************************************* 逻辑 begin **************************************************************/
// 错误日志当前行数
$lastLine = count(file(ERROR_LOG_PATH));
// 进程常驻，订阅错误日志
while (true) {
    sleep(2);
    handle($lastLine);
}

function handle(&$lastLine)
{
    logInfo('开始扫描错误日志');
    if (!file_exists(ERROR_LOG_PATH)) {
        logError('日志文件不存在');
    }

    // 当前行数
    $nowLine = count(file(ERROR_LOG_PATH));

    // 如果行数没有变化，直接返回
    if ($nowLine === $lastLine) return true;

    // 如果当前行数小于上次的行数，说明是新的一天了，老的日志发生了压缩，生成了新的日志文件
    if ($nowLine < $lastLine) {
        $lastLine = $nowLine;
        // 当前日志文件为空
        if ($nowLine === 0) {
            logInfo('当前日志内容为空');
            return true;
        }
        // 如果新的日志文件中有内容了，告警
        $alarmMsg = cutFile(0, $nowLine - 1);
        if (!empty($alarmMsg)) {
            alarm($alarmMsg);
        }

        return true;
    }

    // 如果执行到这里，说明日志有了增量
    $alarmMsg = cutFile($lastLine, $nowLine - 1);
    $lastLine = $nowLine;
    if (!empty($alarmMsg)) {
        alarm($alarmMsg);
    }

    return true;
}

/**
 * 告警
 *
 * @param string $alarmMsg
 */
function alarm($alarmMsg = '')
{
    // TODO 邮件告警 or 飞书告警等，这里暂时用打日志方式来进行告警
    logWarning($alarmMsg);
}

/**
 * 截取指定文件内容
 *
 * @param $start
 * @param $end
 * @return string
 */
function cutFile($start, $end)
{
    if (!file_exists(ERROR_LOG_PATH)) {
        return '';
    }
    $f = new SplFileObject(ERROR_LOG_PATH,'r');
    $f->seek($start);
    $ret = '';
    for ($i = $start; $i <= $end; $i++) {
        $ret .= $f->current();
        $f->next();
    }
    return $ret;
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

/********************************************* 日志相关方法 begin ********************************************************/
function logInfo($content)
{
    createLogDir();
    assembleContent($content);
    file_put_contents(LOG_DIR . 'info.log.' . date('Ymd'), $content . PHP_EOL, FILE_APPEND | LOCK_EX);
}

function logError($content)
{
    createLogDir();
    assembleContent($content);
    file_put_contents(LOG_DIR . 'error.log.' . date('Ymd'), $content . PHP_EOL, FILE_APPEND | LOCK_EX);
}

function logWarning($content)
{
    createLogDir();
    assembleContent($content);
    file_put_contents(LOG_DIR . 'warning.log.' . date('Ymd'), $content . PHP_EOL, FILE_APPEND | LOCK_EX);
}

function logSuccess($content)
{
    createLogDir();
    assembleContent($content);
    file_put_contents(LOG_DIR . 'success.log.' . date('Ymd'), $content . PHP_EOL, FILE_APPEND | LOCK_EX);
}

function logDebug($content)
{
    createLogDir();
    assembleContent($content);
    file_put_contents(LOG_DIR . 'debug.log.' . date('Ymd'), $content . PHP_EOL, FILE_APPEND | LOCK_EX);
}

function assembleContent(&$content)
{
    $now = date('Y-m-d H:i:s');
    $content = '【' . $now . '】' . $content . PHP_EOL;
}

function createLogDir()
{
    !is_dir(LOG_DIR) && @mkdir(LOG_DIR, 0777, true);
}
/********************************************* 日志相关方法 end **********************************************************/
```
