 <?php
  $max = $_POST['max'];
  function buildFibonacciArray($maxInput) {
    $sequence = [0,1];
    $i = 0;
    while ($sequence[$i] + $sequence[$i+1] < $maxInput) {
      array_push($sequence,$sequence[$i] + $sequence[$i+1]);
      $i++;
    }
    return $sequence;
  }
  $Array = buildFibonacciArray($max);
  die(json_encode($Array));
?>