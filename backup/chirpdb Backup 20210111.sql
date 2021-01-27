-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2021 at 08:54 AM
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
-- Database: `chirpdb`
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
  `Enabled` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Automation`
--

INSERT INTO `Automation` (`Id`, `Name`, `Status`, `Mode`, `Enabled`) VALUES
(1, 'Policies Module', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Policies-Module/test2.php', NULL),
(2, 'Finance Module', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Finance-Module/test.php', NULL),
(3, 'Main Module', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Main-Module/test.php', NULL),
(4, 'Communications', NULL, 'https://mobilife-dev0.stratusolvecloud.com/Communications-Module/test2.php', NULL),
(5, '', NULL, '', NULL);

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
  `AutomationInt` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Batch`
--

INSERT INTO `Batch` (`Id`, `Name`, `Status`, `Mode`, `Enabled`, `AutomationInt`) VALUES
(1, 'MobilityTransaction', NULL, NULL, NULL, 2),
(2, 'Payments', NULL, NULL, NULL, 2),
(3, 'BackgroundProcess', NULL, NULL, NULL, 2),
(4, 'Collections SSVS', NULL, NULL, NULL, 1),
(5, 'Collections Naedo', NULL, NULL, NULL, 1),
(6, 'ResponseItems', NULL, NULL, NULL, 1),
(7, 'CollectionTextFile', NULL, NULL, NULL, 1),
(8, 'CollectionItem', NULL, NULL, NULL, 1),
(9, 'Policy', NULL, NULL, NULL, 1),
(10, 'Third Party', NULL, NULL, NULL, 3),
(11, 'CollectionSummary', NULL, NULL, NULL, 1),
(12, 'Anniversary', NULL, NULL, NULL, 4),
(13, 'Debugging', NULL, NULL, NULL, 4),
(14, 'BackgroundProcess', NULL, NULL, NULL, 1),
(15, 'Basics', NULL, NULL, NULL, 4),
(16, 'PolicyRolePlayer', NULL, NULL, NULL, 1),
(17, 'DFS ', NULL, NULL, NULL, 3),
(18, '', NULL, NULL, NULL, 5),
(19, 'Cease', NULL, NULL, NULL, 4),
(20, 'Pre Policy Debit', NULL, NULL, NULL, 4);

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
  `Command` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Command`
--

INSERT INTO `Command` (`Id`, `Name`, `Status`, `Mode`, `Enabled`, `BatchInt`, `Path`, `Command`) VALUES
(1, 'Update CollectionSummary', NULL, NULL, NULL, 4, NULL, 'CollectionManager::executeCollectionQuery(\' UPDATE CollectionSummary SET CollectionStatus=\"Unprepared\" WHERE Id = 3773\');'),
(2, 'Update BeingProcessed', NULL, NULL, NULL, 4, NULL, 'CollectionManager::executeCollectionQuery(\n\'UPDATE CollectionMethod\nSET \nBeingProcessed=\"False\",\nCurrentSequenceNumber=251 \nWHERE Id = 5\'\n);'),
(3, 'Update DebitOrderDay', NULL, NULL, NULL, 4, NULL, 'CollectionManager::executeCollectionQuery(\n\'update policy set DebitOrderDay = 11 where CollectionMethod = 5\'\n);'),
(4, 'Update CollectionSummary', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\' UPDATE CollectionSummary SET CollectionStatus=\"Unprepared\" WHERE Id = 3773\');'),
(5, 'Update CollectionMethod', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\' UPDATE CollectionMethod SET BeingProcessed=\"False\", CurrentSequenceNumber=441 WHERE Id = 4\');'),
(6, 'Update Policy', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\' update policy set DebitOrderDay = 20, NettPremium = 0.01 where CollectionMethod = 4\');'),
(7, 'Reset Response Items', NULL, NULL, NULL, 6, NULL, 'CollectionManager::executeCollectionQuery(\' update CollectionResponseItem set RowStatus = \"Pending\", CollectionItem = NULL\');'),
(8, 'Update Response Items to Processed', NULL, NULL, NULL, 6, NULL, 'CollectionManager::executeCollectionQuery(\' update CollectionResponseItem set RowStatus = \"Processed\"\');'),
(9, 'Delete All', NULL, NULL, NULL, 6, NULL, 'CollectionManager::executeCollectionQuery(\' delete from CollectionResponseItem\');'),
(10, 'Get Latest', NULL, NULL, NULL, 7, NULL, 'foreach (CollectionTextFile::QueryArray(QQ::All(), \nQQ::Clause(\n  QQ::Select(QQN::CollectionTextFile()->Id, \n          QQN::CollectionTextFile()->FileType), \n  QQ::OrderBy(QQN::CollectionTextFile()->Id, false),\n  QQ::LimitInfo(10)\n)\n) as $CTFObj) {\n  echo $CTFObj->Id.\' \'.$CTFObj->FileType.\'\\n\';\n}'),
(11, 'Get Specific Attributes', NULL, NULL, NULL, 7, NULL, 'echo CollectionTextFile::Load(20195)->FileType;'),
(12, 'Purge Processed', NULL, NULL, NULL, 6, NULL, 'CollectionManager::executeCollectionQuery(\' delete from CollectionResponseItem WHERE RowStatus != \"Pending\"\');'),
(13, 'Reset CollectionItems', NULL, NULL, NULL, 8, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionItem SET Notes=\"Initialized\",  CollectionItemStatus = \"Not Submitted\" WHERE UniqueReference IN (\"SPA00003      201112\",\"0989315868\")\');'),
(14, 'Delete New Transactions', NULL, NULL, NULL, 1, NULL, 'MobilityTransaction::GetDatabase()->Query(\'\nDELETE FROM MobilityTransaction WHERE PremiumMonth=\"11/20\"\n\');'),
(15, 'Process Response Items', NULL, NULL, NULL, 6, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/CollectionTextFileBackgroundScript.php\',array(\"CId\" => \"ProcessBank_ProcessResponseItems\", \"Mode\" => CollectionTextFileMode::FILE_MODE_PROCESS_RESPONSE_ITEMS_STR),-1);'),
(16, 'Update TenantId', NULL, NULL, NULL, 9, NULL, '$PolicyDatabaseObj = Policy::GetDatabase();\n$ResultObj = $PolicyDatabaseObj->Query(\'update Policy set TenantId = 2 where UniquePolicyNumber=\"FA000008\"\');\n// while ($RowArr = $ResultObj->FetchArray()'),
(17, 'Foreach Policy', NULL, NULL, NULL, 9, NULL, 'foreach (Policy::QueryArray(\nQQ::AndCondition(\nQQ::Equal(QQN::Policy()->ProductId, 24), \nQQ::Equal(QQN::Policy()->Active, 0)\n),\nQQ::Clause(QQ::Select(QQN::Policy()->UniquePolicyNumber), \nQQ::LimitInfo(10))) as $PolicyObj)  { \necho $PolicyObj->UniquePolicyNumber.\'\\n\';\n }'),
(18, 'Get Latest MobilityTransactions', NULL, NULL, NULL, 1, NULL, 'foreach (MobilityTransaction::QueryArray(\n  QQ::All(),\n  QQ::Clause(\n    QQ::LimitInfo(10),\n    QQ::OrderBy(QQN::MobilityTransaction()->Id, false)\n  )\n) as $MobilityTransactionObj) { \n  echo $MobilityTransactionObj->Id.\'\\n\';\n}'),
(19, 'Authorise Payments by reference', NULL, NULL, NULL, 2, NULL, 'Payment::GetDatabase()->Query(\'UPDATE Payment set PaymentStatus = \"Authorised\" WHERE PaymentReference =\"BrettTest\"\n\');'),
(20, 'Get Attribute', NULL, NULL, NULL, 9, NULL, 'echo Policy::QuerySingle(QQ::Equal(QQN::Policy()->UniquePolicyNumber, \"TMA2DA5D\"))->GrossPremium;\necho \'\\n\'.Policy::QuerySingle(QQ::Equal(QQN::Policy()->UniquePolicyNumber, \"TMA2DA5D\"))->NettPremium;'),
(21, 'Get Inactive Policies by Consultant Code', NULL, NULL, NULL, 10, NULL, 'foreach (Policy::QueryArray(\nQQ::AndCondition(\nQQ::Equal(QQN::Policy()->ConsultantCodeId, 1454), \nQQ::IsNull(QQN::Policy()->ContractStatusReason)\n),\nQQ::Clause(QQ::Select(QQN::Policy()->UniquePolicyNumber), \nQQ::LimitInfo(10))) as $PolicyObj)  { \necho $PolicyObj->UniquePolicyNumber.\'\\n\';\n }'),
(22, 'Get Consultant Code for Policy', NULL, NULL, NULL, 10, NULL, 'echo Policy::QuerySingle(QQ::Equal(QQN::Policy()->UniquePolicyNumber, \"TMA26900\"))->ConsultantCodeId;'),
(23, '', NULL, NULL, NULL, 10, NULL, ''),
(24, 'Get Latest Specific TextFile', NULL, NULL, NULL, 7, NULL, 'foreach (CollectionTextFile::QueryArray(QQ::Equal(QQN::CollectionTextFile()->FileType, \"Unpaid Response\"), QQ::Clause(QQ::LimitInfo(5), QQ::OrderBy(QQN::CollectionTextFile()->Id, false))) as $Obj) {\n    echo $Obj->Id.\'\\n\';\n}\n'),
(25, 'Set Attribute', NULL, NULL, NULL, 9, NULL, 'Policy::GetDatabase()->Query(\'update Policy set NettPremium = 1 where UniquePolicyNumber=\"TMA2DA5D\"\');'),
(26, 'Get Policies for Payment', NULL, NULL, NULL, 2, NULL, 'foreach (Policy::QueryArray(\nQQ::AndCondition(\n  QQ::Equal(QQN::Policy()->Active, 1)\n),\nQQ::Clause(QQ::Select(QQN::Policy()->UniquePolicyNumber), \n  QQ::LimitInfo(10))) as $PolicyObj)  { \n  echo $PolicyObj->UniquePolicyNumber.\'\\n\';\n}'),
(27, '', NULL, NULL, NULL, 1, NULL, ''),
(28, 'Being Processed', NULL, NULL, NULL, 2, NULL, 'CollectionMethod::GetDatabase()->Query(\'UPDATE CollectionMethod SET BeingProcessed=\"False\"\');'),
(29, 'Testing', NULL, NULL, NULL, 7, NULL, '$ResultObj= CollectionTextFile::GetDatabase()->Query(\n            \'SELECT CollectionMethod.Id,\n                                CollectionMethod.TenantId,\n                                CollectionMethod.CollectionType,\n                                CollectionTextFile.Id,\n                                CollectionTextFile.FileType, \n                                CollectionTextFile.FileName,\n                                CollectionTextFile.CollectionSummary,\n                                CollectionResponseItem.Id,\n                                CollectionResponseItem.RowStatus,\n                                CollectionResponseItem.RowContent,\n                                CollectionResponseItem.CollectionItem,\n                                CollectionResponseItem.PaymentId,\nCollectionResponseItem.CollectionTextFile\n FROM CollectionResponseItem\n                                JOIN CollectionTextFile ON CollectionResponseItem.CollectionTextFile = CollectionTextFile.Id\n                                JOIN CollectionMethod ON CollectionMethod.Id = CollectionTextFile.CollectionMethod\n                         where CollectionResponseItem.CollectionTextFile = (select CollectionResponseItem.CollectionTextFile from CollectionResponseItem \nwhere CollectionResponseItem.RowStatus = \"Pending\" order by CollectionResponseItem.Id limit 1) and CollectionResponseItem.RowStatus = \"Pending\" limit 5\');\n\n       \nwhile ($AttributeArr = $ResultObj->FetchArray()) {\nforeach ($AttributeArr as $KeyStr => $ValueStr) {\n echo $KeyStr.\' \'.$ValueStr.\'\\n\';\n}\n        }\n'),
(30, 'QQ', NULL, NULL, NULL, 7, NULL, '$ResultObj = CollectionTextFile::GetDatabase()->Query(\n    \"SELECT CollectionMethod.Id as CollectionMethodId, \n                    CollectionMethod.TenantId,\n                    CollectionMethod.CollectionType,\n                    CollectionTextFile.Id as CollectionTextFileId,\n                    CollectionTextFile.FileType, \n                    CollectionTextFile.FileName,\n                    CollectionTextFile.CollectionSummary,\n                    CollectionResponseItem.Id,\n                    CollectionResponseItem.RowStatus,\n                    CollectionResponseItem.RowContent,\n                    CollectionResponseItem.CollectionItem,\n                    CollectionResponseItem.PaymentId \n                    FROM CollectionResponseItem\n                    JOIN CollectionTextFile ON CollectionResponseItem.CollectionTextFile = CollectionTextFile.Id\n                    JOIN CollectionMethod ON CollectionMethod.Id = CollectionTextFile.CollectionMethod\n             where CollectionResponseItem.CollectionTextFile = (select CollectionResponseItem.CollectionTextFile from CollectionResponseItem \n             where CollectionResponseItem.RowStatus = \'Pending\' order by CollectionResponseItem.Id limit 1) \n             and CollectionResponseItem.RowStatus = \'Pending\' limit \".$BatchSizeInt\n        );\n        $FirstBool = true;\n        $CollectionMethodObj = new stdClass();\n        $CollectionTextFileObj = new stdClass();\n        $CollectionResponseItemArr = array();\n        while ($AttributeArr = $ResultObj->FetchArray()) {\n            if ($FirstBool) {\n                $FirstBool = false;\n                $CollectionMethodObj->Id = $AttributeArr[\"CollectionMethodId\"];\n                $CollectionMethodObj->TenantId = $AttributeArr[\"TenantId\"];\n                $CollectionMethodObj->CollectionType = $AttributeArr[\"CollectionType\"];\n                $CollectionTextFileObj->Id = $AttributeArr[\"CollectionTextFileId\"];\n                $CollectionTextFileObj->FileType = $AttributeArr[\"FileType\"];\n                $CollectionTextFileObj->FileName = $AttributeArr[\"FileName\"];\n                $CollectionTextFileObj->CollectionSummary = $AttributeArr[\"CollectionSummary\"];\n            }\n            $CollectionResponseItemObj = new stdClass();\n            $CollectionResponseItemObj->Id = $AttributeArr[\"Id\"];\n            $CollectionResponseItemObj->RowStatus = $AttributeArr[\"RowStatus\"];\n            $CollectionResponseItemObj->RowContent = $AttributeArr[\"RowContent\"];\n            $CollectionResponseItemObj->CollectionItem = $AttributeArr[\"CollectionItem\"];\n            $CollectionResponseItemObj->PaymentId = $AttributeArr[\"PaymentId\"];\n            $CollectionResponseItemArr[$AttributeArr[\"Id\"]] = $CollectionResponseItemObj;\n        }\nforeach ($CollectionResponseItemArr as $CollectionResponseItemObj) {\n        echo json_encode($CollectionResponseItemObj);\n}'),
(31, 'Process Files', NULL, NULL, NULL, 6, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/CollectionTextFileBackgroundScript.php\',array(\"CId\" => \"ProcessBank_ProcessResponseItems\", \"Mode\" => CollectionTextFileMode::FILE_MODE_PROCESS_FILES_STR),-1);'),
(32, 'Test Case', NULL, NULL, NULL, 5, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionTextFile SET \nFileStatus = \"Pending\" WHERE Id IN (20208,20207,20206,20205)\');'),
(33, 'Delete Collection Items', NULL, NULL, NULL, 8, NULL, 'CollectionManager::executeCollectionQuery(\'DELETE FROM CollectionItem WHERE CalenderMonthDebitedFor = \"11/20\"\');'),
(34, 'Complete CollectionSummary', NULL, NULL, NULL, 7, NULL, 'CollectionManager::executeCollectionQuery(\'UPDATE CollectionSummary SET CollectionStatus = \"\'.CollectionSummaryStatus::COMPLETED_STR.\'\" WHERE Id = 3759\');'),
(35, 'Test Case 1', NULL, NULL, NULL, 2, NULL, 'CollectionMethod::GetDatabase()->Query(\' UPDATE CollectionMethod SET BeingProcessed=\"False\", CurrentSequenceNumber=254 WHERE Id = 3\');'),
(36, 'Test Case 2', NULL, NULL, NULL, 2, NULL, 'CollectionMethod::GetDatabase()->Query(\'UPDATE CollectionTextFile SET FileStatus =\"Pending\" WHERE Id IN (20195,20198)\');'),
(37, 'Test Case 3', NULL, NULL, NULL, 2, NULL, 'Payment::GetDatabase()->Query(\'UPDATE Payment set PaymentStatus = \"Submitting\" WHERE Id IN (697,698)\');'),
(38, 'Reset Policies', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'update policies_dev0.Policy set AnniversaryDate = \"2021-01-09\", SumAssured = 60000, BasePremium = 200, GrossPremium = 300, NettPremium = 250, PolicyFee = 50, ProductId = 16 where ProductId IN (16,30) and Active = 1\');'),
(39, 'Purge By Min Id', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'DELETE policies_dev0.PolicyAnniversary FROM policies_dev0.PolicyAnniversary JOIN Policy ON PolicyAnniversary.Policy = Policy.Id WHERE Policy.ProductId IN (16,30)\');'),
(40, 'Pre Policy Anniversary Calculations', NULL, NULL, NULL, 12, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/BackgroundScript_PrePolicyAnniversaryCalculations.php\',array(\"CId\" => \"Scheduler37_\", \"SchedulerActionId\" => 34),-1);'),
(41, 'Process Policy Anniversary NEW', NULL, NULL, NULL, 12, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/BackgroundScript_PolicyAnniversaryProcessing.php\',array(\"CId\" => \"Scheduler40_\", \"SchedulerActionId\" => 37),-2);'),
(42, 'Process Policy Anniversary OLD', NULL, NULL, NULL, 12, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/BackgroundScript_PolicyAnniversaryProcessedCommunication.php\',array(\"CId\" => \"Scheduler40_\", \"SchedulerActionId\" => 37),-1);'),
(43, 'Delete Collection Items', NULL, NULL, NULL, 11, NULL, 'CollectionManager::deleteCollectionItems(1);'),
(44, 'Debug Single', NULL, NULL, NULL, 13, NULL, '$VersionOneId = null;\n$ProductInfoObj = ProductInformation::QuerySingle(\nQQ::AndCondition(\nQQ::Equal(QQN::ProductInformation()->ProductObject->Status, \'Active\'),\nQQ::Equal(QQN::ProductInformation()->ProductObject->Published, \'1\'),QQ::Equal(QQN::ProductInformation()->ProductObject->VersionOneProductId, $VersionOneId)),\nQQ::Clause(QQ::OrderBy(QQN::ProductInformation()->ProductSortIndex),\nQQ::OrderBy(QQN::ProductInformation()->ProductInformationVersion),\nQQ::OrderBy(QQN::ProductInformation()->ProductObject->StartDate, false),\nQQ::Select(QQN::ProductInformation()->ProductObject)));\necho $ProductInfoObj->getJson();'),
(45, 'Debug Array', NULL, NULL, NULL, 13, NULL, '$VersionOneIdArr = array(null);\n$ProductInfoArr = ProductInformation::QueryArray(\nQQ::AndCondition(\nQQ::Equal(QQN::ProductInformation()->ProductObject->Status, \'Active\'),\nQQ::Equal(QQN::ProductInformation()->ProductObject->Published, \'1\'),QQ::In(QQN::ProductInformation()->ProductObject->VersionOneProductId, $VersionOneIdArr)),\nQQ::Clause(QQ::OrderBy(QQN::ProductInformation()->ProductSortIndex),\nQQ::OrderBy(QQN::ProductInformation()->ProductInformationVersion),\nQQ::OrderBy(QQN::ProductInformation()->ProductObject->StartDate, false),\nQQ::Select(QQN::ProductInformation()->ProductObject)));\necho reset($ProductInfoArr)->getJson();'),
(46, 'Latest Active Product', NULL, NULL, NULL, 13, NULL, '$ProductObj = Product::Load(9);\necho AppSpecificFunctions::getLatestActivePublishedProduct($ProductObj)->Id;'),
(47, 'Pending', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'update PolicyAnniversary set Status = \"Pending\" where Id >  7825\');'),
(48, 'Processing', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'update PolicyAnniversary set Status = \"Processed\" where Id >  7825\');'),
(49, 'Policy Sales Event', NULL, NULL, NULL, 13, NULL, '$PolicyArr = Policy::QueryArray(QQ::Equal(QQN::Policy()->Active, \"1\"), QQ::Clause(QQ::Select(QQN::Policy()->Active),QQ::Select(QQN::Policy()->CollectionMethodObject),QQ::LimitInfo(10)));\necho $PolicyArr[0]->CollectionMethodObject->CollectionType;'),
(50, 'Beneficiary', NULL, NULL, NULL, 13, NULL, '$PolicyIdArr = array(1,3);\n$BeneficiaryPolicyRolePlayerArr = PolicyRolePlayer::QueryArray(\n        QQ::AndCondition(\n            QQ::In(QQN::PolicyRolePlayer()->PolicyBenefitObject->PolicyObject->Id, $PolicyIdArr),\n            QQ::Equal(QQN::PolicyRolePlayer()->Active, 1),\n            QQ::Equal(QQN::PolicyRolePlayer()->RolePlayerType, \'Beneficiary\')\n        ),\n      QQ::Clause(\n        QQ::Select(\n            QQN::PolicyRolePlayer()->FirstName,\n            QQN::PolicyRolePlayer()->Surname,\n            QQN::PolicyRolePlayer()->PolicyBenefitObject->PolicyObject->Id\n        )\n      )\n    );\necho reset($BeneficiaryPolicyRolePlayerArr)->FirstName;\necho next($BeneficiaryPolicyRolePlayerArr)->FirstName;\necho reset($BeneficiaryPolicyRolePlayerArr)->PolicyBenefitObject->PolicyObject->Id; // If null, then does not work\necho reset($BeneficiaryPolicyRolePlayerArr)->PolicyBenefitObject->PolicyObject->Term; // If not null, then not optimal'),
(51, 'Beneficiary Raw SQL', NULL, NULL, NULL, 13, NULL, '$PolicyIdArr = array(1,3);\n// Beneficiary Policy Role Player by Policy\n    $ResultObj = PolicyRolePlayer::GetDatabase()->Query(\n    \'SELECT Policy.Id, PolicyRolePlayer.FirstName, PolicyRolePlayer.Surname FROM PolicyRolePlayer \n                JOIN PolicyBenefit ON PolicyRolePlayer.PolicyBenefit = PolicyBenefit.Id JOIN Policy ON PolicyBenefit.Policy = Policy.Id \n                where Policy.Id IN (\'.implode(\',\',$PolicyIdArr).\')\');\n    $BeneficiaryPolicyRolePlayerByPolicyKvpArr = array();\n    while ($AttributeArr = $ResultObj->FetchArray()) {\n        $BeneficiaryPolicyRolePlayerObj = new stdClass();\n        $BeneficiaryPolicyRolePlayerObj->FirstName = $AttributeArr[\'FirstName\'];\n        $BeneficiaryPolicyRolePlayerObj->Surname = $AttributeArr[\'Surname\'];\n        $BeneficiaryPolicyRolePlayerByPolicyKvpArr[$AttributeArr[\'Id\']] = $BeneficiaryPolicyRolePlayerObj;\n    }\necho $BeneficiaryPolicyRolePlayerByPolicyKvpArr[1]->FirstName;\necho $BeneficiaryPolicyRolePlayerByPolicyKvpArr[3]->FirstName;'),
(52, 'Beneficary Single', NULL, NULL, NULL, 13, NULL, '$PolicyId = 1;\n$BeneficiaryPolicyRolePlayerObj = PolicyRolePlayer::QuerySingle(\n        QQ::AndCondition(\n            QQ::Equal(QQN::PolicyRolePlayer()->PolicyBenefitObject->PolicyObject->Id, $PolicyId),\n            QQ::Equal(QQN::PolicyRolePlayer()->Active, 1),\n            QQ::Equal(QQN::PolicyRolePlayer()->RolePlayerType, \'Beneficiary\')\n        ),\n      QQ::Clause(\n        QQ::Select(\n            QQN::PolicyRolePlayer()->FirstName,\n            QQN::PolicyRolePlayer()->Surname,\n            QQN::PolicyRolePlayer()->PolicyBenefitObject->PolicyObject->Id\n        )\n      )\n    );\necho $BeneficiaryPolicyRolePlayerObj ->FirstName;\necho $BeneficiaryPolicyRolePlayerObj ->PolicyBenefitObject->PolicyObject->Id; // If null, then does not work\necho $BeneficiaryPolicyRolePlayerObj->PolicyBenefitObject->PolicyObject->Term; // If not null, then not optimal'),
(53, 'Reset One', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'update PolicyAnniversary set Status = \"Pending\" where Policy =  11668\');'),
(54, 'Generic Object Attribute Collection', NULL, NULL, NULL, 13, NULL, '$Entity = \'PolicySchedule\';\n$schedule = new stdClass();\n$schedule->Policy = \'(SELECT Id FROM Policy order by Id desc limit 1)\';\n$schedule->UniquePolicyNumber = \'Test\';\n$schedule->ExternalPolicyNumber = \'Test\';\n\ngenericInsert($Entity, $schedule);\n\nfunction genericInsert($Entity, $stdObject) {\n  $KvpArr = array();  \n  foreach (get_object_vars($stdObject) as $Key => $Value) {\n    if (!is_null($Value)) {\n      if (strpos($Value, \"SELECT\") !== false) {\n          $KvpArr[$Key] = $Value;\n      } else {\n          $KvpArr[$Key] = \'\"\'.$Value.\'\"\';\n      }\n    }\n  }\n  $Str = \'INSERT INTO \'.$Entity.\' (\'.implode(\',\',array_keys($KvpArr)).\') VALUES (\'.implode(\',\',array_values($KvpArr)).\');\';\n  $Entity::GetDatabase()->Query($Str);\n}'),
(55, 'get class', NULL, NULL, NULL, 13, NULL, '$PolicyObj = Policy::Load(1);\necho get_class($PolicyObj);'),
(56, 'Cross Modular Background Process Query Count', NULL, NULL, NULL, 3, NULL, 'echo AppSpecificFunctions::noExistingSimilarPendingOrRunningProcess(\'Policy\', \"ProcessBank\");'),
(57, 'Existing Process', NULL, NULL, NULL, 14, NULL, 'echo AppSpecificFunctions::noExistingSimilarPendingOrRunningProcess(\"ProcessBank\");'),
(58, 'Test', NULL, NULL, NULL, 15, NULL, 'echo 1 % 100 == 0;'),
(59, 'Reset Anniversaries', NULL, NULL, NULL, 12, NULL, 'Policy::GetDatabase()->Query(\'update PolicyAnniversary set Status = \"Pending\" where Id >  7825\');'),
(60, 'Database', NULL, NULL, NULL, 15, NULL, '$PolicydatabaseObj = Policy::GetDatabase();\necho $PolicydatabaseObj->Database;'),
(61, 'Policy Role Player UniqueIdentifier', NULL, NULL, NULL, 16, NULL, '$UniquePolicyNumber = \"DCA00253\";\n$PolicyDatabaseObj = Policy::GetDatabase();\n$PolicyDatabaseObj->Query(\'UPDATE \'.$PolicyDatabaseObj->Database.\'.PolicyRolePlayer AS RowToUpdate,(SELECT Id FROM \'.$PolicyDatabaseObj->Database.\'.PolicyRolePlayer ORDER BY Id DESC LIMIT 1) AS LatestRow SET RowToUpdate.UniqueIdentifier = CONCAT(\"\'.$UniquePolicyNumber.\'\",LPAD(LatestRow.Id, 10, \"0\")) WHERE RowToUpdate.Id = LatestRow.Id;\');'),
(62, NULL, NULL, NULL, NULL, 16, NULL, NULL),
(63, 'DFS Policy Creation', NULL, NULL, NULL, 9, NULL, '$SalesEventId = 80324;\nPolicy::GetDatabase()->MultiQuery(\'DELETE FROM Policy WHERE SalesEvent=\'.$SalesEventId.\';DELETE FROM PolicyBenefit WHERE SalesEvent=\'.$SalesEventId.\';\');\nDfsPolicyCreation::createPoliciesFromSalesEvent($SalesEventId);'),
(64, 'Create Policy from Sales Event Id', NULL, NULL, NULL, 17, NULL, '$SalesEventId = 80297;\n$ResultObj = json_decode(AppSpecificFunctions::CallsDevAPI(\'createPoliciesFromSalesEvent\', __POLICIES_URL__.\'/API/Object/Policy.php\', array(\"APIKEY\" => __POLICIES_API_KEY__, \"SalesEventId\" => $SalesEventId),\'\',\'\'));\necho $ResultObj->Message;\nif ($ResultObj && $ResultObj->Result == \'Success\') {\n  echo \'Yeah booi\';\n} else {\n  echo \'Ahh nooo\';\n}'),
(65, 'Delete Policy and Policy Benefit for SalesEvent', NULL, NULL, NULL, 17, NULL, '$SalesEventId = 80297;\nPolicy::GetDatabase()->MultiQuery(\'DELETE FROM Policy WHERE SalesEvent=\'.$SalesEventId.\';DELETE FROM PolicyBenefit WHERE SalesEvent=\'.$SalesEventId.\';\');'),
(66, 'Array Map to get KVP', NULL, NULL, NULL, 9, NULL, '$CustomCollectionItemArr = CollectionItem::QueryArray(QQ::All(), QQ::Clause(QQ::LimitInfo(100)));\n$KvpArr = Helper::getKvp(\'CustomCollectionItemArr\', \'UniqueReference\');\necho json_encode(array_keys($KvpArr));\necho is_array($Arr);\n'),
(67, '', NULL, NULL, NULL, 9, NULL, '$Arr = [(object)[\"Test\" => 1],(object)[\"Test\" => 2],(object)[\"Test\" => 3]];\n$KvpArr = Helper::getKvp($Arr, \"Test\");\necho json_encode(array_keys($KvpArr));\necho is_array($Arr);\necho count($Arr);'),
(68, 'Funny', NULL, NULL, NULL, 15, NULL, '$a=\"b\";\n$b=\"c\";\n$c=\"d\";\n$d=\"e\";\n$e=\"f\";\n\necho $a.\"-\";\necho $$a.\"-\";   //Same as $b\necho $$$a.\"-\";  //Same as $$b or $c\necho $$$$a.\"-\"; //Same as $$$b or $$c or $d\necho $$$$$a;    //Same as $$$$b or $$$c or $$d or $e'),
(69, 'Latest Dispute Files', NULL, NULL, NULL, 5, NULL, 'foreach (CollectionTextFile::QueryArray(QQ::Equal(QQN::CollectionTextFile()->FileType, \"Dispute Response\"), QQ::Clause(QQ::LimitInfo(5), QQ::OrderBy(QQN::CollectionTextFile()->Id, false))) as $Obj) {\n    echo $Obj->Id.\'\\n\';\n}'),
(70, 'Dispute', NULL, NULL, NULL, 5, NULL, 'echo CollectionTextFile::Load(20206)->Content;\nCollectionManager::executeCollectionQuery(\'UPDATE CollectionTextFile SET \nFileStatus = \"Pending\" WHERE Id IN (20206)\');'),
(71, 'Latest Unpaid Files', NULL, NULL, NULL, 4, NULL, 'foreach (CollectionTextFile::QueryArray(QQ::Equal(QQN::CollectionTextFile()->FileType, \"Unpaid Response\"), QQ::Clause(QQ::LimitInfo(5), QQ::OrderBy(QQN::CollectionTextFile()->Id, false))) as $Obj) {\n    echo $Obj->Id.\'\\n\';\n}'),
(72, 'Unpaid', NULL, NULL, NULL, 4, NULL, 'echo CollectionTextFile::Load(19926)->Content;\nCollectionManager::executeCollectionQuery(\'UPDATE CollectionTextFile SET FileStatus = \"Pending\" WHERE Id IN (19926)\');'),
(73, 'Non Debit Dates', NULL, NULL, NULL, 11, NULL, '$NonDebitDates = DatabaseHelper::getObjectArray(\'NonDebitDate\', array(\"NonDebitDate\"), \"NonDebitDate > \".QDateTime::Now()->format(\'Y/m/d\'), null, 10000, null, $ErrorInfo);\nforeach($NonDebitDates as $Obj) {\n   echo $Obj;\n}'),
(74, 'Response Items', NULL, NULL, NULL, 11, NULL, 'CollectionManager::getPendingCollectionResponseItems(1000, $CollectionMethodObj, $CollectionTextFileObj);\n//echo $CollectionTextFileObj->Id;\necho $CollectionTextFileObj->CollectionMethodObject->Id;'),
(75, '', NULL, NULL, NULL, 3, NULL, ''),
(76, 'Run Cease Script', NULL, NULL, NULL, 19, NULL, 'AppSpecificFunctions::executeBackgroundProcess(__DOCROOT__.__SUBDIRECTORY__.\'/App/Automation/BackgroundScript_PolicyAnniversaryCease.php\',array(\"CId\" => \"Scheduler60_\", \"SchedulerActionId\" => 53),-1);'),
(77, 'Reset Policies', NULL, NULL, NULL, 19, NULL, 'Policy::GetDatabase()->Query(\'update Policy set AnniversaryDate = \"2021-01-05\", Active = 1 where ProductId IN (16,30)\');'),
(78, 'Setup Policies', NULL, NULL, NULL, 20, NULL, 'Policy::GetDatabase()->Query(\'update Policy set DebitOrderDay = 05, Active = 1, ContractPaymentStatus = \"ACTIVE\", InceptionDate = NULL, FirstDebitDate = NULL where ProductId IN (16,30) LIMIT 100\');'),
(79, 'Delete Policy Notifications', NULL, NULL, NULL, 20, NULL, 'PolicyNotification::GetDatabase()->Query(\'delete from PolicyNotification where Communication = 626\');');

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
(1, 4, 20);

-- --------------------------------------------------------

--
-- Table structure for table `Posts`
--

CREATE TABLE `Posts` (
  `UserId` varchar(30) NOT NULL,
  `PostText` mediumtext DEFAULT NULL,
  `CommandText` mediumtext DEFAULT NULL,
  `CommandInt` int(11) DEFAULT NULL,
  `PostTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Posts`
--

INSERT INTO `Posts` (`UserId`, `PostText`, `CommandText`, `CommandInt`, `PostTimeStamp`) VALUES
('Wolfman', '\n2017-08-092017-09-242017-09-252017-12-162017-12-252017-12-262018-01-012018-03-212018-03-302018-04-022018-04-272018-05-012018-06-162018-08-092018-09-242018-12-162018-12-172018-12-252018-12-262019-01-012019-03-212019-04-192019-04-222019-04-272019-05-012019-06-162019-06-172019-08-092019-09-242019-12-162019-12-252019-12-262020-01-012019-05-082020-03-212020-04-132020-04-272020-05-012020-06-162020-08-092020-08-102020-09-242020-12-162020-12-252020-12-262021-01-012020-04-10', 'Non Debit Dates', 73, '2020-12-10 12:19:09'),
('Wolfman', '\n', 'Process Response Items', 15, '2020-12-10 13:51:11'),
('Wolfman', '\n20206', 'Response Items', 74, '2020-12-10 13:57:08'),
('Wolfman', '\n4', 'Response Items', 74, '2020-12-10 13:57:31'),
('Wolfman', '\n', 'Process Response Items', 15, '2020-12-10 14:02:16'),
('Wolfman', '\n', 'Process Response Items', 15, '2020-12-10 14:09:21'),
('Wolfman', '\n', 'Process Response Items', 15, '2020-12-10 14:12:47'),
('Wolfman', '\n', 'Process Response Items', 15, '2020-12-10 14:13:53'),
('Wolfman', '\nMySqli Error: Unknown column \'HealthMultiplier\' in \'field list\'', 'DFS Policy Creation', 63, '2020-12-14 07:00:01'),
('Wolfman', '\n', 'DFS Policy Creation', 63, '2020-12-14 07:04:09'),
('Wolfman', '\n', 'DFS Policy Creation', 63, '2020-12-14 07:17:10'),
('Wolfman', '\n', 'Delete Policy and Policy Benefit for SalesEvent', 65, '2020-12-14 07:18:57'),
('Wolfman', '\n', 'Delete Policy and Policy Benefit for SalesEvent', 65, '2020-12-14 07:19:28'),
('Wolfman', '\n', 'Delete Policy and Policy Benefit for SalesEvent', 65, '2020-12-14 07:20:42'),
('Wolfman', '\nDFS Policy creation encountered errorsAhh nooo', 'Create Policy from Sales Event Id', 64, '2020-12-14 07:21:01'),
('Wolfman', '\nDFS Policy creation encountered errorsAhh nooo', 'Create Policy from Sales Event Id', 64, '2020-12-14 07:26:28'),
('Wolfman', '\nDFS Policy creation encountered errorsAhh nooo', 'Create Policy from Sales Event Id', 64, '2020-12-14 07:28:50'),
('Wolfman', '\nDFS Policy creation encountered errorsAhh nooo', 'Create Policy from Sales Event Id', 64, '2020-12-14 07:29:31'),
('Wolfman', '\nPolicy created successfullyYeah booi', 'Create Policy from Sales Event Id', 64, '2020-12-14 07:30:50'),
('Wolfman', '\n', 'Reset Anniversaries', 59, '2020-12-14 13:15:17'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-14 13:15:23'),
('Wolfman', '\n', 'Reset Policies', 38, '2020-12-14 13:17:08'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-14 13:17:12'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-14 13:23:01'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-14 13:25:57'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-14 13:28:23'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-14 13:29:27'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-14 13:32:49'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-14 13:35:32'),
('Wolfman', '\n', 'Reset Policies', 38, '2020-12-15 06:55:34'),
('Wolfman', '\n', 'Reset Anniversaries', 59, '2020-12-15 06:56:40'),
('Wolfman', '\n', 'Process Policy Anniversary NEW', 41, '2020-12-15 06:58:39'),
('Wolfman', '\n{\"Id\":45,\"ProductDescription\":null,\"ProductDisplayedName\":null,\"BenefitOptionIntroductionText\":null,\"BenefitOptionConfirmationText\":null,\"CustomerInformationCaptureText\":null,\"RulesAcceptanceIntroductionText\":null,\"ProductSortIndex\":null,\"ProductInformationVersion\":null,\"CreatedDate\":null,\"PolicyPrefix\":null,\"PolicyCounter\":null,\"LastUpdated\":null,\"Product\":34,\"SearchMetaInfo\":null}', 'Debug Single', 44, '2020-12-17 13:27:33'),
('Wolfman', '\n20278 Submission\\n20277 Submission\\n20276 Submission\\n20275 Submission\\n20273 Submission\\n20270 Submission\\n20269 Submission\\n20265 Submission\\n20260 Submission\\n20255 Submission\\n', 'Get Latest', 10, '2020-12-17 13:28:06'),
('Wolfman', '\nInterim Audit File', 'Get Specific Attributes', 11, '2020-12-17 13:28:24'),
('Wolfman', '\n', 'DFS Policy Creation', 63, '2020-12-17 13:30:15'),
('Wolfman', '\n', 'DFS Policy Creation', 63, '2020-12-17 13:30:22'),
('Wolfman', '\n', 'Reset Policies', 77, '2021-01-04 07:40:51'),
('Wolfman', '\n', 'Run Cease Script', 76, '2021-01-04 07:42:39'),
('Wolfman', '\n', 'Run Cease Script', 76, '2021-01-04 07:56:16'),
('Wolfman', '\n', 'Run Cease Script', 76, '2021-01-04 08:04:04'),
('Wolfman', '\n', 'Run Cease Script', 76, '2021-01-04 08:07:20'),
('Wolfman', '\n', 'Run Cease Script', 76, '2021-01-04 08:08:54'),
('Wolfman', '\n', 'Run Cease Script', 76, '2021-01-04 08:09:39'),
('Wolfman', '\n', 'Run Cease Script', 76, '2021-01-04 08:11:28'),
('Wolfman', '\n', 'Run Cease Script', 76, '2021-01-04 08:22:41'),
('Wolfman', '\n', 'Setup Policies', 78, '2021-01-04 09:39:42'),
('Wolfman', '\n', 'Setup Policies', 78, '2021-01-04 09:51:02'),
('Wolfman', '\n', 'Delete Policy Notifications', 79, '2021-01-04 09:55:01'),
('Wolfman', '\n', 'Setup Policies', 78, '2021-01-04 09:55:13'),
('Wolfman', '\n', 'Reset Policies', 38, '2021-01-05 08:09:11'),
('Wolfman', '\n', 'Purge By Min Id', 39, '2021-01-05 08:09:22'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 08:09:32'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 08:14:26'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 08:16:02'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 08:16:34'),
('Wolfman', '\n', 'Reset Policies', 38, '2021-01-05 08:16:46'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 08:16:50'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 08:27:14'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 08:29:39'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 09:21:14'),
('Wolfman', '\n', 'Pre Policy Anniversary Calculations', 40, '2021-01-05 09:45:23');

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

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `Name` varchar(30) NOT NULL,
  `Surname` varchar(30) NOT NULL,
  `EmailAddress` varchar(50) NOT NULL,
  `Username` varchar(30) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `ProfilePicture` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`Name`, `Surname`, `EmailAddress`, `Username`, `Password`, `ProfilePicture`) VALUES
('Brett', 'Coetzee', 'brett.coetzee@stratusolve.com', 'Wolfman', '$2y$10$RbPnhVInrtBlRfq.fDypLONSLUCJ00PeXK.jrB7b6cGiK1B5A0jgK', 'images/Chirp.png');

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
-- Indexes for table `Posts`
--
ALTER TABLE `Posts`
  ADD PRIMARY KEY (`PostTimeStamp`);

--
-- Indexes for table `Report`
--
ALTER TABLE `Report`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`Username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Automation`
--
ALTER TABLE `Automation`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Batch`
--
ALTER TABLE `Batch`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `Command`
--
ALTER TABLE `Command`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

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
