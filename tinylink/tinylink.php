<?php
function redirect($db, $route) {
  $id = explode("/", $route)[1];

  if (!preg_match("/^\d+$/", $id))
    return;

  $stmt = $db->prepare("SELECT destination FROM redirects WHERE id = :destID");
  $stmt->bindParam(":destID", $id);
  $stmt->execute();
  $result = $stmt->fetch(PDO::FETCH_ASSOC);

  if (!$result) {
    echo "tinylink: no entry";
    return;
  }

  $destination = $result["destination"];
  echo "<script>window.location.href = '$destination'</script>";
}
