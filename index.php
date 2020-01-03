<html>
 <head>
  <title>Foundation Task 1 using Recursion</title>
 </head>
 <body>
 <?php
  function addAll($inputArray,$totalSum) {
    $sum = 0;
    foreach($inputArray as $element) {
      $sum += $element;
    }
    array_shift($inputArray);
    $totalSum += $sum;
    if (count($inputArray) > 0) {
      return addAll($inputArray,$totalSum);
    }
    return $totalSum;
  }
  $Array = [1,1,1,1,1]; //5+4+3+2+1=15
  $Sum = 0;
  echo addAll($Array,$Sum);
?>
 </body>
</html>