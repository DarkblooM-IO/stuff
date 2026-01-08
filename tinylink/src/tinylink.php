<?php
define("ROUTE", $_SERVER["REQUEST_URI"]);
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

$id = explode("/", ROUTE)[1];

if (preg_match("/^\d+$/", $id)) {
  $stmt = $db->prepare("SELECT destination FROM redirects WHERE id = :destID");
  $stmt->bindParam(":destID", $id);
  $stmt->execute();
  $result = $stmt->fetch(PDO::FETCH_ASSOC);

  if ($result) {
    $destination = $result["destination"];
    echo "<script>window.location.href = '$destination'</script>";
  } else {
    echo "tinylink: no entry";
  }
}
