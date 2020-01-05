<html>
 <head>
  <title>Foundation Task 4</title>
 </head>
 <body>
<?php 
class ItemOwners {
  public static function groupByOwners($items) {
    $group = array();
    foreach($items as $key => $value){
      $group[$value][] = $key;
    }
    return $group;
  }
}
$items = array(
  "Baseball Bat" => "John",
  "Golf ball" => "Stan",
  "Tennis Racket" => "John"
);
echo json_encode(ItemOwners::groupByOwners($items));

?>
 </body>
</html>