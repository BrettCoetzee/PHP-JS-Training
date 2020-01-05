<html>
 <head>
  <title>Foundation Task 4</title>
 </head>
 <body>
<?php 
class ItemOwners {
  public static function groupByOwners($items) {
    $group = array();
    ItemOwners::echoAssArray($items);
    foreach($items as $key => $value){
      $group[$value][] = $key; // Reverse key->value
    } 
    ItemOwners::echoMultiAssArray($group);
    return $group;
  }
  
  // Note that Training is not code golf, thus fundamental array reading basics included below
  public static function echoAssArray($assArray) {
    echo "Key-Value-Pair Array: ". json_encode($assArray) ."<br>";
    foreach($assArray as $key => $value){
      echo "- " . $key . ": " . $value . "<br>";
    }
  }
  public static function echoMultiAssArray($multiAssArray) {
    echo "Key-Values-Pair (Multidimensional Associative) Array: ". json_encode($multiAssArray) ."<br>";
    foreach($multiAssArray as $key => $values){
      echo "- " . $key . ": ";
      foreach ($values as $value) {
        echo "'" . $value . "' ";
      }
      echo "<br>";
    }
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