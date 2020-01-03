<html>
 <head>
  <title>Foundation Task 3</title>
 </head>
 <body>
 <?php
  class Palindrome {
	public static function isPalindrome($text) {
    $text = strtolower(str_replace(' ', '', $text));
    $rev = strrev($text);
    for ($i = 0; $i < strlen($text); $i++) {
      if ($text[$i] != $rev[$i]) {
        return false;        
      }
    }
		return true;
	}
}

if (Palindrome::isPalindrome('Never Odd Or Even'))
	echo 'Palindrome';
else
	echo 'Not palindrome';

?>
 </body>
</html>