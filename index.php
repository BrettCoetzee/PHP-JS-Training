<html>
 <head>
  <title>Foundation Task 2 using Loop</title>
 </head>
 <body>
 <?php
  function buildFibonacciArray($depth) {
    $sequence = [0,1];
    for ($i = 0; $i <= $depth; $i++) {
      $next = $sequence[$i] + $sequence[$i+1];
      array_push($sequence,$next);
    }
    return $sequence;
  }
  $Array = buildFibonacciArray(7);
  foreach($Array as $element) {
    echo $element . "<br>";
  }
?>
 </body>
</html>