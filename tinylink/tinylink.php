<?php
function redirect($db, $route) {
  $id = explode("/", $route)[1];

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
}
