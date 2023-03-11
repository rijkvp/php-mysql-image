<!DOCTYPE html>
<html lang="en-US">
  <head>
    <meta charset="utf-8" />
    <title>Test</title>
  </head>
  <body>
    <h1>Test page</h1>
    <ul>
    <?php
    ini_set('display_errors', '1');
    ini_set('display_startup_errors', '1');
    error_reporting(E_ALL);
    echo '<li>PHP version: <strong>' . phpversion() . '</strong></li>';
    $mysqli = new mysqli("localhost", "user", "password");
    $mysql_v = (float)$mysqli->server_version;
    $main_version = floor($mysql_v / 10000);
    $minor_version = floor(($mysql_v - $main_version * 10000) / 100);
    $sub_version = $mysql_v - $main_version * 10000 - $minor_version * 100;
    echo '<li><span class="">MySQL version: <strong>' . $main_version . "." . $minor_version . "." . $sub_version . '</strong></li>';
    ?>
    </ul>
  </body>
</html>

