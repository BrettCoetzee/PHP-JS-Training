-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 09, 2021 at 08:22 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Wolfman`
--

-- --------------------------------------------------------

--
-- Table structure for table `Automation`
--

CREATE TABLE `Automation` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Status` mediumtext DEFAULT NULL,
  `Mode` text DEFAULT NULL,
  `Enabled` varchar(50) DEFAULT NULL,
  `OrderInt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Automation`
--

INSERT INTO `Automation` (`Id`, `Name`, `Status`, `Mode`, `Enabled`, `OrderInt`) VALUES
(1, 'Policies', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Policies-Module/wolftest.php', NULL, 1),
(2, 'Finance', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Finance-Module/test.php', NULL, 3),
(3, 'Main', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Main-Module/test.php', NULL, 2),
(4, 'Communications', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Communications-Module/wolftest.php', NULL, 4),
(7, 'Other', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Policies-Module/test2.php', NULL, 6),
(9, 'Members', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Communications-Module/bretttest.php', NULL, 5);

-- --------------------------------------------------------

--
-- Table structure for table `Batch`
--

CREATE TABLE `Batch` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Status` mediumtext DEFAULT NULL,
  `Mode` varchar(50) DEFAULT NULL,
  `Enabled` varchar(50) DEFAULT NULL,
  `AutomationInt` int(11) DEFAULT NULL,
  `OrderInt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Batch`
--

INSERT INTO `Batch` (`Id`, `Name`, `Status`, `Mode`, `Enabled`, `AutomationInt`, `OrderInt`) VALUES
(1, 'MobilityTransaction', NULL, NULL, NULL, 2, 1),
(2, 'Payments', NULL, NULL, NULL, 2, 2),
(3, 'BackgroundProcess', NULL, NULL, NULL, 2, 3),
(4, 'Collections SSVS', NULL, NULL, NULL, 1, 1),
(5, 'Collections Naedo', NULL, NULL, NULL, 1, 2),
(6, 'ResponseItems', NULL, NULL, NULL, 1, 8),
(7, 'CollectionTextFile', NULL, NULL, NULL, 1, 4),
(8, 'CollectionItem', NULL, NULL, NULL, 1, 5),
(9, 'Policy', NULL, NULL, NULL, 1, 9),
(10, 'Third Party', NULL, NULL, NULL, 3, 2),
(11, 'CollectionSummary', NULL, NULL, NULL, 1, 6),
(12, 'Anniversary', NULL, NULL, NULL, 4, 1),
(13, 'Debugging', NULL, NULL, NULL, 4, 5),
(14, 'BackgroundProcess', NULL, NULL, NULL, 1, 10),
(17, 'DFS ', NULL, NULL, NULL, 3, 1),
(19, 'Cease', NULL, NULL, NULL, 4, 2),
(20, 'Pre Policy Debit', NULL, NULL, NULL, 4, 3),
(21, 'CollectionMethod', NULL, NULL, NULL, 1, 7),
(25, 'Helper', NULL, NULL, NULL, 7, 1),
(26, 'Funny', NULL, NULL, NULL, 7, 2),
(27, 'Policy Notifications', NULL, NULL, NULL, 4, 4),
(28, 'Payments User Role', NULL, NULL, NULL, 2, 4),
(29, 'Individual', NULL, NULL, NULL, 9, 1),
(30, 'TODO', NULL, NULL, NULL, 2, 5),
(32, 'Log', NULL, NULL, NULL, 1, 11),
(33, 'Collections DebiCheck', NULL, NULL, NULL, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Command`
--

CREATE TABLE `Command` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Status` mediumtext DEFAULT NULL,
  `Mode` varchar(50) DEFAULT NULL,
  `Enabled` varchar(50) DEFAULT NULL,
  `BatchInt` int(11) DEFAULT NULL,
  `Path` mediumtext DEFAULT NULL,
  `Command` mediumtext DEFAULT NULL,
  `OrderInt` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Command`
--

INSERT INTO `Command` (`Id`, `Name`, `Status`, `Mode`, `Enabled`, `BatchInt`, `Path`, `Command`, `OrderInt`) VALUES
(1, 'Reset - Update CollectionSummary SSVS', NULL, NULL, NULL, 4, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionSummary SET CollectionStatus=\"Unprepared\" WHERE Id = 3797\');', 3),
(2, 'Update CollectionMethod SSVS', NULL, NULL, NULL, 4, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionMethod SET BeingProcessed=\"False\", CurrentSequenceNumber=408 WHERE Id = 3\');', 1),
(3, 'Update Policies SSVS', NULL, NULL, NULL, 4, NULL, 'CollectionManager::executeCollectionQuery(\'update policy set DebitOrderDay = 8, NettPremium = 0.01 where CollectionMethod = 3 limit 200\');', 2),
(4, 'Reset - Update CollectionSummary Naedo', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\' UPDATE CollectionSummary SET CollectionStatus=\"Unprepared\" WHERE Id = 3786\');', 3),
(5, 'Update CollectionMethod Naedo', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\' UPDATE CollectionMethod SET BeingProcessed=\"False\", CurrentSequenceNumber=514 WHERE Id = 4\');', 1),
(6, 'Update Policies  Naedo', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\' update policy set DebitOrderDay = 25, NettPremium = 0.01 where CollectionMethod = 4\');', 2),
(7, 'Reset Response Items', NULL, NULL, NULL, 6, NULL, 'CollectionManager::executeCollectionQuery(\'update CollectionResponseItem set RowStatus = \"Pending\", CollectionItem = NULL, PaymentId = NULL\');', 4),
(8, 'Update Response Items to Processed', NULL, NULL, NULL, 6, NULL, 'CollectionManager::executeCollectionQuery(\'update CollectionResponseItem set RowStatus = \"Processed\"\');', 6),
(9, 'Reset Delete All', NULL, NULL, NULL, 6, NULL, 'CollectionManager::executeCollectionQuery(\' delete from CollectionResponseItem\');', 5),
(10, 'Get Latest Limited', NULL, NULL, NULL, 7, NULL, 'foreach (CollectionTextFile::QueryArray(QQ::All(), \nQQ::Clause(\n  QQ::Select(QQN::CollectionTextFile()->Id, \n          QQN::CollectionTextFile()->FileType), \n  QQ::OrderBy(QQN::CollectionTextFile()->Id, false),\n  QQ::LimitInfo(10)\n)\n) as $CTFObj) {\n  echo $CTFObj->Id.\' \'.$CTFObj->FileType.\'\\n\';\n}', 2),
(12, 'Purge Processed', NULL, NULL, NULL, 6, NULL, 'CollectionManager::executeCollectionQuery(\' delete from CollectionResponseItem WHERE RowStatus != \"Pending\"\');', 3),
(13, 'Reset CollectionItems', NULL, NULL, NULL, 8, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionItem SET Notes=\"Initialized\",  CollectionItemStatus = \"Not Submitted\" WHERE UniqueReference IN (\"SPA00003      201112\",\"0989315868\")\');', 1),
(14, 'Delete New Transactions', NULL, NULL, NULL, 1, NULL, 'MobilityTransaction::GetDatabase()->Query(\'\nDELETE FROM MobilityTransaction WHERE PremiumMonth=\"11/20\"\n\');', 1),
(15, 'Process Response Items (Something is wrong)', NULL, NULL, NULL, 6, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/CollectionTextFileBackgroundScript.php\',array(\"CId\" => \"ProcessBank_ProcessResponseItems\", \"Mode\" => CollectionTextFileMode::FILE_MODE_PROCESS_RESPONSE_ITEMS_STR),-1);', 2),
(16, 'Update TenantId', NULL, NULL, NULL, 9, NULL, '$ResultObj = Policy::GetDatabase()->Query(\'update Policy set TenantId = 2 where UniquePolicyNumber = \"FA000008\"\');', 3),
(17, 'Get Policy Numbers', NULL, NULL, NULL, 9, NULL, 'foreach (Policy::QueryArray(QQ::AndCondition(\nQQ::Equal(QQN::Policy()->ProductId, 24), \nQQ::Equal(QQN::Policy()->Active, 0)),\nQQ::Clause(QQ::Select(QQN::Policy()->UniquePolicyNumber), QQ::LimitInfo(10))) as $PolicyObj)  { \necho $PolicyObj->UniquePolicyNumber.\'\\n\';\n }', 2),
(18, 'Get Latest MobilityTransactions', NULL, NULL, NULL, 1, NULL, 'foreach (MobilityTransaction::QueryArray(\n  QQ::All(),\n  QQ::Clause(\n    QQ::LimitInfo(10),\n    QQ::OrderBy(QQN::MobilityTransaction()->Id, false)\n  )\n) as $MobilityTransactionObj) { \n  echo $MobilityTransactionObj->Id.\'\\n\';\n}', 2),
(19, 'Authorise Payments by reference', NULL, NULL, NULL, 2, NULL, 'Payment::GetDatabase()->Query(\'UPDATE Payment set PaymentStatus = \"Authorised\" WHERE PaymentReference =\"BrettTest\"\n\');', 1),
(20, 'Get Attribute', NULL, NULL, NULL, 9, NULL, 'echo Policy::QuerySingle(QQ::Equal(QQN::Policy()->UniquePolicyNumber, \"TMA2DA5D\"))->GrossPremium;', 4),
(21, 'Get Inactive Policies by Consultant Code', NULL, NULL, NULL, 10, NULL, 'foreach (Policy::QueryArray(QQ::AndCondition(\nQQ::Equal(QQN::Policy()->ConsultantCodeId, 1454), \nQQ::IsNull(QQN::Policy()->ContractStatusReason)),\nQQ::Clause(QQ::Select(QQN::Policy()->UniquePolicyNumber), \nQQ::LimitInfo(10))) as $PolicyObj)  { echo $PolicyObj->UniquePolicyNumber.\'\\n\';}', 1),
(22, 'Get Consultant Code for Policy', NULL, NULL, NULL, 10, NULL, 'echo Policy::QuerySingle(QQ::Equal(QQN::Policy()->UniquePolicyNumber, \"TMA26900\"))->ConsultantCodeId;', 2),
(24, 'Get Latest Specific TextFile', NULL, NULL, NULL, 7, NULL, 'foreach (CollectionTextFile::QueryArray(QQ::Equal(QQN::CollectionTextFile()->FileType, \"Unpaid Response\"), QQ::Clause(QQ::LimitInfo(5), QQ::OrderBy(QQN::CollectionTextFile()->Id, false))) as $Obj) {\n    echo $Obj->Id.\'\\n\';\n}\n', 4),
(26, 'Get Policies for Payment', NULL, NULL, NULL, 2, NULL, 'foreach (Policy::QueryArray(\nQQ::AndCondition(\n  QQ::Equal(QQN::Policy()->Active, 1)\n),\nQQ::Clause(QQ::Select(QQN::Policy()->UniquePolicyNumber), \n  QQ::LimitInfo(10))) as $PolicyObj)  { \n  echo $PolicyObj->UniquePolicyNumber.\'\\n\';\n}', 2),
(28, 'Being Processed', NULL, NULL, NULL, 2, NULL, 'CollectionMethod::GetDatabase()->Query(\'UPDATE CollectionMethod SET BeingProcessed=\"False\"\');', 3),
(31, 'Process Files', NULL, NULL, NULL, 6, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/CollectionTextFileBackgroundScript.php\',array(\"CId\" => \"ProcessBank_ProcessResponseItems\", \"Mode\" => CollectionTextFileMode::FILE_MODE_PROCESS_FILES_STR),-1);', 1),
(32, 'Test Case  Naedo', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionTextFile SET \nFileStatus = \"Pending\" WHERE Id IN (20208,20207,20206,20205)\');', 7),
(33, 'Delete Collection Items', NULL, NULL, NULL, 8, NULL, 'CollectionManager::executeCollectionQuery(\'DELETE FROM CollectionItem WHERE CalenderMonthDebitedFor = \"11/20\"\');', 2),
(35, 'Test Case 1', NULL, NULL, NULL, 2, NULL, 'CollectionMethod::GetDatabase()->Query(\' UPDATE CollectionMethod SET BeingProcessed=\"False\", CurrentSequenceNumber=254 WHERE Id = 3\');', 4),
(36, 'Test Case 2', NULL, NULL, NULL, 2, NULL, 'CollectionMethod::GetDatabase()->Query(\'UPDATE CollectionTextFile SET FileStatus =\"Pending\" WHERE Id IN (20195,20198)\');', 5),
(37, 'Test Case 3', NULL, NULL, NULL, 2, NULL, 'Payment::GetDatabase()->Query(\'UPDATE Payment set PaymentStatus = \"Submitting\" WHERE Id IN (697,698)\');', 6),
(38, 'Reset - Update Policies', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'update policies_dev0.Policy set AnniversaryDate = \"2021-01-09\", SumAssured = 60000, BasePremium = 200, GrossPremium = 300, NettPremium = 250, PolicyFee = 50, ProductId = 16 where ProductId IN (16,30) and Active = 1\');', 3),
(39, 'Reset - Delete PolicyAnniversary', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'DELETE policies_dev0.PolicyAnniversary FROM policies_dev0.PolicyAnniversary JOIN Policy ON PolicyAnniversary.Policy = Policy.Id WHERE Policy.ProductId IN (16,30)\');', 4),
(40, 'Run Pre Policy Anniversary Calculations', NULL, NULL, NULL, 12, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/BackgroundScript_PrePolicyAnniversaryCalculations.php\',array(\"CId\" => \"Scheduler37_\", \"SchedulerActionId\" => 34),-1);', 1),
(41, 'Run Process Policy Anniversary', NULL, NULL, NULL, 12, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/BackgroundScript_PolicyAnniversaryProcessing.php\',array(\"CId\" => \"Scheduler40_\", \"SchedulerActionId\" => 37),-2);', 2),
(44, 'Debug Single', NULL, NULL, NULL, 13, NULL, '$VersionOneId = null;\n$ProductInfoObj = ProductInformation::QuerySingle(\nQQ::AndCondition(\nQQ::Equal(QQN::ProductInformation()->ProductObject->Status, \'Active\'),\nQQ::Equal(QQN::ProductInformation()->ProductObject->Published, \'1\'),QQ::Equal(QQN::ProductInformation()->ProductObject->VersionOneProductId, $VersionOneId)),\nQQ::Clause(QQ::OrderBy(QQN::ProductInformation()->ProductSortIndex),\nQQ::OrderBy(QQN::ProductInformation()->ProductInformationVersion),\nQQ::OrderBy(QQN::ProductInformation()->ProductObject->StartDate, false),\nQQ::Select(QQN::ProductInformation()->ProductObject)));\necho $ProductInfoObj->getJson();', 0),
(45, 'Debug Array', NULL, NULL, NULL, 13, NULL, '$VersionOneIdArr = array(null);\n$ProductInfoArr = ProductInformation::QueryArray(\nQQ::AndCondition(\nQQ::Equal(QQN::ProductInformation()->ProductObject->Status, \'Active\'),\nQQ::Equal(QQN::ProductInformation()->ProductObject->Published, \'1\'),QQ::In(QQN::ProductInformation()->ProductObject->VersionOneProductId, $VersionOneIdArr)),\nQQ::Clause(QQ::OrderBy(QQN::ProductInformation()->ProductSortIndex),\nQQ::OrderBy(QQN::ProductInformation()->ProductInformationVersion),\nQQ::OrderBy(QQN::ProductInformation()->ProductObject->StartDate, false),\nQQ::Select(QQN::ProductInformation()->ProductObject)));\necho reset($ProductInfoArr)->getJson();', 0),
(46, 'Latest Active Product', NULL, NULL, NULL, 13, NULL, '$ProductObj = Product::Load(9);\necho AppSpecificFunctions::getLatestActivePublishedProduct($ProductObj)->Id;', 0),
(49, 'Policy Sales Event', NULL, NULL, NULL, 13, NULL, '$PolicyArr = Policy::QueryArray(QQ::Equal(QQN::Policy()->Active, \"1\"), QQ::Clause(QQ::Select(QQN::Policy()->Active),QQ::Select(QQN::Policy()->CollectionMethodObject),QQ::LimitInfo(10)));\necho $PolicyArr[0]->CollectionMethodObject->CollectionType;', 0),
(50, 'Beneficiary', NULL, NULL, NULL, 13, NULL, '$PolicyIdArr = array(1,3);\n$BeneficiaryPolicyRolePlayerArr = PolicyRolePlayer::QueryArray(\n        QQ::AndCondition(\n            QQ::In(QQN::PolicyRolePlayer()->PolicyBenefitObject->PolicyObject->Id, $PolicyIdArr),\n            QQ::Equal(QQN::PolicyRolePlayer()->Active, 1),\n            QQ::Equal(QQN::PolicyRolePlayer()->RolePlayerType, \'Beneficiary\')\n        ),\n      QQ::Clause(\n        QQ::Select(\n            QQN::PolicyRolePlayer()->FirstName,\n            QQN::PolicyRolePlayer()->Surname,\n            QQN::PolicyRolePlayer()->PolicyBenefitObject->PolicyObject->Id\n        )\n      )\n    );\necho reset($BeneficiaryPolicyRolePlayerArr)->FirstName;\necho next($BeneficiaryPolicyRolePlayerArr)->FirstName;\necho reset($BeneficiaryPolicyRolePlayerArr)->PolicyBenefitObject->PolicyObject->Id; // If null, then does not work\necho reset($BeneficiaryPolicyRolePlayerArr)->PolicyBenefitObject->PolicyObject->Term; // If not null, then not optimal', 0),
(51, 'Beneficiary Raw SQL', NULL, NULL, NULL, 13, NULL, '$PolicyIdArr = array(1,3);\n// Beneficiary Policy Role Player by Policy\n    $ResultObj = PolicyRolePlayer::GetDatabase()->Query(\n    \'SELECT Policy.Id, PolicyRolePlayer.FirstName, PolicyRolePlayer.Surname FROM PolicyRolePlayer \n                JOIN PolicyBenefit ON PolicyRolePlayer.PolicyBenefit = PolicyBenefit.Id JOIN Policy ON PolicyBenefit.Policy = Policy.Id \n                where Policy.Id IN (\'.implode(\',\',$PolicyIdArr).\')\');\n    $BeneficiaryPolicyRolePlayerByPolicyKvpArr = array();\n    while ($AttributeArr = $ResultObj->FetchArray()) {\n        $BeneficiaryPolicyRolePlayerObj = new stdClass();\n        $BeneficiaryPolicyRolePlayerObj->FirstName = $AttributeArr[\'FirstName\'];\n        $BeneficiaryPolicyRolePlayerObj->Surname = $AttributeArr[\'Surname\'];\n        $BeneficiaryPolicyRolePlayerByPolicyKvpArr[$AttributeArr[\'Id\']] = $BeneficiaryPolicyRolePlayerObj;\n    }\necho $BeneficiaryPolicyRolePlayerByPolicyKvpArr[1]->FirstName;\necho $BeneficiaryPolicyRolePlayerByPolicyKvpArr[3]->FirstName;', 0),
(52, 'Beneficary Single', NULL, NULL, NULL, 13, NULL, '$PolicyId = 1;\n$BeneficiaryPolicyRolePlayerObj = PolicyRolePlayer::QuerySingle(\n        QQ::AndCondition(\n            QQ::Equal(QQN::PolicyRolePlayer()->PolicyBenefitObject->PolicyObject->Id, $PolicyId),\n            QQ::Equal(QQN::PolicyRolePlayer()->Active, 1),\n            QQ::Equal(QQN::PolicyRolePlayer()->RolePlayerType, \'Beneficiary\')\n        ),\n      QQ::Clause(\n        QQ::Select(\n            QQN::PolicyRolePlayer()->FirstName,\n            QQN::PolicyRolePlayer()->Surname,\n            QQN::PolicyRolePlayer()->PolicyBenefitObject->PolicyObject->Id\n        )\n      )\n    );\necho $BeneficiaryPolicyRolePlayerObj ->FirstName;\necho $BeneficiaryPolicyRolePlayerObj ->PolicyBenefitObject->PolicyObject->Id; // If null, then does not work\necho $BeneficiaryPolicyRolePlayerObj->PolicyBenefitObject->PolicyObject->Term; // If not null, then not optimal', 0),
(54, 'Generic Object Attribute Collection', NULL, NULL, NULL, 13, NULL, '$Entity = \'PolicySchedule\';\n$schedule = new stdClass();\n$schedule->Policy = \'(SELECT Id FROM Policy order by Id desc limit 1)\';\n$schedule->UniquePolicyNumber = \'Test\';\n$schedule->ExternalPolicyNumber = \'Test\';\n\ngenericInsert($Entity, $schedule);\n\nfunction genericInsert($Entity, $stdObject) {\n  $KvpArr = array();  \n  foreach (get_object_vars($stdObject) as $Key => $Value) {\n    if (!is_null($Value)) {\n      if (strpos($Value, \"SELECT\") !== false) {\n          $KvpArr[$Key] = $Value;\n      } else {\n          $KvpArr[$Key] = \'\"\'.$Value.\'\"\';\n      }\n    }\n  }\n  $Str = \'INSERT INTO \'.$Entity.\' (\'.implode(\',\',array_keys($KvpArr)).\') VALUES (\'.implode(\',\',array_values($KvpArr)).\');\';\n  $Entity::GetDatabase()->Query($Str);\n}', 0),
(55, 'get class', NULL, NULL, NULL, 13, NULL, '$PolicyObj = Policy::Load(1);\necho get_class($PolicyObj);', 0),
(56, 'Cross Modular Background Process Query Count', NULL, NULL, NULL, 3, NULL, 'echo AppSpecificFunctions::noExistingSimilarPendingOrRunningProcess(\'Policy\', \"ProcessBank\");', 1),
(57, 'Existing Process', NULL, NULL, NULL, 14, NULL, 'echo AppSpecificFunctions::noExistingSimilarPendingOrRunningProcess(\"ProcessBank\");', 1),
(59, 'Reset - Update PolicyAnniversary', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'update PolicyAnniversary set Status = \"Pending\" JOIN Policy ON PolicyAnniversary.Policy = Policy.Id WHERE Policy.ProductId IN (16,30)\');', 5),
(63, 'DFS Policy Creation', NULL, NULL, NULL, 9, NULL, '$SalesEventId = 80324;\nPolicy::GetDatabase()->MultiQuery(\'DELETE FROM Policy WHERE SalesEvent=\'.$SalesEventId.\';DELETE FROM PolicyBenefit WHERE SalesEvent=\'.$SalesEventId.\';\');\nDfsPolicyCreation::createPoliciesFromSalesEvent($SalesEventId);', 1),
(64, 'Create Policy from Sales Event Id', NULL, NULL, NULL, 17, NULL, '$SalesEventId = 80297;\n$ResultObj = json_decode(AppSpecificFunctions::CallsDevAPI(\'createPoliciesFromSalesEvent\', __POLICIES_URL__.\'/API/Object/Policy.php\', array(\"APIKEY\" => __POLICIES_API_KEY__, \"SalesEventId\" => $SalesEventId),\'\',\'\'));\necho $ResultObj->Message;\nif ($ResultObj && $ResultObj->Result == \'Success\') {\n  echo \'Yeah booi\';\n} else {\n  echo \'Ahh nooo\';\n}', 1),
(65, 'Reset Delete Policy And Benefit for SalesEvent', NULL, NULL, NULL, 17, NULL, '$SalesEventId = 80297;\nPolicy::GetDatabase()->MultiQuery(\'DELETE FROM Policy WHERE SalesEvent=\'.$SalesEventId.\';DELETE FROM PolicyBenefit WHERE SalesEvent=\'.$SalesEventId.\';\');', 2),
(69, 'Latest Dispute Files  Naedo', NULL, NULL, NULL, 5, NULL, 'foreach (CollectionTextFile::QueryArray(QQ::Equal(QQN::CollectionTextFile()->FileType, \"Dispute Response\"), QQ::Clause(QQ::LimitInfo(5), QQ::OrderBy(QQN::CollectionTextFile()->Id, false))) as $Obj) {\n    echo $Obj->Id.\'\\n\';\n}', 6),
(70, 'Dispute  Naedo', NULL, NULL, NULL, 5, NULL, 'echo CollectionTextFile::Load(20206)->Content;\nCollectionManager::executeCollectionQuery(\'UPDATE CollectionTextFile SET \nFileStatus = \"Pending\" WHERE Id IN (20206)\');', 5),
(71, 'Get Latest Unpaid Files SSVS', NULL, NULL, NULL, 4, NULL, 'foreach (CollectionTextFile::QueryArray(QQ::Equal(QQN::CollectionTextFile()->FileType, \"Unpaid Response\"), QQ::Clause(QQ::LimitInfo(5), QQ::OrderBy(QQN::CollectionTextFile()->Id, false))) as $Obj) {\n    echo $Obj->Id.\'\\n\';\n}', 5),
(72, 'Test Case - Unpaid SSVS', NULL, NULL, NULL, 4, NULL, 'echo CollectionTextFile::Load(19926)->Content;\nCollectionManager::executeCollectionQuery(\'UPDATE CollectionTextFile SET FileStatus = \"Pending\" WHERE Id IN (19926)\');', 6),
(73, 'Non Debit Dates', NULL, NULL, NULL, 11, NULL, '$NonDebitDates = DatabaseHelper::getObjectArray(\'NonDebitDate\', array(\"NonDebitDate\"), \"NonDebitDate > \".QDateTime::Now()->format(\'Y/m/d\'), null, 10000, null, $ErrorInfo);\nforeach($NonDebitDates as $Obj) {\n   echo $Obj;\n}', 1),
(76, 'Run Cease Script', NULL, NULL, NULL, 19, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/BackgroundScript_PolicyAnniversaryCease.php\',array(\"CId\" => \"Scheduler60_\", \"SchedulerActionId\" => 53),-1);', 1),
(77, 'Reset Policies', NULL, NULL, NULL, 19, NULL, 'Policy::GetDatabase()->Query(\'update Policy set AnniversaryDate = \"2021-01-05\", Active = 1 where ProductId IN (16,30)\');', 2),
(78, 'Setup Policies', NULL, NULL, NULL, 20, NULL, 'Policy::GetDatabase()->Query(\'update Policy set DebitOrderDay = 05, Active = 1, ContractPaymentStatus = \"ACTIVE\", InceptionDate = NULL, FirstDebitDate = NULL where ProductId IN (16,30) LIMIT 100\');', 1),
(79, 'Delete Policy Notifications', NULL, NULL, NULL, 20, NULL, 'PolicyNotification::GetDatabase()->Query(\'delete from PolicyNotification where Communication = 626\');', 2),
(80, 'Get Latest Distinct', NULL, NULL, NULL, 7, NULL, '$LimitbyInt = 1;\nforeach (array(\n\"CollectionMethod = 1 AND FileType = \'Interim Audit File\'\",\n\"CollectionMethod = 1 AND FileType = \'Final Audit File\'\",\n\"CollectionMethod = 2 AND FileType = \'Interim Audit File\'\",\n\"CollectionMethod = 2 AND FileType = \'Response\'\"\n) as $FilterStr) {\n$ResultObj = CollectionTextFile::GetDatabase()->Query(\"SELECT Id, FileType, CollectionMethod FROM CollectionTextFile WHERE \".$FilterStr.\" ORDER BY Id DESC LIMIT \".$LimitbyInt);\nwhile ($AttributeArr = $ResultObj->FetchArray()) {\n  echo $AttributeArr[\'Id\'].\' \'.$AttributeArr[\'FileType\'].\' \'.$AttributeArr[\'CollectionMethod\'].\' \'.\'\\n\';\n}\n}', 1),
(82, 'Reset BeingProcessed', NULL, NULL, NULL, 21, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionMethod SET BeingProcessed=\"False\"\');', 1),
(83, 'Reset - Delete CollectionItems SSVS', NULL, NULL, NULL, 4, NULL, 'CollectionManager::executeCollectionQuery(\'DELETE FROM CollectionItem WHERE CollectionSummary = 3784\');', 4),
(85, 'Reset - Delete CollectionItems Naedo', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\'DELETE FROM CollectionItem WHERE CollectionSummary = 3786\');', 4),
(94, 'Objects and KVP', NULL, NULL, NULL, 25, NULL, '$Arr = [(object)[\"Test\" => 1],(object)[\"Test\" => 2],(object)[\"Test\" => 3]];\n$KvpArr = Helper::getKvp($Arr, \"Test\");\necho json_encode(array_keys($KvpArr));\necho is_array($Arr);\necho count($Arr);', 1),
(96, 'Pointers by string', NULL, NULL, NULL, 26, NULL, '$a=\"b\";\n$b=\"c\";\n$c=\"d\";\n$d=\"e\";\n$e=\"f\";\n\necho $a.\"-\";\necho $$a.\"-\";   //Same as $b\necho $$$a.\"-\";  //Same as $$b or $c\necho $$$$a.\"-\"; //Same as $$$b or $$c or $d\necho $$$$$a;    //Same as $$$$b or $$$c or $$d or $e', 1),
(97, 'Generate pending PolicyNotifications', NULL, NULL, NULL, 27, NULL, '$QuantityInt = 60;\n$SqlStr = \'\';\nfor ($i = 0; $i < $QuantityInt; $i++) {\nswitch ($i % 3) {\ncase 0: $CommunicationId = 626; break;\ncase 1: $CommunicationId = 743; break;\ncase 2: $CommunicationId = 744; break;\n}\n$SqlStr .= \'INSERT INTO communications_dev0.PolicyNotification (PolicyId, PolicyScheduleId, Notified, Communication, DateCreated, IndividualId) VALUES (1,405676,0, \'.$CommunicationId.\', \"2021-02-04\", 328972);\';\n}\necho $SqlStr;\nPolicyNotification::GetDatabase()->MultiQuery($SqlStr);', 3),
(98, 'Change Brett to MobiLifeAdmin', NULL, NULL, NULL, 28, NULL, 'SystemModuleRoleLink::GetDatabase()->NonQuery(\'UPDATE SystemModuleRoleLink set SystemUserRole = 9 WHERE SystemModule = 3 AND Individual = 328972\');', 1),
(99, 'Change Brett to MobiLifeUser', NULL, NULL, NULL, 28, NULL, 'SystemModuleRoleLink::GetDatabase()->NonQuery(\'UPDATE SystemModuleRoleLink set SystemUserRole = 10 WHERE SystemModule = 3 AND Individual = 328972\');', 2),
(101, 'Add SystemUserRoleLinks', NULL, NULL, NULL, 29, NULL, 'SystemModuleRoleLink::GetDatabase()->MultiQuery(\'INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 1, 1); INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 2, 5);INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 3, 10);INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 4, 13);INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 5, 17);INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 6, 21);INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 7, 25);INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 8, 39);INSERT INTO members_dev0.SystemModuleRoleLink (Individual, SystemModule, SystemUserRole) VALUES (329055, 9, 41);\');', 1),
(102, 'Find Payment By UniquePolicyNumber', NULL, NULL, NULL, 2, NULL, '$ResultObj = Payment::GetDatabase()->Query(\'SELECT * FROM finance_dev0.Payment p WHERE PolicyId = (SELECT Id FROM policies_dev0.Policy WHERE Policy.UniquePolicyNumber =\"TMA0726A\")\');\nwhile ($AttributeArr = $ResultObj->FetchAssocArray()) {\n  foreach ($AttributeArr as $AttributeKey => $AttributeValue) {\n    echo $AttributeKey.\' \'.$AttributeValue.\'\\n\';\n  }\n}\n', 7),
(103, '', NULL, NULL, NULL, 30, NULL, '// DISABLE SQUIGGLES IN REPORT!!!', 1),
(104, 'Run PolicyNotification script', NULL, NULL, NULL, 27, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/BackgroundScript_PolicyNotifications.php\',array(\"CId\" => \"Scheduler33_\", \"SchedulerActionId\" => 30),328972);', 4),
(105, 'Switch ON Comms', NULL, NULL, NULL, 27, NULL, 'ApplicationConfiguration::GetDatabase()->NonQuery(\'UPDATE main_dev0.ApplicationConfiguration SET AllowCommunication = \"{\\\"Communications-Module\\\":1}\" WHERE Id = 1;\');', 5),
(106, 'Switch OFF Comms', NULL, NULL, NULL, 27, NULL, 'ApplicationConfiguration::GetDatabase()->NonQuery(\'UPDATE main_dev0.ApplicationConfiguration SET AllowCommunication = \"{\\\"Communications-Module\\\":0}\" WHERE Id = 1;\');', 6),
(107, 'Get Latest Background Process Updates', NULL, NULL, NULL, 27, NULL, '$ResultObj = Communication::GetDatabase()->Query(\'SELECT UpdateMessage FROM communications_dev0.BackgroundProcessUpdate WHERE BackgroundProcess = (SELECT BackgroundProcess FROM communications_dev0.BackgroundProcessUpdate ORDER BY BackgroundProcess DESC LIMIT 1)\');\nwhile ($AttributeArr = $ResultObj->FetchAssocArray()) {\n  foreach ($AttributeArr as $KeyStr => $ValueStr) {\n    echo $ValueStr.\'\\n\';\n  }\n}', 7),
(108, 'Custom Emailer Old', NULL, NULL, NULL, 27, NULL, 'ApplicationConfiguration::GetDatabase()->NonQuery(\'UPDATE main_dev0.ApplicationConfiguration SET AllowCommunication = \"{\\\"Communications-Module\\\":1}\" WHERE Id = 1;\');\n$StartTimeFlt = microtime(true);\n$QtyInt = 5;\n$CommunicationObj = Communication::Load(626);\n//$CommunicationObj = null;\nfor ($i = 0; $i < $QtyInt; $i++) {\n$MailObj = new sEmailMessage([\'brett.coetzee@stratusolve.com\'],\n    \'Custom Email Old- Started\'.$i,\n    \'Custom Email Old - Started\'.$i,\nnull,null,null,null,null,null,$CommunicationObj\n  );\n  $MailObj->sendMail();\n}\necho \'Total Time:\'.(microtime(true) - $StartTimeFlt);\nApplicationConfiguration::GetDatabase()->NonQuery(\'UPDATE main_dev0.ApplicationConfiguration SET AllowCommunication = \"{\\\"Communications-Module\\\":0}\" WHERE Id = 1;\');', 2),
(109, 'Custom Emailer New', NULL, NULL, NULL, 27, NULL, '//ApplicationConfiguration::GetDatabase()->NonQuery(\'UPDATE main_dev0.ApplicationConfiguration SET AllowCommunication = \"{\\\"Communications-Module\\\":1}\" WHERE Id = 1;\');\n// Slack\n$StartTimeFlt = microtime(true);\n$QtyInt = 5;\n$EmailServer1Obj = EmailServer::Load(1);\n$EmailServer2Obj = EmailServer::Load(2);\n$EmailServerObj = null;\nEmailSender::startSmtpServer($EmailServer1Obj);\nEmailSender::startSmtpServer($EmailServer2Obj);\nfor ($i = 0; $i < $QtyInt; $i++) {\n  EmailSender::send([\'brett.coetzee@stratusolve.com\'],\n    \'Custom Email New - Started\',\n    \'Custom Email New - Started\');\n}\nEmailSender::stopSmtpServer();\necho \'Total Time:\'.(microtime(true) - $StartTimeFlt);\n//ApplicationConfiguration::GetDatabase()->NonQuery(\'UPDATE main_dev0.ApplicationConfiguration SET AllowCommunication = \"{\\\"Communications-Module\\\":0}\" WHERE Id = 1;\');\n// Slack', 1),
(111, 'Log', NULL, NULL, NULL, 32, NULL, 'AppSpecificFunctions::AddCustomLog(\'Testing Brett\', false, false, [SERVER_INSTANCE]);', 1),
(112, 'Delete All PolicyNotifications', NULL, NULL, NULL, 27, NULL, 'PolicyNotification::GetDatabase()->NonQuery(\'DELETE FROM PolicyNotification\');', 8),
(113, 'Change Lesenya to MobiLifeAdmin', NULL, NULL, NULL, 28, NULL, 'SystemModuleRoleLink::GetDatabase()->NonQuery(\'UPDATE SystemModuleRoleLink set SystemUserRole = 9 WHERE SystemModule = 3 AND Individual = 328973\');', 3),
(114, 'Change Lesenya to MobiLifeUser', NULL, NULL, NULL, 28, NULL, 'SystemModuleRoleLink::GetDatabase()->NonQuery(\'UPDATE SystemModuleRoleLink set SystemUserRole = 10 WHERE SystemModule = 3 AND Individual = 328973\');', 4),
(115, 'Update Debicheck Policies', NULL, NULL, NULL, 33, NULL, 'CollectionManager::executeCollectionQuery(\'update policy set DebitOrderDay = 10, NettPremium = 0.01 where CollectionMethod = 7 limit 200\');', 1),
(116, 'Update CollectionMethod Debicheck', NULL, NULL, NULL, 33, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionMethod SET BeingProcessed=\"False\", CurrentSequenceNumber=3 WHERE Id = 7\');', 2),
(117, 'Reset - Update CollectionSummary DebiCheck', NULL, NULL, NULL, 33, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionSummary SET CollectionStatus=\"Unprepared\" WHERE Id = 3799\');', 3);

-- --------------------------------------------------------

--
-- Table structure for table `Config`
--

CREATE TABLE `Config` (
  `Id` int(11) NOT NULL,
  `AutomationId` int(11) DEFAULT NULL,
  `BatchId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Config`
--

INSERT INTO `Config` (`Id`, `AutomationId`, `BatchId`) VALUES
(1, 1, 27);

-- --------------------------------------------------------

--
-- Table structure for table `Report`
--

CREATE TABLE `Report` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Status` mediumtext DEFAULT NULL,
  `Mode` varchar(50) DEFAULT NULL,
  `Enabled` varchar(50) DEFAULT NULL,
  `CommandInt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Automation`
--
ALTER TABLE `Automation`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `Batch`
--
ALTER TABLE `Batch`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `Command`
--
ALTER TABLE `Command`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `Config`
--
ALTER TABLE `Config`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `Report`
--
ALTER TABLE `Report`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Automation`
--
ALTER TABLE `Automation`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Batch`
--
ALTER TABLE `Batch`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `Command`
--
ALTER TABLE `Command`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `Config`
--
ALTER TABLE `Config`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Report`
--
ALTER TABLE `Report`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
