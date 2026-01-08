<?php
define("ROUTE", $_SERVER["REQUEST_URI"]);
include("tinylink.php");
?>
<!DOCTYPE html>
<html>
  <head>
    <style>
      * { font-family: sans-serif }
    </style>
  </head>
  <body>
    <?php
    switch (ROUTE) {
      case "":
      case "/":
        echo "homepage";
        break;
      default:
        redirect($db);
    }
    ?>
  </body>
</html>
