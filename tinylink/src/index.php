<?php
define("DBHOST", "localhost");
define("DBNAME", "tinylink");
define("DBUSER", "admin");
define("DBPASSWORD", getenv("_DBPW"));

try {
  $db = new PDO(
    "mysql:host=".DBHOST.";dbname=".DBNAME,
    DBUSER,
    DBPASSWORD
  );
} catch (PDOException $e) {
  echo "Error: ".$e->getMessage()."<br>";
  die();
}

$rows = $db->query("SELECT * from redirects")->fetchAll(PDO::FETCH_ASSOC);

echo "<table border=1><tr><th>id</th><th>destination</th></tr>";
foreach ($rows as $row)
  echo "<tr><td>".$row["id"]."</td><td>".$row["destination"]."</td></tr>";
echo "</table>";
