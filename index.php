<html>
 <head>
  <title>Foundation Task 1 using Loops</title>
 </head>
 <body>
 <?php
  function addAll($inputArray) {
    $totalsum = 0;
    while(count($inputArray) > 0)
    {
      $sum = 0;
      foreach($inputArray as $element){
        $sum += $element;
      }
      array_shift($inputArray);
      $totalsum += $sum;
    }
    return $totalsum;
  }
  $Array = [1,1,1,1,1]; //5+4+3+2+1=15
  echo addAll($Array);
?>
 </body>
</html>