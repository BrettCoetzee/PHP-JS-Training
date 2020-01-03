<html>
 <head>
  <title>Foundation Task 2 using Recursion</title>
 </head>
 <body>
 <?php
  function buildFibonacciArray($depth,$sequence) {
    $count = count($sequence);
    $next = $sequence[$count - 2] + $sequence[$count - 1];
    array_push($sequence,$next);
    if(count($sequence) <= $depth + 2) {
      return buildFibonacciArray($depth,$sequence);
    }
    return $sequence;
  }
  $Sequence = [0,1];
  $Array = buildFibonacciArray(7,$Sequence);
  foreach($Array as $element) {
    echo $element . "<br>";
  }
?>
 </body>
</html>