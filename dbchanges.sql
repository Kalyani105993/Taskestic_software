CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project_info_view` AS
    SELECT 
        `project`.`project_id` AS `project_id`,
        `project`.`company_id` AS `company_id`,
        `project`.`customer_id` AS `customer_id`,
        `project`.`project_name` AS `project_name`,
        `project`.`project_description` AS `project_description`,
        `project`.`project_group_id` AS `project_group_id`,
        `project`.`project_sub_group_id` AS `project_sub_group_id`,
        `project`.`project_inp_number` AS `project_inp_number`,
        `project`.`project_start_date` AS `project_start_date`,
        `project`.`project_end_date` AS `project_end_date`,
        `project`.`project_status_id` AS `project_status_id`,
        `project`.`is_active` AS `is_active`,
        `project`.`is_deleted` AS `is_deleted`,
        `project`.`customer_order_date` AS `customer_order_date`,
        `project`.`customer_order_no` AS `customer_order_no`,
        `customer`.`customer_name` AS `customer_name`,
        `customer`.`is_active` AS `customer_active`,
        `customer`.`is_deleted` AS `customer_deleted`,
        `groups`.`project_group` AS `project_group`,
        `subgroup`.`project_sub_group` AS `project_sub_group`,
        `pstatus`.`project_status` AS `project_status`
    FROM
        ((((`pms_projects` `project`
        LEFT JOIN `pms_mst_project_groups` `groups` ON ((`project`.`project_group_id` = `groups`.`project_group_id`)))
        LEFT JOIN `pms_mst_project_sub_groups` `subgroup` ON ((`project`.`project_sub_group_id` = `subgroup`.`project_sub_group_id`)))
        LEFT JOIN `pms_customers` `customer` ON ((`project`.`customer_id` = `customer`.`customer_id`)))
        LEFT JOIN `pms_mst_project_status` `pstatus` ON ((`project`.`project_status_id` = `pstatus`.`project_status_id`)))
        
        
        
        
--        changes in Table project_info_view      --- by rahul choudhary
        
        CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project_info_view` AS
    SELECT 
        `project`.`project_id` AS `project_id`,
        `project`.`company_id` AS `company_id`,
        `project`.`customer_id` AS `customer_id`,
        `project`.`project_name` AS `project_name`,
        `project`.`project_description` AS `project_description`,
        `project`.`project_group_id` AS `project_group_id`,
        `project`.`project_sub_group_id` AS `project_sub_group_id`,
        `project`.`project_inp_number` AS `project_inp_number`,
        `project`.`project_start_date` AS `project_start_date`,
        `project`.`project_end_date` AS `project_end_date`,
        `project`.`project_status_id` AS `project_status_id`,
        `project`.`is_active` AS `is_active`,
        `project`.`is_deleted` AS `is_deleted`,
        `project`.`customer_order_date` AS `customer_order_date`,
        `project`.`customer_order_no` AS `customer_order_no`,
        `customer`.`customer_name` AS `customer_name`,
        `customer`.`is_active` AS `customer_active`,
        `customer`.`is_deleted` AS `customer_deleted`,
        `groups`.`project_group` AS `project_group`,
        `subgroup`.`project_sub_group` AS `project_sub_group`,
        `pstatus`.`project_status` AS `project_status`,
        `project`.`project_code` AS `project_code`,
        `project`.`project_type_id` AS `project_type_id`,
        `type`.`project_type` AS `project_type`
    FROM
        (((((`pms_projects` `project`
        LEFT JOIN `pms_mst_project_groups` `groups` ON ((`project`.`project_group_id` = `groups`.`project_group_id`)))
        LEFT JOIN `pms_mst_project_sub_groups` `subgroup` ON ((`project`.`project_sub_group_id` = `subgroup`.`project_sub_group_id`)))
        LEFT JOIN `pms_customers` `customer` ON ((`project`.`customer_id` = `customer`.`customer_id`)))
        LEFT JOIN `pms_mst_project_status` `pstatus` ON ((`project`.`project_status_id` = `pstatus`.`project_status_id`)))
        LEFT JOIN `pms_mst_project_type` `type` ON ((`project`.`project_type_id` = `type`.`project_type_id`)))
        
        
        
  --  created new Table pms_mst_project_type     --- by rahul choudhary
        
        CREATE TABLE `pms_mst_project_type` (
  `project_type_id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `project_type` varchar(100) NOT NULL,
  `is_deleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`project_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci



-- changes in Table pms_projects, added new fields 1)project_code 2)project_type_id    --- by rahul choudhary

CREATE TABLE `pms_projects` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `project_name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_description` text CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci,
  `project_group_id` int DEFAULT NULL,
  `project_sub_group_id` int DEFAULT NULL,
  `project_inp_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_start_date` date DEFAULT NULL,
  `project_end_date` date DEFAULT NULL,
  `project_status_id` int DEFAULT NULL,
  `is_active` int DEFAULT '1',
  `is_deleted` int DEFAULT '0',
  `customer_order_date` date DEFAULT NULL,
  `customer_order_no` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL,
  `project_code` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `project_type_id` int DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `ind_company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci




 ---- 22/05/23 changes in employees table to add columns  changes by yogesh -----

ALTER TABLE `pmsdakshabhi`.`pms_empoyees` 
ADD COLUMN `employee_type` VARCHAR(255) NOT NULL AFTER `is_deleted`,
ADD COLUMN `aadhar_card_no` VARCHAR(15) NOT NULL AFTER `employee_type`,
ADD COLUMN `passport_no` VARCHAR(10) NULL DEFAULT NULL AFTER `aadhar_card_no`,
ADD COLUMN `pan_no` VARCHAR(10) NULL DEFAULT NULL AFTER `passport_no`,
ADD COLUMN `current_address` VARCHAR(1000) NULL AFTER `pan_no`,
ADD COLUMN `permanant_address` VARCHAR(1000) NULL DEFAULT NULL AFTER `current_address`,
ADD COLUMN `date_of_birth` DATETIME NULL DEFAULT NULL AFTER `permanant_address`,
ADD COLUMN `gender` VARCHAR(10) NOT NULL DEFAULT 'Male' AFTER `date_of_birth`,
ADD COLUMN `employee_status` VARCHAR(100) NOT NULL AFTER `gender`,
ADD COLUMN `date_joining` DATETIME NOT NULL AFTER `employee_status`,
ADD COLUMN `created_by` VARCHAR(255) NULL DEFAULT NULL AFTER `date_joining`,
ADD COLUMN `created_on` DATETIME NULL DEFAULT NULL AFTER `created_by`,
ADD COLUMN `modified_by` VARCHAR(255) NULL DEFAULT NULL AFTER `created_on`,
ADD COLUMN `modified_on` DATETIME NULL DEFAULT NULL AFTER `modified_by`,
ADD COLUMN `deleted_by` VARCHAR(255) NULL DEFAULT NULL AFTER `modified_on`,
ADD COLUMN `deleted_on` DATETIME NULL AFTER `deleted_by`;


ALTER TABLE `pmsdakshabhi`.`pms_empoyees` 
CHANGE COLUMN `date_of_birth` `date_of_birth` DATE NULL DEFAULT NULL ,
CHANGE COLUMN `date_joining` `date_joining` DATE NOT NULL ;


ALTER TABLE  `pmsdakshabhi`.`pms_empoyees`
DROP COLUMN employee_type;
ALTER TABLE  `pmsdakshabhi`.`pms_empoyees`
DROP COLUMN employee_status;

ALTER TABLE  `pmsdakshabhi`.`pms_empoyees`
ADD COLUMN `employee_type` INT NOT NULL AFTER `is_deleted`,
ADD COLUMN `employee_status` INT NOT NULL AFTER `gender`;



 ----  create and changes master employee_type 

CREATE TABLE `pmsdakshabhi`.`pms_mst_employee_type` (
  `employee_type_id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `employee_type_name` VARCHAR(100) NULL,
  PRIMARY KEY (`employee_type_id`));


INSERT INTO `pmsdakshabhi`.`pms_mst_employee_type` (`employee_type_id`, `company_id`, `employee_type_name`) VALUES ('1', '1', 'Part-time');
INSERT INTO `pmsdakshabhi`.`pms_mst_employee_type` (`company_id`, `employee_type_name`) VALUES ('1', 'Full-time');

UPDATE `pmsdakshabhi`.`pms_mst_employee_type` SET `employee_type_name` = 'Worker' WHERE (`employee_type_id` = '1');
UPDATE `pmsdakshabhi`.`pms_mst_employee_type` SET `employee_type_name` = 'Management' WHERE (`employee_type_id` = '2');


UPDATE `pmsdakshabhi`.`pms_mst_employee_type` SET `employee_type_name` = 'Interns' WHERE (`employee_type_id` = '1');
UPDATE `pmsdakshabhi`.`pms_mst_employee_type` SET `employee_type_name` = 'Consultants' WHERE (`employee_type_id` = '2');
INSERT INTO `pmsdakshabhi`.`pms_mst_employee_type` (`employee_type_id`, `company_id`, `employee_type_name`) VALUES ('3', '1', 'Developer');



 ---- created new table for master Employee_Status 23-05-2023

CREATE TABLE `pmsdakshabhi`.`pms_mst_employee_status` (
  `employee_status_id` INT NOT NULL AUTO_INCREMENT,
  `company_id` INT NOT NULL,
  `employee_status_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`employee_status_id`));
  
 INSERT INTO `pmsdakshabhi`.`pms_mst_employee_status` (`employee_status_id`, `company_id`, `employee_status_name`) VALUES ('1', '1', 'Left');
INSERT INTO `pmsdakshabhi`.`pms_mst_employee_status` (`employee_status_id`, `company_id`, `employee_status_name`) VALUES ('2', '1', 'Hold');
INSERT INTO `pmsdakshabhi`.`pms_mst_employee_status` (`employee_status_id`, `company_id`, `employee_status_name`) VALUES ('3', '1', 'New');
INSERT INTO `pmsdakshabhi`.`pms_mst_employee_status` (`employee_status_id`, `company_id`, `employee_status_name`) VALUES ('4', '1', 'Terminated');



----------------------Alter Employee Info view --------------------

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `employee_info_view` AS
    SELECT 
        `emp`.`employee_id` AS `employee_id`,
        `emp`.`company_id` AS `company_id`,
        `emp`.`employee_code` AS `employee_code`,
        `emp`.`employee_name` AS `employee_name`,
        `emp`.`department_id` AS `department_id`,
        `emp`.`remporting_to` AS `remporting_to`,
        `emp`.`employee_role` AS `employee_role`,
        `emp`.`employee_email` AS `employee_email`,
        `emp`.`employee_phone` AS `employee_phone`,
        `emp`.`employee_password` AS `employee_password`,
        `emp`.`is_active` AS `is_active`,
        `emp`.`is_deleted` AS `is_deleted`,
        `emp`.`employee_type` AS `employee_type`,
        `emp`.`aadhar_card_no` AS `aadhar_card_no`,
        `emp`.`passport_no` AS `passport_no`,
        `emp`.`pan_no` AS `pan_no`,
        `emp`.`current_address` AS `current_address`,
        `emp`.`permanant_address` AS `permanant_address`,
        `emp`.`date_of_birth` AS `date_of_birth`,
        `emp`.`gender` AS `gender`,
        `emp`.`employee_status` AS `employee_status`,
        `emp`.`date_joining` AS `date_joining`,
        `emp`.`created_by` AS `created_by`,
        `emp`.`created_on` AS `created_on`,
        `emp`.`modified_by` AS `modified_by`,
        `emp`.`modified_on` AS `modified_on`,
        `emp`.`deleted_by` AS `deleted_by`,
        `emp`.`deleted_on` AS `deleted_on`,
        `mstdep`.`department_name` AS `department_name`,
        `rmprole`.`employe_role_name` AS `employee_role_name`,
        `empreporting`.`employee_name` AS `reporting_to_name`,
        `mstemptype`.`employee_type_name` AS `employee_type_name`,
        `mstempstatus`.`employee_status_name` AS `employee_status_name`
    FROM
        (((((`pms_empoyees` `emp`
        LEFT JOIN `pms_mst_employee_status` `mstempstatus` ON ((`emp`.`employee_status` = `mstempstatus`.`employee_status_id`)))
        LEFT JOIN `pms_mst_employee_type` `mstemptype` ON ((`emp`.`employee_type` = `mstemptype`.`employee_type_id`)))
        LEFT JOIN `pms_mst_department` `mstdep` ON ((`emp`.`department_id` = `mstdep`.`department_id`)))
        LEFT JOIN `pms_mst_employee_role` `rmprole` ON ((`emp`.`employee_role` = `rmprole`.`employee_role_id`)))
        LEFT JOIN `pms_empoyees` `empreporting` ON ((`emp`.`remporting_to` = `empreporting`.`employee_id`)))
        
// By Deepak on 24 05
CREATE TABLE `pms_project_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `task_name` varchar(255) DEFAULT NULL,
  `task_description` text,
  `task_status_id` int(3) DEFAULT NULL,
  `task_type_id` int(3) DEFAULT NULL,
  `task_priority_id` int(3) DEFAULT NULL,
  `assignee_employee_id` int(11) DEFAULT NULL,
  `task_start_date` date DEFAULT NULL,
  `task_due_date` date DEFAULT NULL,
  `task_estimated_time` int(11) DEFAULT NULL,
  `task_completion_value` double DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  `created_by` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_on` datetime DEFAULT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


CREATE TABLE `pms_mst_task_priority` (
  `task_priority_id` int(2) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `task_priority` varchar(200) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`task_priority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
INSERT INTO `pms_mst_task_priority` VALUES (1,1,'Low',0),(2,1,'Normal',0),(3,1,'High',0),(4,1,'Urgent',0),(5,1,'Blocking',0),(6,1,'immediate',0);

CREATE TABLE `pms_mst_task_status` (
  `task_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `task_status` varchar(200) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`task_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
INSERT INTO `pms_mst_task_status` VALUES (1,1,'New',0),(2,1,'In Progress',0),(3,1,'Resolved',0),(4,1,'Closed',0),(5,1,'Completed',0),(6,1,'Re-Open',0),(7,1,'Feedback',0);

CREATE TABLE `pms_mst_task_type` (
  `task_type_id` int(3) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `task_type` varchar(200) DEFAULT NULL,
  `is_deleted` int(1) DEFAULT '0',
  PRIMARY KEY (`task_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
INSERT INTO `pms_mst_task_type` VALUES (1,1,'Feature',0),(2,1,'Development',0),(3,1,'Bug',0),(4,1,'Re-work',0),(5,1,'Testing',0);
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pms_project_task_info_view` AS select `project_task`.`task_id` AS `task_id`,`project_task`.`company_id` AS `company_id`,`project_task`.`project_id` AS `project_id`,`project_task`.`task_name` AS `task_name`,`project_task`.`task_description` AS `task_description`,`project_task`.`task_status_id` AS `task_status_id`,`project_task`.`task_type_id` AS `task_type_id`,`project_task`.`task_priority_id` AS `task_priority_id`,`project_task`.`assignee_employee_id` AS `assignee_employee_id`,`project_task`.`task_start_date` AS `task_start_date`,`project_task`.`task_due_date` AS `task_due_date`,`project_task`.`task_estimated_time` AS `task_estimated_time`,`project_task`.`task_completion_value` AS `task_completion_value`,`project_task`.`is_deleted` AS `is_deleted`,`project_task`.`created_by` AS `created_by`,`project_task`.`created_on` AS `created_on`,`project_task`.`modified_by` AS `modified_by`,`project_task`.`modified_on` AS `modified_on`,`project_task`.`deleted_by` AS `deleted_by`,`project_task`.`deleted_on` AS `deleted_on`,`task_type`.`task_type` AS `task_type`,`task_status`.`task_status` AS `task_status`,`task_priority`.`task_priority` AS `task_priority`,`employee`.`employee_name` AS `employee_name` from ((((`pms_project_task` `project_task` left join `pms_mst_task_type` `task_type` on((`project_task`.`task_type_id` = `task_type`.`task_type_id`))) left join `pms_mst_task_status` `task_status` on((`project_task`.`task_status_id` = `task_status`.`task_status_id`))) left join `pms_mst_task_priority` `task_priority` on((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`))) left join `pms_empoyees` `employee` on((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)));
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project_employee_info_view` AS select `projemp`.`project_employee_id` AS `project_employee_id`,`projemp`.`company_id` AS `company_id`,`projemp`.`project_id` AS `project_id`,`projemp`.`employee_id` AS `employee_id`,`projemp`.`date_added` AS `date_added`,`projemp`.`is_deleted` AS `is_deleted`,`projects`.`project_name` AS `project_name`,`employees`.`employee_name` AS `employee_name`,`department`.`department_name` AS `department_name`,`employeerole`.`employe_role_name` AS `employe_role_name` from ((((`pms_project_employee` `projemp` left join `pms_projects` `projects` on((`projemp`.`project_id` = `projects`.`project_id`))) left join `pms_empoyees` `employees` on((`projemp`.`employee_id` = `employees`.`employee_id`))) left join `pms_mst_department` `department` on((`employees`.`department_id` = `department`.`department_id`))) left join `pms_mst_employee_role` `employeerole` on((`employees`.`employee_role` = `employeerole`.`employee_role_id`)));
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project_info_view` AS select `project`.`project_id` AS `project_id`,`project`.`company_id` AS `company_id`,`project`.`customer_id` AS `customer_id`,`project`.`project_name` AS `project_name`,`project`.`project_description` AS `project_description`,`project`.`project_group_id` AS `project_group_id`,`project`.`project_sub_group_id` AS `project_sub_group_id`,`project`.`project_inp_number` AS `project_inp_number`,`project`.`project_start_date` AS `project_start_date`,`project`.`project_end_date` AS `project_end_date`,`project`.`project_status_id` AS `project_status_id`,`project`.`is_active` AS `is_active`,`project`.`is_deleted` AS `is_deleted`,`project`.`customer_order_date` AS `customer_order_date`,`project`.`customer_order_no` AS `customer_order_no`,`customer`.`customer_name` AS `customer_name`,`customer`.`is_active` AS `customer_active`,`customer`.`is_deleted` AS `customer_deleted`,`groups`.`project_group` AS `project_group`,`subgroup`.`project_sub_group` AS `project_sub_group`,`pstatus`.`project_status` AS `project_status`,`project`.`project_code` AS `project_code`,`project`.`project_type_id` AS `project_type_id`,`type`.`project_type` AS `project_type` from (((((`pms_projects` `project` left join `pms_mst_project_groups` `groups` on((`project`.`project_group_id` = `groups`.`project_group_id`))) left join `pms_mst_project_sub_groups` `subgroup` on((`project`.`project_sub_group_id` = `subgroup`.`project_sub_group_id`))) left join `pms_customers` `customer` on((`project`.`customer_id` = `customer`.`customer_id`))) left join `pms_mst_project_status` `pstatus` on((`project`.`project_status_id` = `pstatus`.`project_status_id`))) left join `pms_mst_project_type` `type` on((`project`.`project_type_id` = `type`.`project_type_id`)));

------By Deepak on 25-05-23----------
CREATE TABLE `pmsdakshabhi`.`pms_mst_task_activity` (
  `task_activity_id` INT(3) NOT NULL AUTO_INCREMENT,
  `company_id` INT(11) NULL,
  `task_activity` VARCHAR(100) NULL,
  `is_deleted` INT(1) NULL DEFAULT '0',
  PRIMARY KEY (`task_activity_id`));
INSERT INTO `pms_mst_task_activity` VALUES (1,1,'Design',0),(2,1,'Development',0),(3,1,'Testing',0),(4,1,'SEO',0);
  
CREATE TABLE `pms_task_log` (
  `task_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `log_date` date DEFAULT NULL,
  `log_hours` int(3) DEFAULT NULL,
  `task_activity_id` int(3) DEFAULT NULL,
  `taskComments` text,
  `is_deleted` int(1) DEFAULT '0',
  `created_by` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_on` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_on` datetime DEFAULT NULL,
  PRIMARY KEY (`task_log_id`),
  KEY `ind_task_id` (`task_id`),
  KEY `ind_log_date` (`log_date`),
  KEY `ind_is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_project_task_info_view` AS
    SELECT 
        `project_task`.`task_id` AS `task_id`,
        `project_task`.`company_id` AS `company_id`,
        `project_task`.`project_id` AS `project_id`,
        `project_task`.`task_name` AS `task_name`,
        `project_task`.`task_description` AS `task_description`,
        `project_task`.`task_status_id` AS `task_status_id`,
        `project_task`.`task_type_id` AS `task_type_id`,
        `project_task`.`task_priority_id` AS `task_priority_id`,
        `project_task`.`assignee_employee_id` AS `assignee_employee_id`,
        `project_task`.`task_start_date` AS `task_start_date`,
        `project_task`.`task_due_date` AS `task_due_date`,
        `project_task`.`task_estimated_time` AS `task_estimated_time`,
        `project_task`.`task_completion_value` AS `task_completion_value`,
        `project_task`.`is_deleted` AS `is_deleted`,
        `project_task`.`created_by` AS `created_by`,
        `project_task`.`created_on` AS `created_on`,
        `project_task`.`modified_by` AS `modified_by`,
        `project_task`.`modified_on` AS `modified_on`,
        `project_task`.`deleted_by` AS `deleted_by`,
        `project_task`.`deleted_on` AS `deleted_on`,
        `task_type`.`task_type` AS `task_type`,
        `task_status`.`task_status` AS `task_status`,
        `task_priority`.`task_priority` AS `task_priority`,
        `employee`.`employee_name` AS `employee_name`,
        `project`.`project_name` AS `project_name`,
        `project`.`is_deleted` AS `project_is_deleted`
    FROM
        (((((`pms_project_task` `project_task`
        LEFT JOIN `pms_mst_task_type` `task_type` ON ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
        LEFT JOIN `pms_mst_task_status` `task_status` ON ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
        LEFT JOIN `pms_mst_task_priority` `task_priority` ON ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
        LEFT JOIN `pms_empoyees` `employee` ON ((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)))
        LEFT JOIN `pms_projects` `project` ON ((`project_task`.`project_id` = `project`.`project_id`)))
        
------- Added By Deepak on 25 May 23 ------------------------
CREATE TABLE `pmsdakshabhi`.`pms_task_messages` (
  `task_message_id` INT(11) UNSIGNED NOT NULL,
  `task_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `message` TEXT NULL,
  `parent_message_id` INT(11) NOT NULL DEFAULT '0',
  `added_on` DATETIME NULL,
  `is_deleted` INT(1) NULL DEFAULT '0',
  `deleted_on` DATETIME NULL,
  `deleted_by` INT(11) NULL,
  PRIMARY KEY (`task_message_id`),
  INDEX `ind_taskid` (`task_id` ASC),
  INDEX `ind_employeeid` (`employee_id` ASC),
  INDEX `ind_addedon` (`added_on` ASC),
  INDEX `ind_isdeleted` (`is_deleted` ASC));
  
  
  CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `task_message_info_view` AS
    SELECT 
        `task_msg`.`task_message_id` AS `task_message_id`,
        `task_msg`.`task_id` AS `task_id`,
        `task_msg`.`employee_id` AS `employee_id`,
        `task_msg`.`message` AS `message`,
        `task_msg`.`parent_message_id` AS `parent_message_id`,
        `task_msg`.`added_on` AS `added_on`,
        `task_msg`.`is_deleted` AS `is_deleted`,
        `task_msg`.`deleted_on` AS `deleted_on`,
        `task_msg`.`deleted_by` AS `deleted_by`,
        `employee`.`employee_name` AS `employee_name`
    FROM
        (`pms_task_messages` `task_msg`
        LEFT JOIN `pms_empoyees` `employee` ON ((`task_msg`.`employee_id` = `employee`.`employee_id`)))

        
---- By Yogesh on 25 MAy 23 -----
        ALTER TABLE `pmsdakshabhi`.`pms_project_task` 
ADD COLUMN `followers` varchar(255) NULL after is_deleted;


USE `pmsdakshabhi`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_project_task_info_view` AS
    SELECT 
        `project_task`.`task_id` AS `task_id`,
        `project_task`.`company_id` AS `company_id`,
        `project_task`.`project_id` AS `project_id`,
        `project_task`.`task_name` AS `task_name`,
        `project_task`.`task_description` AS `task_description`,
        `project_task`.`task_status_id` AS `task_status_id`,
        `project_task`.`task_type_id` AS `task_type_id`,
        `project_task`.`task_priority_id` AS `task_priority_id`,
        `project_task`.`assignee_employee_id` AS `assignee_employee_id`,
        `project_task`.`task_start_date` AS `task_start_date`,
        `project_task`.`task_due_date` AS `task_due_date`,
        `project_task`.`task_estimated_time` AS `task_estimated_time`,
        `project_task`.`task_completion_value` AS `task_completion_value`,
        `project_task`.`is_deleted` AS `is_deleted`,
         `project_task`.`followers` AS `followers`,
        `project_task`.`created_by` AS `created_by`,
        `project_task`.`created_on` AS `created_on`,
        `project_task`.`modified_by` AS `modified_by`,
        `project_task`.`modified_on` AS `modified_on`,
        `project_task`.`deleted_by` AS `deleted_by`,
        `project_task`.`deleted_on` AS `deleted_on`,
        `task_type`.`task_type` AS `task_type`,
        `task_status`.`task_status` AS `task_status`,
        `task_priority`.`task_priority` AS `task_priority`,
        `employee`.`employee_name` AS `employee_name`,
        `project`.`project_name` AS `project_name`,
        `project`.`is_deleted` AS `project_is_deleted`
    FROM
        (((((`pms_project_task` `project_task`
        LEFT JOIN `pms_mst_task_type` `task_type` ON ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
        LEFT JOIN `pms_mst_task_status` `task_status` ON ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
        LEFT JOIN `pms_mst_task_priority` `task_priority` ON ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
        LEFT JOIN `pms_empoyees` `employee` ON ((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)))
        LEFT JOIN `pms_projects` `project` ON ((`project_task`.`project_id` = `project`.`project_id`)));
        
 ALTER TABLE `pmsdakshabhi`.`pms_task_messages` 
CHANGE COLUMN `task_message_id` `task_message_id` INT UNSIGNED NOT NULL AUTO_INCREMENT ;



----- 26-05-2023 by yogesh --------


CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_task_log_info_view` AS
    SELECT 
        `task_log`.`task_log_id` AS `task_log_id`,
        `task_log`.`task_id` AS `task_id`,
        `project_task`.`task_name` AS `task_name`,
        `task_log`.`log_date` AS `log_date`,
        `task_log`.`log_hours` AS `log_hours`,
        `task_log`.`task_activity_id` AS `task_activity_id`,
        `task_activity`.`task_activity` AS `task_activity_name`,
        `task_log`.`taskComments` AS `taskComments`,
        `task_log`.`is_deleted` AS `task_log_is_deleted`,
        `task_log`.`created_by` AS `task_log_created_by`,
        `employee1`.`employee_name` AS `createdBy_employee_name`,
        `employee2`.`employee_name` AS `modifiedBy_employee_name`,
        `task_log`.`created_on` AS `task_log_created_on`,
        `task_log`.`modified_by` AS `task_log_modified_by`,
        `task_log`.`modified_on` AS `task_log_modified_on`,
        `task_log`.`deleted_by` AS `task_log_deleted_by`,
        `employee3`.`employee_name` AS `deletedBy_employee_name`,
        `task_log`.`deleted_on` AS `task_log_deleted_on`
    FROM
        (((((`pms_task_log` `task_log`
        LEFT JOIN `pms_project_task` `project_task` ON ((`task_log`.`task_id` = `project_task`.`task_id`)))
        LEFT JOIN `pms_mst_task_activity` `task_activity` ON ((`task_log`.`task_activity_id` = `task_activity`.`task_activity_id`)))
        LEFT JOIN `pms_empoyees` `employee1` ON ((`task_log`.`created_by` = `employee1`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee2` ON ((`task_log`.`modified_by` = `employee2`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee3` ON ((`task_log`.`deleted_by` = `employee3`.`employee_id`)))
        
        
        
        
        --- changes in pms_empoyees table ---by  rahul choudhary  -- 26-05-2023
ALTER TABLE pmsdakshabhi.pms_empoyees
ADD profile_photo varchar(100)DEFAULT 'default.jpg';



-- changes in employee_info_view  ---by  rahul choudhary  -- 26-05-2023

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `employee_info_view` AS
    SELECT 
        `emp`.`employee_id` AS `employee_id`,
        `emp`.`company_id` AS `company_id`,
        `emp`.`employee_code` AS `employee_code`,
        `emp`.`employee_name` AS `employee_name`,
        `emp`.`department_id` AS `department_id`,
        `emp`.`remporting_to` AS `remporting_to`,
        `emp`.`employee_role` AS `employee_role`,
        `emp`.`employee_email` AS `employee_email`,
        `emp`.`employee_phone` AS `employee_phone`,
        `emp`.`employee_password` AS `employee_password`,
        `emp`.`is_active` AS `is_active`,
        `emp`.`is_deleted` AS `is_deleted`,
        `emp`.`employee_type` AS `employee_type`,
        `emp`.`aadhar_card_no` AS `aadhar_card_no`,
        `emp`.`passport_no` AS `passport_no`,
        `emp`.`pan_no` AS `pan_no`,
        `emp`.`current_address` AS `current_address`,
        `emp`.`permanant_address` AS `permanant_address`,
        `emp`.`date_of_birth` AS `date_of_birth`,
        `emp`.`gender` AS `gender`,
        `emp`.`employee_status` AS `employee_status`,
        `emp`.`date_joining` AS `date_joining`,
        `emp`.`created_by` AS `created_by`,
        `emp`.`created_on` AS `created_on`,
        `emp`.`modified_by` AS `modified_by`,
        `emp`.`modified_on` AS `modified_on`,
        `emp`.`deleted_by` AS `deleted_by`,
        `emp`.`deleted_on` AS `deleted_on`,
        `mstdep`.`department_name` AS `department_name`,
        `rmprole`.`employe_role_name` AS `employee_role_name`,
        `empreporting`.`employee_name` AS `reporting_to_name`,
        `mstemptype`.`employee_type_name` AS `employee_type_name`,
        `mstempstatus`.`employee_status_name` AS `employee_status_name`,
        `emp`.`profile_photo` AS `profile_photo`
    FROM
        ((((((`pms_empoyees` `emp`
        LEFT JOIN `pms_mst_employee_status` `mstempstatus` ON ((`emp`.`employee_status` = `mstempstatus`.`employee_status_id`)))
        LEFT JOIN `pms_mst_employee_type` `mstemptype` ON ((`emp`.`employee_type` = `mstemptype`.`employee_type_id`)))
        LEFT JOIN `pms_mst_department` `mstdep` ON ((`emp`.`department_id` = `mstdep`.`department_id`)))
        LEFT JOIN `pms_mst_employee_role` `rmprole` ON ((`emp`.`employee_role` = `rmprole`.`employee_role_id`)))
        LEFT JOIN `pms_empoyees` `empreporting` ON ((`emp`.`remporting_to` = `empreporting`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `profile_photo` ON ((`emp`.`profile_photo` = `profile_photo`.`employee_id`)))
        
        
 ------ By Deepak on 30 May ----       
        
 USE `pmsdakshabhi`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `employee_info_view` AS
    SELECT 
        `emp`.`employee_id` AS `employee_id`,
        `emp`.`company_id` AS `company_id`,
        `emp`.`employee_code` AS `employee_code`,
        `emp`.`employee_name` AS `employee_name`,
        `emp`.`department_id` AS `department_id`,
        `emp`.`remporting_to` AS `remporting_to`,
        `emp`.`employee_role` AS `employee_role`,
        `emp`.`employee_email` AS `employee_email`,
        `emp`.`employee_phone` AS `employee_phone`,
        `emp`.`employee_password` AS `employee_password`,
        `emp`.`is_active` AS `is_active`,
        `emp`.`is_deleted` AS `is_deleted`,
        `emp`.`employee_type` AS `employee_type`,
        `emp`.`aadhar_card_no` AS `aadhar_card_no`,
        `emp`.`passport_no` AS `passport_no`,
        `emp`.`pan_no` AS `pan_no`,
        `emp`.`current_address` AS `current_address`,
        `emp`.`permanant_address` AS `permanant_address`,
        `emp`.`date_of_birth` AS `date_of_birth`,
        `emp`.`gender` AS `gender`,
        `emp`.`employee_status` AS `employee_status`,
        `emp`.`date_joining` AS `date_joining`,
        `emp`.`created_by` AS `created_by`,
        `emp`.`created_on` AS `created_on`,
        `emp`.`modified_by` AS `modified_by`,
        `emp`.`modified_on` AS `modified_on`,
        `emp`.`deleted_by` AS `deleted_by`,
        `emp`.`deleted_on` AS `deleted_on`,
        `emp`.`profile_photo` AS `profile_photo`,
        `mstdep`.`department_name` AS `department_name`,
        `rmprole`.`employe_role_name` AS `employee_role_name`,
        `empreporting`.`employee_name` AS `reporting_to_name`,
        `mstemptype`.`employee_type_name` AS `employee_type_name`,
        `mstempstatus`.`employee_status_name` AS `employee_status_name` 
    FROM
        (((((`pms_empoyees` `emp`
        LEFT JOIN `pms_mst_employee_status` `mstempstatus` ON ((`emp`.`employee_status` = `mstempstatus`.`employee_status_id`)))
        LEFT JOIN `pms_mst_employee_type` `mstemptype` ON ((`emp`.`employee_type` = `mstemptype`.`employee_type_id`)))
        LEFT JOIN `pms_mst_department` `mstdep` ON ((`emp`.`department_id` = `mstdep`.`department_id`)))
        LEFT JOIN `pms_mst_employee_role` `rmprole` ON ((`emp`.`employee_role` = `rmprole`.`employee_role_id`)))
        LEFT JOIN `pms_empoyees` `empreporting` ON ((`emp`.`remporting_to` = `empreporting`.`employee_id`)));
        

        

        -- changes in pms_empoyees table  ---by  rahul choudhary  -- 26-05-2023
        ALTER TABLE `pmsdakshabhi`.`pms_empoyees` 
CHANGE COLUMN `profile_photo` `profile_photo` VARCHAR(100) DEFAULT 'default.jpg'
        
 
 CREATE TABLE `pmsdakshabhi`.`pms_mst_customer_type` (
  `customer_type_id` INT(11) NOT NULL AUTO_INCREMENT,
  `company_id` INT(2) NULL,
  `customer_type` VARCHAR(150) NULL,
  `is_deleted` INT(1) NULL DEFAULT '0',
  PRIMARY KEY (`customer_type_id`));

  ALTER TABLE `pmsdakshabhi`.`pms_customers` 
ADD COLUMN `customer_type_id` INT(2) NULL DEFAULT '0' AFTER `is_deleted`;


ALTER TABLE `pmsdakshabhi`.`pms_empoyees` 
CHANGE COLUMN `date_of_birth` `date_of_birth` DATE NULL DEFAULT NULL ,
CHANGE COLUMN `date_joining` `date_joining` DATE NULL DEFAULT NULL ;



-- changes in pms_companies  ---by  rahul choudhary  -- 31-05-2023

ALTER TABLE pmsdakshabhi.pms_companies
ADD company_address varchar(1000) DEFAULT NULL,
ADD company_phone varchar(45) DEFAULT NULL,
ADD company_email varchar(45) DEFAULT NULL;


---- pms_task_log_info_view 01-06-2023 by yogesh ----
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_task_log_info_view` AS
    SELECT 
        `task_log`.`task_log_id` AS `task_log_id`,
        `project_task`.`project_id` AS `project_id`,
        `task_log`.`task_id` AS `task_id`,
        `project_task`.`task_name` AS `task_name`,
        `task_log`.`log_date` AS `log_date`,
        `task_log`.`log_hours` AS `log_hours`,
        `task_log`.`task_activity_id` AS `task_activity_id`,
        `task_activity`.`task_activity` AS `task_activity_name`,
        `task_log`.`taskComments` AS `taskComments`,
        `task_log`.`is_deleted` AS `task_log_is_deleted`,
        `task_log`.`created_by` AS `task_log_created_by`,
        `employee1`.`employee_name` AS `createdBy_employee_name`,
        `employee1`.`profile_photo` AS `employee_profile_avatar`,
        `employee2`.`employee_name` AS `modifiedBy_employee_name`,
        `task_log`.`created_on` AS `task_log_created_on`,
        `task_log`.`modified_by` AS `task_log_modified_by`,
        `task_log`.`modified_on` AS `task_log_modified_on`,
        `task_log`.`deleted_by` AS `task_log_deleted_by`,
        `employee3`.`employee_name` AS `deletedBy_employee_name`,
        `task_log`.`deleted_on` AS `task_log_deleted_on`
    FROM
        (((((`pms_task_log` `task_log`
        LEFT JOIN `pms_project_task` `project_task` ON ((`task_log`.`task_id` = `project_task`.`task_id`)))
        LEFT JOIN `pms_mst_task_activity` `task_activity` ON ((`task_log`.`task_activity_id` = `task_activity`.`task_activity_id`)))
        LEFT JOIN `pms_empoyees` `employee1` ON ((`task_log`.`created_by` = `employee1`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee2` ON ((`task_log`.`modified_by` = `employee2`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee3` ON ((`task_log`.`deleted_by` = `employee3`.`employee_id`))) 
        
        ------ project_employee_info_view -----
        CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project_employee_info_view` AS
    SELECT 
        `projemp`.`project_employee_id` AS `project_employee_id`,
        `projemp`.`company_id` AS `company_id`,
        `projemp`.`project_id` AS `project_id`,
        `projemp`.`employee_id` AS `employee_id`,
        `projemp`.`date_added` AS `date_added`,
        `projemp`.`is_deleted` AS `is_deleted`,
        `projects`.`project_name` AS `project_name`,
        `employees`.`employee_name` AS `employee_name`,
        `department`.`department_name` AS `department_name`,
        `employeerole`.`employe_role_name` AS `employe_role_name`,
        `employees`.`profile_photo` AS `profile_photo`
    FROM
        ((((`pms_project_employee` `projemp`
        LEFT JOIN `pms_projects` `projects` ON ((`projemp`.`project_id` = `projects`.`project_id`)))
        LEFT JOIN `pms_empoyees` `employees` ON ((`projemp`.`employee_id` = `employees`.`employee_id`)))
        LEFT JOIN `pms_mst_department` `department` ON ((`employees`.`department_id` = `department`.`department_id`)))
        LEFT JOIN `pms_mst_employee_role` `employeerole` ON ((`employees`.`employee_role` = `employeerole`.`employee_role_id`)))
        
        
        
-----------------------------------
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_task_log_info_view` AS
    SELECT 
        `task_log`.`task_log_id` AS `task_log_id`,
        `project_task`.`project_id` AS `project_id`,
        `task_log`.`task_id` AS `task_id`,
        `project_task`.`task_name` AS `task_name`,
        `task_log`.`log_date` AS `log_date`,
        `task_log`.`log_hours` AS `log_hours`,
        `task_log`.`task_activity_id` AS `task_activity_id`,
        `task_activity`.`task_activity` AS `task_activity_name`,
        `task_log`.`taskComments` AS `taskComments`,
        `task_log`.`is_deleted` AS `task_log_is_deleted`,
        `task_log`.`created_by` AS `task_log_created_by`,
        `employee1`.`employee_name` AS `createdBy_employee_name`,
        `employee1`.`profile_photo` AS `employee_profile_avatar`,
        `employee2`.`employee_name` AS `modifiedBy_employee_name`,
        `task_log`.`created_on` AS `task_log_created_on`,
        `task_log`.`modified_by` AS `task_log_modified_by`,
        `task_log`.`modified_on` AS `task_log_modified_on`,
        `task_log`.`deleted_by` AS `task_log_deleted_by`,
        `employee3`.`employee_name` AS `deletedBy_employee_name`,
        `task_log`.`deleted_on` AS `task_log_deleted_on`,
        `project_task`.`assignee_employee_id` AS `assignee_employee_id`,
        `project_task`.`followers` AS `followers`,
        `project_task`.`created_by` AS `task_created_by`
    FROM
        (((((`pms_task_log` `task_log`
        LEFT JOIN `pms_project_task` `project_task` ON ((`task_log`.`task_id` = `project_task`.`task_id`)))
        LEFT JOIN `pms_mst_task_activity` `task_activity` ON ((`task_log`.`task_activity_id` = `task_activity`.`task_activity_id`)))
        LEFT JOIN `pms_empoyees` `employee1` ON ((`task_log`.`created_by` = `employee1`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee2` ON ((`task_log`.`modified_by` = `employee2`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee3` ON ((`task_log`.`deleted_by` = `employee3`.`employee_id`)))

        
        ------ 02-06-2023 by yogesh -----
        CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `task_message_info_view` AS
    SELECT 
        `task_msg`.`task_message_id` AS `task_message_id`,
        `task_msg`.`task_id` AS `task_id`,
        `task_msg`.`employee_id` AS `employee_id`,
        `task_msg`.`message` AS `message`,
        `task_msg`.`parent_message_id` AS `parent_message_id`,
        `task_msg`.`added_on` AS `added_on`,
        `task_msg`.`is_deleted` AS `is_deleted`,
        `task_msg`.`deleted_on` AS `deleted_on`,
        `task_msg`.`deleted_by` AS `deleted_by`,
        `employee`.`employee_name` AS `employee_name`,
        `employee`.`profile_photo` AS `profile_photo`
    FROM
        (`pms_task_messages` `task_msg`
        LEFT JOIN `pms_empoyees` `employee` ON ((`task_msg`.`employee_id` = `employee`.`employee_id`)))
        
--------
        
ALTER TABLE `pmsdakshabhi`.`pms_companies` 
ADD COLUMN `siteurl` VARCHAR(200) NULL AFTER `company_email`; 

ALTER TABLE `pmsdakshabhi`.`pms_projects` 
ADD COLUMN `created_by` INT(11) NULL DEFAULT '0' AFTER `project_type_id`,
ADD COLUMN `created_on` DATETIME NULL AFTER `created_by`;


USE `pmsdakshabhi`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project_info_view` AS
    SELECT 
        `project`.`project_id` AS `project_id`,
        `project`.`company_id` AS `company_id`,
        `project`.`customer_id` AS `customer_id`,
        `project`.`project_name` AS `project_name`,
        `project`.`project_description` AS `project_description`,
        `project`.`project_group_id` AS `project_group_id`,
        `project`.`project_sub_group_id` AS `project_sub_group_id`,
        `project`.`project_inp_number` AS `project_inp_number`,
        `project`.`project_start_date` AS `project_start_date`,
        `project`.`project_end_date` AS `project_end_date`,
        `project`.`project_status_id` AS `project_status_id`,
        `project`.`is_active` AS `is_active`,
        `project`.`is_deleted` AS `is_deleted`,
        `project`.`customer_order_date` AS `customer_order_date`,
        `project`.`customer_order_no` AS `customer_order_no`,
        `customer`.`customer_name` AS `customer_name`,
        `customer`.`is_active` AS `customer_active`,
        `customer`.`is_deleted` AS `customer_deleted`,
        `groups`.`project_group` AS `project_group`,
        `subgroup`.`project_sub_group` AS `project_sub_group`,
        `pstatus`.`project_status` AS `project_status`,
        `project`.`project_code` AS `project_code`,
        `project`.`project_type_id` AS `project_type_id`,
        `project`.`created_by` AS `created_by`,
        `project`.`created_on` AS `created_on`,
        `type`.`project_type` AS `project_type`
    FROM
        (((((`pms_projects` `project`
        LEFT JOIN `pms_mst_project_groups` `groups` ON ((`project`.`project_group_id` = `groups`.`project_group_id`)))
        LEFT JOIN `pms_mst_project_sub_groups` `subgroup` ON ((`project`.`project_sub_group_id` = `subgroup`.`project_sub_group_id`)))
        JOIN `pms_customers` `customer` ON (((`project`.`customer_id` = `customer`.`customer_id`)
            AND (`customer`.`is_deleted` = 0))))
        LEFT JOIN `pms_mst_project_status` `pstatus` ON ((`project`.`project_status_id` = `pstatus`.`project_status_id`)))
        LEFT JOIN `pms_mst_project_type` `type` ON ((`project`.`project_type_id` = `type`.`project_type_id`)));

------- on 7 june 23

        CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_task_log_info_view` AS
    SELECT 
        `task_log`.`task_log_id` AS `task_log_id`,
        `project_task`.`project_id` AS `project_id`,
        `task_log`.`task_id` AS `task_id`,
        `project_task`.`task_name` AS `task_name`,
        `task_log`.`log_date` AS `log_date`,
        `task_log`.`log_hours` AS `log_hours`,
        `task_log`.`task_activity_id` AS `task_activity_id`,
        `task_activity`.`task_activity` AS `task_activity_name`,
        `task_log`.`taskComments` AS `taskComments`,
        `task_log`.`is_deleted` AS `task_log_is_deleted`,
        `task_log`.`created_by` AS `task_log_created_by`,
        `employee1`.`employee_name` AS `createdBy_employee_name`,
        `employee1`.`profile_photo` AS `employee_profile_avatar`,
        `employee2`.`employee_name` AS `modifiedBy_employee_name`,
        `task_log`.`created_on` AS `task_log_created_on`,
        `task_log`.`modified_by` AS `task_log_modified_by`,
        `task_log`.`modified_on` AS `task_log_modified_on`,
        `task_log`.`deleted_by` AS `task_log_deleted_by`,
        `employee3`.`employee_name` AS `deletedBy_employee_name`,
        `task_log`.`deleted_on` AS `task_log_deleted_on`,
        `project_task`.`assignee_employee_id` AS `assignee_employee_id`,
        `project_task`.`followers` AS `followers`,
        `project_task`.`created_by` AS `task_created_by`,
        `project_task`.`task_estimated_time` AS `task_estimated_time`
    FROM
        (((((`pms_task_log` `task_log`
        LEFT JOIN `pms_project_task` `project_task` ON ((`task_log`.`task_id` = `project_task`.`task_id`)))
        LEFT JOIN `pms_mst_task_activity` `task_activity` ON ((`task_log`.`task_activity_id` = `task_activity`.`task_activity_id`)))
        LEFT JOIN `pms_empoyees` `employee1` ON ((`task_log`.`created_by` = `employee1`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee2` ON ((`task_log`.`modified_by` = `employee2`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee3` ON ((`task_log`.`deleted_by` = `employee3`.`employee_id`)))
        
        
 CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project_employee_info_view` AS
    SELECT 
        `projemp`.`project_employee_id` AS `project_employee_id`,
        `projemp`.`company_id` AS `company_id`,
        `projemp`.`project_id` AS `project_id`,
        `projemp`.`employee_id` AS `employee_id`,
        `projemp`.`date_added` AS `date_added`,
        `projemp`.`is_deleted` AS `is_deleted`,
        `projects`.`project_name` AS `project_name`,
        `employees`.`employee_name` AS `employee_name`,
        `employees`.`employee_email` AS `employee_email`,
        `department`.`department_name` AS `department_name`,
        `employeerole`.`employe_role_name` AS `employe_role_name`,
        `employees`.`profile_photo` AS `profile_photo`
    FROM
        ((((`pms_project_employee` `projemp`
        LEFT JOIN `pms_projects` `projects` ON ((`projemp`.`project_id` = `projects`.`project_id`)))
        LEFT JOIN `pms_empoyees` `employees` ON ((`projemp`.`employee_id` = `employees`.`employee_id`)))
        LEFT JOIN `pms_mst_department` `department` ON ((`employees`.`department_id` = `department`.`department_id`)))
        LEFT JOIN `pms_mst_employee_role` `employeerole` ON ((`employees`.`employee_role` = `employeerole`.`employee_role_id`)))
        
 ------- 13-06-23------
 ALTER TABLE `pmsdakshabhi`.`pms_mst_employee_role` 
ADD COLUMN `employee_role_type` INT(1) NULL DEFAULT '0' AFTER `employe_role_desc`;


USE `pmsdakshabhi`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `employee_info_view` AS
    SELECT 
        `emp`.`employee_id` AS `employee_id`,
        `emp`.`company_id` AS `company_id`,
        `emp`.`employee_code` AS `employee_code`,
        `emp`.`employee_name` AS `employee_name`,
        `emp`.`department_id` AS `department_id`,
        `emp`.`remporting_to` AS `remporting_to`,
        `emp`.`employee_role` AS `employee_role`,
        `emp`.`employee_email` AS `employee_email`,
        `emp`.`employee_phone` AS `employee_phone`,
        `emp`.`employee_password` AS `employee_password`,
        `emp`.`is_active` AS `is_active`,
        `emp`.`is_deleted` AS `is_deleted`,
        `emp`.`employee_type` AS `employee_type`,
        `emp`.`aadhar_card_no` AS `aadhar_card_no`,
        `emp`.`passport_no` AS `passport_no`,
        `emp`.`pan_no` AS `pan_no`,
        `emp`.`current_address` AS `current_address`,
        `emp`.`permanant_address` AS `permanant_address`,
        `emp`.`date_of_birth` AS `date_of_birth`,
        `emp`.`gender` AS `gender`,
        `emp`.`employee_status` AS `employee_status`,
        `emp`.`date_joining` AS `date_joining`,
        `emp`.`created_by` AS `created_by`,
        `emp`.`created_on` AS `created_on`,
        `emp`.`modified_by` AS `modified_by`,
        `emp`.`modified_on` AS `modified_on`,
        `emp`.`deleted_by` AS `deleted_by`,
        `emp`.`deleted_on` AS `deleted_on`,
        `emp`.`profile_photo` AS `profile_photo`,
        `mstdep`.`department_name` AS `department_name`,
        `rmprole`.`employe_role_name` AS `employee_role_name`,
        `rmprole`.`employee_role_type` AS `employee_role_type`,
        `empreporting`.`employee_name` AS `reporting_to_name`,
        `mstemptype`.`employee_type_name` AS `employee_type_name`,
        `mstempstatus`.`employee_status_name` AS `employee_status_name`
    FROM
        (((((`pms_empoyees` `emp`
        LEFT JOIN `pms_mst_employee_status` `mstempstatus` ON ((`emp`.`employee_status` = `mstempstatus`.`employee_status_id`)))
        LEFT JOIN `pms_mst_employee_type` `mstemptype` ON ((`emp`.`employee_type` = `mstemptype`.`employee_type_id`)))
        LEFT JOIN `pms_mst_department` `mstdep` ON ((`emp`.`department_id` = `mstdep`.`department_id`)))
        LEFT JOIN `pms_mst_employee_role` `rmprole` ON ((`emp`.`employee_role` = `rmprole`.`employee_role_id`)))
        LEFT JOIN `pms_empoyees` `empreporting` ON ((`emp`.`remporting_to` = `empreporting`.`employee_id`)));

ALTER TABLE `pmsdakshabhi`.`pms_mst_task_status` 
ADD COLUMN `task_status_type` INT(1) NULL DEFAULT '0' AFTER `is_deleted`;


ALTER TABLE `pmsdakshabhi`.`pms_mst_task_priority` 
ADD COLUMN `task_priority_type` INT(1) NULL DEFAULT '0' AFTER `is_deleted`;

SELECT 
        `project_task`.`task_id` AS `task_id`,
        `project_task`.`company_id` AS `company_id`,
        `project_task`.`project_id` AS `project_id`,
        `project_task`.`task_name` AS `task_name`,
        `project_task`.`task_description` AS `task_description`,
        `project_task`.`task_status_id` AS `task_status_id`,
        `project_task`.`task_type_id` AS `task_type_id`,
        `project_task`.`task_priority_id` AS `task_priority_id`,
        `project_task`.`assignee_employee_id` AS `assignee_employee_id`,
        `project_task`.`task_start_date` AS `task_start_date`,
        `project_task`.`task_due_date` AS `task_due_date`,
        `project_task`.`task_estimated_time` AS `task_estimated_time`,
        `project_task`.`task_completion_value` AS `task_completion_value`,
        `project_task`.`is_deleted` AS `is_deleted`,
        `project_task`.`followers` AS `followers`,
        `project_task`.`created_by` AS `created_by`,
        `project_task`.`created_on` AS `created_on`,
        `project_task`.`modified_by` AS `modified_by`,
        `project_task`.`modified_on` AS `modified_on`,
        `project_task`.`deleted_by` AS `deleted_by`,
        `project_task`.`deleted_on` AS `deleted_on`,
        `task_type`.`task_type` AS `task_type`,
        `task_status`.`task_status` AS `task_status`,
        `task_status`.`task_status_type` AS `task_status_type`,
        `task_priority`.`task_priority` AS `task_priority`,
        `task_priority`.`task_priority_type` AS `task_priority_type`,
        `employee`.`employee_name` AS `employee_name`,
        `project`.`project_name` AS `project_name`,
        `project`.`is_deleted` AS `project_is_deleted`
    FROM
        (((((`pms_project_task` `project_task`
        LEFT JOIN `pms_mst_task_type` `task_type` ON ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
        LEFT JOIN `pms_mst_task_status` `task_status` ON ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
        LEFT JOIN `pms_mst_task_priority` `task_priority` ON ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
        JOIN `pms_empoyees` `employee` ON (((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)
            AND (`employee`.`is_deleted` = 0))))
        JOIN `pms_projects` `project` ON (((`project_task`.`project_id` = `project`.`project_id`)
            AND (`project`.`is_deleted` = 0))))
            
----------------------------------------------------------
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pmsdakshabhi-qa`.`task_message_info_view` AS
    SELECT 
        `task_msg`.`task_message_id` AS `task_message_id`,
        `task_msg`.`task_id` AS `task_id`,
        `task_msg`.`employee_id` AS `employee_id`,
        `task_msg`.`message` AS `message`,
        `task_msg`.`parent_message_id` AS `parent_message_id`,
        `task_msg`.`added_on` AS `added_on`,
        `task_msg`.`is_deleted` AS `is_deleted`,
        `task_msg`.`deleted_on` AS `deleted_on`,
        `task_msg`.`deleted_by` AS `deleted_by`,
        `employee`.`employee_name` AS `employee_name`,
        `employee`.`profile_photo` AS `profile_photo`,
        `task`.`task_name` AS `task_name`,
        `task`.`company_id` AS `task_company_id`,
        `task`.`project_id` AS `task_project_id`,
        `task`.`assignee_employee_id` AS `task_assignee_employee_id`,
        `task`.`followers` AS `task_followers`,
        `task`.`created_by` AS `task_created_by`
    FROM
        ((`pmsdakshabhi`.`pms_task_messages` `task_msg`
        LEFT JOIN `pmsdakshabhi`.`pms_empoyees` `employee` ON ((`task_msg`.`employee_id` = `employee`.`employee_id`)))
        LEFT JOIN `pmsdakshabhi`.`pms_project_task` `task` ON ((`task_msg`.`task_id` = `task`.`task_id`)))

        
    ---------21-07-2023------------
    ALTER TABLE `pmsdakshabhi`.`pms_task_document` 
	CHANGE COLUMN `discription` `discription` VARCHAR(255) NULL DEFAULT NULL ;    
	
	
	--------26-07-2023----------
	
	ALTER TABLE `pmsdakshabhi`.`pms_task_document` 
	CHANGE COLUMN `document_name` `document_name` VARCHAR(255) NULL DEFAULT NULL ;

	ALTER TABLE `pmsdakshabhi`.`pms_task_document` 
	ADD COLUMN `isadditional_doc` INT(1) NULL DEFAULT '0' AFTER `task_id`;
	
	
	-------27-07-2023 by pankaj---------
	
	INSERT INTO `pmsdakshabhi`.`pms_mst_task_status` (`task_status_id`, `company_id`, `task_status`) VALUES ('8', '1', 'Overdue');
	
	--------28-07-2023 by yogesh----------
		
	ALTER TABLE `pmsdakshabhi`.`pms_project_task` 
	ADD COLUMN `task_due_dateTime` DateTime NULL AFTER `task_due_date`;
	
	------- Task Status ------
	ALTER TABLE `pmsdakshabhi`.`pms_mst_task_status` 
	ADD COLUMN `is_default` int(1) default '0';
	UPDATE `pmsdakshabhi`.`pms_mst_task_status` SET `is_default` = '1' WHERE (`task_status_id` = '4');
	
	
	-------- Task Type------
	ALTER TABLE `pmsdakshabhi`.`pms_mst_task_type` 
	ADD COLUMN `is_default` int(1) default '0';
	UPDATE `pmsdakshabhi`.`pms_mst_task_type` SET `is_default` = '1' WHERE (`task_type_id` = '1');
	
	
	-------- Task Priority -------
	ALTER TABLE `pmsdakshabhi`.`pms_mst_task_priority` 
	ADD COLUMN `is_default` int(1) default '0';
	UPDATE `pmsdakshabhi`.`pms_mst_task_priority` SET `is_default` = '1' WHERE (`task_priority_id` = '2');
	
	
	-------- Task Activity -------
	ALTER TABLE `pmsdakshabhi`.`pms_mst_task_activity` 
	ADD COLUMN `is_default` int(1) default '0';
	UPDATE `pmsdakshabhi`.`pms_mst_task_activity` SET `is_default` = '1' WHERE (`task_activity_id` = '2');
	
	
	-------- Project Type -------
	ALTER TABLE `pmsdakshabhi`.`pms_mst_project_type` 
	ADD COLUMN `is_default` int(1) default '0';
	UPDATE `pmsdakshabhi`.`pms_mst_project_type` SET `is_default` = '1' WHERE (`project_type_id` = '1');
	
	
	--------- Project Status------
	
	ALTER TABLE `pmsdakshabhi`.`pms_mst_project_status` 
	ADD COLUMN `is_default` int(1) default '0';
	
	ALTER TABLE `pmsdakshabhi`.`pms_mst_project_status` 
	ADD COLUMN `is_deleted` int(1) default '0';
	
	UPDATE `pmsdakshabhi`.`pms_mst_project_status` SET `is_default` = '1' WHERE  company_id = "1" and  (`project_status_id` = '6');
	
	
	--------- customer Type ------
	ALTER TABLE `pmsdakshabhi`.`pms_mst_customer_type` 
	ADD COLUMN `is_default` int(1) default '0';
	
	UPDATE `pmsdakshabhi`.`pms_mst_customer_type` SET `is_default` = '1' WHERE  company_id = "1" and  (`customer_type_id` = '6');
	
	--------- Employee Type ------
	ALTER TABLE `pmsdakshabhi`.`pms_mst_employee_type` 
	ADD COLUMN `is_deleted` int(1) default '0';
	
	
	ALTER TABLE `pmsdakshabhi`.`pms_mst_employee_type` 
	ADD COLUMN `is_default` int(1) default '0';
	
	UPDATE `pmsdakshabhi`.`pms_mst_employee_type` SET `is_default` = '1' WHERE  company_id = "1" and  (`employee_type_id` = '3');
	
	
	--------- master Department ------
	ALTER TABLE `pmsdakshabhi`.`pms_mst_department` 
	ADD COLUMN `is_default` int(1) default '0';
	
	UPDATE `pmsdakshabhi`.`pms_mst_department` SET `is_default` = '1' WHERE  company_id = "1" and  (`department_id` = '3');
	
	
	--------Employee Role ---------------
	
	ALTER TABLE `pmsdakshabhi`.`pms_mst_employee_role` 
	ADD COLUMN `is_default` int(1) default '0';
	
	UPDATE `pmsdakshabhi`.`pms_mst_employee_role` SET `is_default` = '1' WHERE  company_id = "1" and  (`employee_role_id` = '1');
	
	--------Employee Status ---------------
	
	ALTER TABLE `pmsdakshabhi`.`pms_mst_employee_status` 
	ADD COLUMN `is_deleted` int(1) default '0';
	
	ALTER TABLE `pmsdakshabhi`.`pms_mst_employee_status` 
	ADD COLUMN `is_default` int(1) default '0';
	
	UPDATE `pmsdakshabhi`.`pms_mst_employee_status` SET `is_default` = '1' WHERE  company_id = "1" and  (`employee_status_id` = '3');

-------28-07-2023 by pratik ---------
	CREATE TABLE `user_device_details` (
  	`id` int NOT NULL AUTO_INCREMENT,
  	`user_id` int DEFAULT NULL,
  	`device_token` varchar(255) DEFAULT NULL,
  	PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
	
	
---------- project_task_info_view --------------

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_project_task_info_view` AS
    SELECT 
        `project_task`.`task_id` AS `task_id`,
        `project_task`.`company_id` AS `company_id`,
        `project_task`.`project_id` AS `project_id`,
        `project_task`.`task_name` AS `task_name`,
        `project_task`.`task_description` AS `task_description`,
        `project_task`.`task_status_id` AS `task_status_id`,
        `project_task`.`task_type_id` AS `task_type_id`,
        `project_task`.`task_priority_id` AS `task_priority_id`,
        `project_task`.`assignee_employee_id` AS `assignee_employee_id`,
        `project_task`.`task_start_date` AS `task_start_date`,
        `project_task`.`task_due_date` AS `task_due_date`,
        `project_task`.`task_due_dateTime` AS `task_due_dateTime`,
        `project_task`.`task_estimated_time` AS `task_estimated_time`,
        `project_task`.`task_completion_value` AS `task_completion_value`,
        `project_task`.`is_deleted` AS `is_deleted`,
        `project_task`.`followers` AS `followers`,
        `project_task`.`created_by` AS `created_by`,
        `project_task`.`created_on` AS `created_on`,
        `project_task`.`modified_by` AS `modified_by`,
        `project_task`.`modified_on` AS `modified_on`,
        `project_task`.`deleted_by` AS `deleted_by`,
        `project_task`.`deleted_on` AS `deleted_on`,
        `task_type`.`task_type` AS `task_type`,
        `task_status`.`task_status` AS `task_status`,
        `task_status`.`task_status_type` AS `task_status_type`,
        `task_priority`.`task_priority` AS `task_priority`,
        `task_priority`.`task_priority_type` AS `task_priority_type`,
        `employee`.`employee_name` AS `employee_name`,
        `project`.`project_name` AS `project_name`,
        `project`.`is_deleted` AS `project_is_deleted`
    FROM
        (((((`pms_project_task` `project_task`
        LEFT JOIN `pms_mst_task_type` `task_type` ON ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
        LEFT JOIN `pms_mst_task_status` `task_status` ON ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
        LEFT JOIN `pms_mst_task_priority` `task_priority` ON ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
        JOIN `pms_empoyees` `employee` ON (((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)
            AND (`employee`.`is_deleted` = 0))))
        JOIN `pms_projects` `project` ON (((`project_task`.`project_id` = `project`.`project_id`)
            AND (`project`.`is_deleted` = 0))))	
            
            
            
            
-----------28-07-2023 Alter table of user deatails -------------

     ALTER TABLE user_device_details RENAME TO pms_user_device_details; 
	
 ----------- 03-08-2023 ---------
 
 ALTER TABLE  `pms_task_document` 
CHANGE COLUMN `isadditional_doc` `tasklog_id` INT NULL DEFAULT '0' ; 



CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_task_log_info_view` AS
    SELECT 
        `task_log`.`task_log_id` AS `task_log_id`,
        `project_task`.`project_id` AS `project_id`,
        `task_log`.`task_id` AS `task_id`,
        `project_task`.`task_name` AS `task_name`,
        `task_log`.`log_date` AS `log_date`,
        `task_log`.`log_hours` AS `log_hours`,
        `task_log`.`task_activity_id` AS `task_activity_id`,
        `task_activity`.`task_activity` AS `task_activity_name`,
        `task_log`.`taskComments` AS `taskComments`,
        `task_log`.`is_deleted` AS `task_log_is_deleted`,
        `task_log`.`created_by` AS `task_log_created_by`,
        `employee1`.`employee_name` AS `createdBy_employee_name`,
        `employee1`.`profile_photo` AS `employee_profile_avatar`,
        `employee2`.`employee_name` AS `modifiedBy_employee_name`,
        `task_log`.`created_on` AS `task_log_created_on`,
        `task_log`.`modified_by` AS `task_log_modified_by`,
        `task_log`.`modified_on` AS `task_log_modified_on`,
        `task_log`.`deleted_by` AS `task_log_deleted_by`,
        `employee3`.`employee_name` AS `deletedBy_employee_name`,
        `task_log`.`deleted_on` AS `task_log_deleted_on`,
        `project_task`.`assignee_employee_id` AS `assignee_employee_id`,
        `project_task`.`followers` AS `followers`,
        `project_task`.`created_by` AS `task_created_by`,
        `project_task`.`task_estimated_time` AS `task_estimated_time`,
        `task_document`.`document_id` AS `document_id`,
        `task_document`.`document_name` AS `document_name`,
        `task_document`.`discription` AS `doc_discription`,
        `task_document`.`is_delete` AS `doc_is_delete`
    FROM
        ((((((`pms_task_log` `task_log`
        LEFT JOIN `pms_project_task` `project_task` ON ((`task_log`.`task_id` = `project_task`.`task_id`)))
        LEFT JOIN `pms_mst_task_activity` `task_activity` ON ((`task_log`.`task_activity_id` = `task_activity`.`task_activity_id`)))
        LEFT JOIN `pms_empoyees` `employee1` ON ((`task_log`.`created_by` = `employee1`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee2` ON ((`task_log`.`modified_by` = `employee2`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee3` ON ((`task_log`.`deleted_by` = `employee3`.`employee_id`)))
        LEFT JOIN `pms_task_document` `task_document` ON ((`task_log`.`task_log_id` = `task_document`.`tasklog_id`)))

   
        
--------------------------------------------------------------------------------------------------------------------------
03-08-2023 By Akshay


-- pmsdakshabhi.pms_project_task_info_view source

create or replace
algorithm = UNDEFINED view `pms_project_task_info_view` as
select
    `project_task`.`task_id` as `task_id`,
    `project_task`.`company_id` as `company_id`,
    `project_task`.`project_id` as `project_id`,
    `project_task`.`task_name` as `task_name`,
    `project_task`.`task_description` as `task_description`,
    `project_task`.`task_status_id` as `task_status_id`,
    `project_task`.`task_type_id` as `task_type_id`,
    `project_task`.`task_priority_id` as `task_priority_id`,
    `project_task`.`assignee_employee_id` as `assignee_employee_id`,
    `project_task`.`task_start_date` as `task_start_date`,
    `project_task`.`task_due_date` as `task_due_date`,
    `project_task`.`task_due_dateTime` as `task_due_dateTime`,
    `project_task`.`task_estimated_time` as `task_estimated_time`,
    `project_task`.`task_completion_value` as `task_completion_value`,
    `project_task`.`is_deleted` as `is_deleted`,
    `project_task`.`followers` as `followers`,
    `project_task`.`created_by` as `created_by`,
    `project_task`.`created_on` as `created_on`,
    `project_task`.`modified_by` as `modified_by`,
    `project_task`.`modified_on` as `modified_on`,
    `project_task`.`deleted_by` as `deleted_by`,
    `project_task`.`deleted_on` as `deleted_on`,
    `task_type`.`task_type` as `task_type`,
    `task_status`.`task_status` as `task_status`,
    `task_status`.`task_status_type` as `task_status_type`,
    `task_priority`.`task_priority` as `task_priority`,
    `task_priority`.`task_priority_type` as `task_priority_type`,
    `employee`.`employee_name` as `employee_name`,
    `project`.`project_name` as `project_name`,
    `project`.`is_deleted` as `project_is_deleted`
from
    (((((`pms_project_task` `project_task`
left join `pms_mst_task_type` `task_type` on
    ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
left join `pms_mst_task_status` `task_status` on
    ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
left join `pms_mst_task_priority` `task_priority` on
    ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
join `pms_empoyees` `employee` on
    (((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)
        and (`employee`.`is_deleted` = 0))))
join `pms_projects` `project` on
    (((`project_task`.`project_id` = `project`.`project_id`)
        and (`project`.`is_deleted` = 0))));
        
--------------------------------------------------------------------------------------------------------------------------------------------        


CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `pms_customers_view` AS
select
    `cust`.`customer_id` AS `customer_id`,
    `cust`.`company_id` AS `company_id`,
    `cust`.`customer_name` AS `customer_name`,
    `cust`.`customer_address` AS `customer_address`,
    `cust`.`customer_email` AS `customer_email`,
    `cust`.`customer_phone` AS `customer_phone`,
    case
        `cust`.`is_active` when 1 then 'Active'
        else 'In Active'
    end AS `Active`,
    case
        `cust`.`is_deleted` when 1 then 'Yes'
        else 'No'
    end AS `Deleted`,
    `cust`.`is_active` AS `is_active`,
    `cust`.`is_deleted` AS `is_deleted`,
    `cust`.`customer_type_id` AS `customer_type_id`,
    `cust`.`customer_alternate_contact` AS `customer_alternate_contact`,
    `cust`.`customer_alternate_email` AS `customer_alternate_email`,
    `cust`.`customer_id` AS `field_id`,
    `cust`.`customer_name` AS `field_name`
   
from `pms_customers` `cust`;
----------------------------------------------------------------------------------------------------------

-- pmsdakshabhi.pms_customers_view source

-- pmsdakshabhi.pms_customers_view source


CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `pms_projects_view` AS
select
    `proj`.`project_id` AS `project_id`,
    `proj`.`company_id` AS `company_id`,
    `proj`.`customer_id` AS `customer_id`,
    `proj`.`project_name` AS `project_name`,
    `proj`.`project_description` AS `project_description`,
    `proj`.`project_group_id` AS `project_group_id`,
    `proj`.`project_sub_group_id` AS `project_sub_group_id`,
    
    `proj`.`project_inp_number` AS `project_inp_number`,
    `proj`.`project_start_date` AS `project_start_date`,
    `proj`.`project_end_date` AS `project_end_date`,
    `proj`.`project_status_id` AS `project_status_id`,
 
    
    case
        `proj`.`is_active` when 1 then 'Active'
        else 'In Active'
    end AS `Active`,
    case
        `proj`.`is_deleted` when 1 then 'Yes'
        else 'No'
    end AS `Deleted`,
    `proj`.`customer_order_date` AS `customer_order_date`,
    `proj`.`customer_order_no` AS `customer_order_no`,
    `proj`.`project_code` AS `project_code`,
    `proj`.`project_type_id` AS `project_type_id`,
    `proj`.`created_by` AS `created_by`,
    `proj`.`created_on` AS `created_on`,
    `proj`.`project_id` AS `field_id`,
    `proj`.`project_name` AS `field_name`
   
from `pms_projects` `proj`;

------------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `pms_employees_view` AS
select
    `emp`.`employee_id` AS `employee_id`,
    `emp`.`company_id` AS `company_id`,
    `emp`.`employee_code` AS `employee_code`,
    `emp`.`employee_name` AS `employee_name`,
    `emp`.`department_id` AS `department_id`,
    `emp`.`remporting_to` AS `remporting_to`,
    `emp`.`employee_role` AS `employee_role`,
    `emp`.`employee_email` AS `employee_email`,
    `emp`.`employee_phone` AS `employee_phone`,
    `emp`.`employee_password` AS `employee_password`,
 
    case
        `emp`.`is_active` when 1 then 'Active'
        else 'In Active'
    end AS `Active`,
    case
        `emp`.`is_deleted` when 1 then 'Yes'
        else 'No'
    end AS `Deleted`,
    `emp`.`employee_type` AS `employee_type`,
    `emp`.`aadhar_card_no` AS `aadhar_card_no`,
    `emp`.`passport_no` AS `passport_no`,
    `emp`.`pan_no` AS `pan_no`,
    `emp`.`current_address` AS `current_address`,
    `emp`.`permanant_address` AS `permanant_address`,
    `emp`.`date_of_birth` AS `date_of_birth`,
    `emp`.`gender` AS `gender`,
    `emp`.`employee_status` AS `employee_status`,
    `emp`.`date_joining` AS `date_joining`,
    `emp`.`created_by` AS `created_by`,
    `emp`.`created_on` AS `created_on`,
    `emp`.`modified_by` AS `modified_by`,
    `emp`.`modified_on` AS `modified_on`,
    `emp`.`deleted_on` AS `deleted_on`,
    `emp`.`profile_photo` AS `profile_photo`,
    `emp`.`employee_id` AS `field_id`,
    `emp`.`employee_name` AS `field_name`
   
    
from `pms_empoyees` `emp`;

---------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `pms_mst_task_priority_view` AS
select
    `tskPriority`.`task_priority_id` AS `task_priority_id`,
    `tskPriority`.`company_id` AS `company_id`,
    `tskPriority`.`task_priority` AS `task_priority`,
    `tskPriority`.`task_priority_type` AS `task_priority_type`,
    `tskPriority`.`is_default` AS `is_default`,
    case
        `tskPriority`.`is_deleted` when 1 then 'Yes'
        else 'No'
    end AS `Deleted`,
    `tskPriority`.`task_priority_id` AS `field_id`,
    `tskPriority`.`task_priority` AS `field_name`
   
from `pms_mst_task_priority` `tskPriority`;
--------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `pms_mst_task_status_view` AS
select
    `tskStatus`.`task_status_id` AS `task_status_id`,
    `tskStatus`.`company_id` AS `company_id`,
    `tskStatus`.`task_status` AS `task_status`,
    `tskStatus`.`task_status_type` AS `task_status_type`,
    `tskStatus`.`is_default` AS `is_default`,
    case
        `tskStatus`.`is_deleted` when 1 then 'Yes'
        else 'No'
    end AS `Deleted`,
    `tskStatus`.`task_status_id` AS `field_id`,
    `tskStatus`.`task_status` AS `field_name`
   
from `pms_mst_task_status` `tskStatus`;

-----------------------------------------------------------------------------------------------------------

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `pms_mst_task_type_view` AS
select
    `tskType`.`task_type_id` AS `task_type_id`,
    `tskType`.`company_id` AS `company_id`,
    `tskType`.`task_type` AS `task_type`,
    `tskType`.`is_default` AS `is_default`,
    case
        `tskType`.`is_deleted` when 1 then 'Yes'
        else 'No'
    end AS `Deleted`,
    `tskType`.`task_type_id` AS `field_id`,
    `tskType`.`task_type` AS `field_name`
   
from `pms_mst_task_type` `tskType`;

-----------------------------------------------------------------------------------------------------------------------

-- pmsdakshabhi.pms_project_task_info_rpt source

create or replace
algorithm = UNDEFINED view `pms_project_task_info_rpt` as
select
    concat(`project_task`.`task_id`, ':N:N:') as `task_id`,
    concat(`project_task`.`company_id`, ':N:N:') as `company_id`,
    concat(`project_task`.`project_id`, ':N:N:') as `project_id`,
    concat(`project_task`.`task_name`, ':O:N:') as `task_name`,
    concat(`project_task`.`task_description`, ':O:N:') as `task_description`,
    concat(`project_task`.`task_status_id`, ':N:N:') as `task_status_id`,
    concat(`project_task`.`task_type_id`, ':N:N:') as `task_type_id`,
    concat(`project_task`.`task_priority_id`, ':N:N:') as `task_priority_id`,
    concat(`project_task`.`assignee_employee_id`, ':N:N:') as `assignee_employee_id`,
    concat(`project_task`.`task_start_date`, ':Y:D:N') as `task_start_date`,
    concat(`project_task`.`task_due_date`, ':Y:D:N') as `task_due_date`,
    concat(`project_task`.`task_due_dateTime`, ':O:N') as `task_due_dateTime`,
    concat(`project_task`.`task_estimated_time`, ':O:N:') as `task_estimated_time`,
    concat(`project_task`.`task_completion_value`, ':O:N:') as `task_completion_value`,
    concat(`project_task`.`is_deleted`, ':Y:H:(Yes,No)') as `is_deleted`,
    concat(`project_task`.`followers`, ':O:N:') as `followers`,
    concat(`project_task`.`created_by`, ':N:N:') as `created_by`,
    concat(`project_task`.`created_on`, ':N:N:') as `created_on`,
    concat(`project_task`.`modified_by`, ':N:N:') as `modified_by`,
    concat(`project_task`.`modified_on`, ':N:N:') as `modified_on`,
    concat(`project_task`.`deleted_by`, ':N:N:') as `deleted_by`,
    concat(`project_task`.`deleted_on`, ':N:N:') as `deleted_on`,
    concat(`task_type`.`task_type`, ':Y:C:pms_mst_task_type_view') as `task_type`,
    concat(`task_status`.`task_status`, ':Y:C:pms_mst_task_status_view') as `task_status`,
    concat(`task_status`.`task_status_type`, ':O:N:') as `task_status_type`,
    concat(`task_priority`.`task_priority`, ':Y:C:pms_mst_task_priority_view') as `task_priority`,
    concat(`task_priority`.`task_priority_type`, ':O:N:') as `task_priority_type`,
    concat(`employee`.`employee_name`, ':Y:C:pms_employees_view') as `employee_name`,
    concat(`project`.`project_name`, ':Y:C:pms_projects_view') as `project_name`,
    concat(`project`.`is_deleted`, ':N:N:') as `project_is_deleted`
from
    (((((`pms_project_task` `project_task`
left join `pms_mst_task_type` `task_type` on
    ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
left join `pms_mst_task_status` `task_status` on
    ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
left join `pms_mst_task_priority` `task_priority` on
    ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
join `pms_empoyees` `employee` on
    (((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)
        and (`employee`.`is_deleted` = 0))))
join `pms_projects` `project` on
    (((`project_task`.`project_id` = `project`.`project_id`)
        and (`project`.`is_deleted` = 0))))
limit 1;
         
 
	
        
   ----------------03-08-2023 by yogesh ---------
   -- colums added in pms_task_log_info_view---
   CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `pms_task_log_info_view` AS
    SELECT 
        `task_log`.`task_log_id` AS `task_log_id`,
        `project_task`.`project_id` AS `project_id`,
        `task_log`.`task_id` AS `task_id`,
        `project_task`.`task_name` AS `task_name`,
        `task_log`.`log_date` AS `log_date`,
        `task_log`.`log_hours` AS `log_hours`,
        `task_log`.`task_activity_id` AS `task_activity_id`,
        `task_activity`.`task_activity` AS `task_activity_name`,
        `task_log`.`taskComments` AS `taskComments`,
        `task_log`.`is_deleted` AS `task_log_is_deleted`,
        `task_log`.`created_by` AS `task_log_created_by`,
        `employee1`.`employee_name` AS `createdBy_employee_name`,
        `employee1`.`profile_photo` AS `employee_profile_avatar`,
        `employee2`.`employee_name` AS `modifiedBy_employee_name`,
        `task_log`.`created_on` AS `task_log_created_on`,
        `task_log`.`modified_by` AS `task_log_modified_by`,
        `task_log`.`modified_on` AS `task_log_modified_on`,
        `task_log`.`deleted_by` AS `task_log_deleted_by`,
        `employee3`.`employee_name` AS `deletedBy_employee_name`,
        `task_log`.`deleted_on` AS `task_log_deleted_on`,
        `project_task`.`assignee_employee_id` AS `assignee_employee_id`,
        `project_task`.`followers` AS `followers`,
        `project_task`.`created_by` AS `task_created_by`,
        `project_task`.`task_estimated_time` AS `task_estimated_time`,
        `task_document`.`document_id` AS `document_id`,
        `task_document`.`document_name` AS `document_name`,
        `task_document`.`discription` AS `doc_discription`,
        `task_document`.`created_on` AS `doc_created_on`,
        `task_document`.`is_delete` AS `doc_is_delete`
    FROM
        ((((((`pms_task_log` `task_log`
        LEFT JOIN `pms_project_task` `project_task` ON ((`task_log`.`task_id` = `project_task`.`task_id`)))
        LEFT JOIN `pms_mst_task_activity` `task_activity` ON ((`task_log`.`task_activity_id` = `task_activity`.`task_activity_id`)))
        LEFT JOIN `pms_empoyees` `employee1` ON ((`task_log`.`created_by` = `employee1`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee2` ON ((`task_log`.`modified_by` = `employee2`.`employee_id`)))
        LEFT JOIN `pms_empoyees` `employee3` ON ((`task_log`.`deleted_by` = `employee3`.`employee_id`)))
        LEFT JOIN `pms_task_document` `task_document` ON (((`task_log`.`task_log_id` = `task_document`.`tasklog_id`)
            AND (`task_document`.`is_delete` = '0'))))
            
---------------------------------------------------------------------------------------------------------------------------------

04-08-2023--- By akshay

create or replace
algorithm = UNDEFINED view `pms_project_task_info_view` as
select
	`employee`.`employee_name` as `employee_name`,
	`project_task`.`task_name` as `task_name`,
	`task_status`.`task_status` as `task_status`,
	`task_priority`.`task_priority` as `task_priority`,
	`project_task`.`task_start_date` as `task_start_date`,
    `project_task`.`task_due_date` as `task_due_date`,
    `project_task`.`task_id` as `task_id`,
    `project_task`.`company_id` as `company_id`,
    `project_task`.`project_id` as `project_id`,
    `project_task`.`task_description` as `task_description`,
    `project_task`.`task_status_id` as `task_status_id`,
    `project_task`.`task_type_id` as `task_type_id`,
    `project_task`.`task_priority_id` as `task_priority_id`,
    `project_task`.`assignee_employee_id` as `assignee_employee_id`,
    `project_task`.`task_due_dateTime` as `task_due_dateTime`,
    `project_task`.`task_estimated_time` as `task_estimated_time`,
    `project_task`.`task_completion_value` as `task_completion_value`,
    `project_task`.`is_deleted` as `is_deleted`,
    `project_task`.`followers` as `followers`,
    `project_task`.`created_by` as `created_by`,
    `project_task`.`created_on` as `created_on`,
    `project_task`.`modified_by` as `modified_by`,
    `project_task`.`modified_on` as `modified_on`,
    `project_task`.`deleted_by` as `deleted_by`,
    `project_task`.`deleted_on` as `deleted_on`,
    `task_type`.`task_type` as `task_type`,
    `task_status`.`task_status_type` as `task_status_type`,
    `task_priority`.`task_priority_type` as `task_priority_type`,
    `project`.`project_name` as `project_name`,
    `project`.`is_deleted` as `project_is_deleted`
from
    (((((`pms_project_task` `project_task`
left join `pms_mst_task_type` `task_type` on
    ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
left join `pms_mst_task_status` `task_status` on
    ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
left join `pms_mst_task_priority` `task_priority` on
    ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
join `pms_empoyees` `employee` on
    (((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)
        and (`employee`.`is_deleted` = 0))))
join `pms_projects` `project` on
    (((`project_task`.`project_id` = `project`.`project_id`)
        and (`project`.`is_deleted` = 0)))); 
        
        

08-08-2023

-- pmsdakshabhi_qa.pms_mst_task_status_view source

create or replace
algorithm = UNDEFINED view `pms_mst_task_status_view` as
select
    `tskstatus`.`task_status_id` as `task_status_id`,
    `tskstatus`.`company_id` as `company_id`,
    `tskstatus`.`task_status` as `task_status`,
    `tskstatus`.`task_status_type` as `task_status_type`,
    `tskstatus`.`is_default` as `is_default`,
    (case
        `tskstatus`.`is_deleted` when 1 then 'Yes'
        else 'No'
    end) as `Deleted`,
    `tskstatus`.`task_status_type` as `field_id`,
    `tskstatus`.`task_status` as `field_name`
from
    `pms_mst_task_status` `tskstatus`;
    
    

create or replace
algorithm = UNDEFINED view `pms_mst_task_priority_view` as
select
    `tskpriority`.`task_priority_id` as `task_priority_id`,
    `tskpriority`.`company_id` as `company_id`,
    `tskpriority`.`task_priority` as `task_priority`,
    `tskpriority`.`task_priority_type` as `task_priority_type`,
    `tskpriority`.`is_default` as `is_default`,
    (case
        `tskpriority`.`is_deleted` when 1 then 'Yes'
        else 'No'
    end) as `Deleted`,
    `tskpriority`.`task_priority_type` as `field_id`,
    `tskpriority`.`task_priority` as `field_name`
from
    `pms_mst_task_priority` `tskpriority`;    
        
    ---------- by yogesh ----------    
    CREATE or replace
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
	VIEW `project_employee_info_view` AS
    SELECT 
        `projemp`.`project_employee_id` AS `project_employee_id`,
        `projemp`.`company_id` AS `company_id`,
        `projemp`.`project_id` AS `project_id`,
        `projemp`.`employee_id` AS `employee_id`,
        `employees`.`department_id` AS `department_id`,
        `projemp`.`date_added` AS `date_added`,
        `projemp`.`is_deleted` AS `is_deleted`,
        `projects`.`project_name` AS `project_name`,
        `employees`.`employee_name` AS `employee_name`,
        `employees`.`employee_email` AS `employee_email`,
        `department`.`department_name` AS `department_name`,
        `employeerole`.`employe_role_name` AS `employe_role_name`,
        `employees`.`profile_photo` AS `profile_photo`
    FROM
        ((((`pms_project_employee` `projemp`
        LEFT JOIN `pms_projects` `projects` ON ((`projemp`.`project_id` = `projects`.`project_id`)))
        LEFT JOIN `pms_empoyees` `employees` ON ((`projemp`.`employee_id` = `employees`.`employee_id`)))
        LEFT JOIN `pms_mst_department` `department` ON ((`employees`.`department_id` = `department`.`department_id`)))
        LEFT JOIN `pms_mst_employee_role` `employeerole` ON ((`employees`.`employee_role` = `employeerole`.`employee_role_id`)))             

--------------------------------------------------------------------------


#07-08-2023 by akshay
#Added delays column

create or replace
algorithm = UNDEFINED view `pms_project_task_info_view` as
select
    `employee`.`employee_name` as `employee_name`,
    `project_task`.`task_name` as `task_name`,
    `task_status`.`task_status` as `task_status`,
    `task_priority`.`task_priority` as `task_priority`,
    `project_task`.`task_start_date` as `task_start_date`,
    `project_task`.`task_due_dateTime` as `task_due_dateTime`,
     CASE
        when task_status != 'Closed' THEN CONCAT(TIMESTAMPDIFF(DAY, task_due_dateTime, NOW()), ' days ', TIMEDIFF(NOW(), task_due_dateTime)) 
        ELSE '0'
        END AS delay,
    `project_task`.`task_due_date` as `task_due_date`,
    `project_task`.`task_id` as `task_id`,
    `project_task`.`company_id` as `company_id`,
    `project_task`.`project_id` as `project_id`,
    `project_task`.`task_description` as `task_description`,
    `project_task`.`task_status_id` as `task_status_id`,
    `project_task`.`task_type_id` as `task_type_id`,
    `project_task`.`task_priority_id` as `task_priority_id`,
    `project_task`.`assignee_employee_id` as `assignee_employee_id`,
    `project_task`.`task_estimated_time` as `task_estimated_time`,
    `project_task`.`task_completion_value` as `task_completion_value`,
    `project_task`.`is_deleted` as `is_deleted`,
    `project_task`.`followers` as `followers`,
    `project_task`.`created_by` as `created_by`,
    `project_task`.`created_on` as `created_on`,
    `project_task`.`modified_by` as `modified_by`,
    `project_task`.`modified_on` as `modified_on`,
    `project_task`.`deleted_by` as `deleted_by`,
    `project_task`.`deleted_on` as `deleted_on`,
    `task_type`.`task_type` as `task_type`,
    `task_status`.`task_status_type` as `task_status_type`,
    `task_priority`.`task_priority_type` as `task_priority_type`,
    `project`.`project_name` as `project_name`,
    `project`.`is_deleted` as `project_is_deleted`
   
from
    (((((`pms_project_task` `project_task`
left join `pms_mst_task_type` `task_type` on
    ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
left join `pms_mst_task_status` `task_status` on
    ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
left join `pms_mst_task_priority` `task_priority` on
    ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
join `pms_empoyees` `employee` on
    (((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)
        and (`employee`.`is_deleted` = 0))))
join `pms_projects` `project` on
    (((`project_task`.`project_id` = `project`.`project_id`)
        and (`project`.`is_deleted` = 0))));     
        
--------------------------------------------------------------------------------------------------------------
--15-08-2023 by akshay

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_temp_table_emp_performance_sp`(
IN inp_company_id INT
)
BEGIN
    DECLARE outer_value INT;
    DECLARE inner_value INT;
    DECLARE status_cnt int;
    DECLARE tsk_status  VARCHAR(255);
    DECLARE cur_status  VARCHAR(255);
    DECLARE tsk_statusType INT;
    DECLARE cur_statusType INT;
    DECLARE tsk_priority  VARCHAR(255);
    DECLARE tsk_priorityType  INT;
    DECLARE col_name VARCHAR(100);
    DECLARE indexs INT DEFAULT 0;
    DECLARE temp_index INT DEFAULT 1;
  	DECLARE temp_status  VARCHAR(255);
    
    DECLARE outer_done INT DEFAULT FALSE;
    DECLARE inner_done INT DEFAULT FALSE;
    
    DECLARE outer_cursor CURSOR FOR
        SELECT task_priority, task_priority_type  FROM pms_mst_task_priority where company_id = inp_company_id;
        
    DECLARE inner_cursor CURSOR FOR
        SELECT task_status, task_status_type, (select count(*) FROM pms_mst_task_status where company_id = inp_company_id) as status_count FROM pms_mst_task_status where company_id = inp_company_id;
    
  	DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET outer_done = TRUE;
  
     -- Create a dynamic CREATE TABLE query
    SET @create_table_query = 'CREATE TEMPORARY TABLE temp_table_empPerf (temp_id INT AUTO_INCREMENT PRIMARY KEY, employee_id INT, employee_name VARCHAR(255), department_name TEXT,  reporting_to_name TEXT';
   
   OPEN inner_cursor;
  
  		FETCH inner_cursor INTO tsk_status, tsk_statusType, status_cnt;
		           WHILE temp_index < status_cnt DO
		          		FETCH inner_cursor INTO cur_status, cur_statusType, status_cnt;
				        -- Loop logic
		          		IF temp_index = 1 then
		          		  SET @column_name = CONCAT(tsk_status, '_', 'totTasks');
       					  SET @create_table_query = CONCAT(@create_table_query, ', ',REPLACE(REPLACE(@column_name, '-', '_'), ' ', '_'), ' TEXT');
       					END IF;
		          		
		                SET @column_name = CONCAT(cur_status, '_' , 'totTasks');
	       				SET @create_table_query = CONCAT(@create_table_query, ', ', REPLACE(REPLACE(@column_name, '-', '_'), ' ', '_'), ' TEXT');
	       			
	       				IF temp_index = status_cnt - 1 then
		          		  SET @column_name = CONCAT('Total-Tasks-' ,'totTasks');
       					  SET @create_table_query = CONCAT(@create_table_query, ', ', REPLACE(REPLACE(@column_name, '-', '_'), ' ', '_'), ' TEXT');
       					  SET @create_table_query = CONCAT(@create_table_query, ', ', 'Completion_Percent_totTasks', ' VARCHAR(255)');
       					END IF;
		           
				        SET temp_index = temp_index + 1;
				   END WHILE;
  		
  
   CLOSE inner_cursor;

        
    OPEN outer_cursor;
    
    outer_loop: LOOP
        FETCH outer_cursor INTO tsk_priority, tsk_priorityType;
       
        if outer_done then
            leave outer_loop;
        END IF;
        set indexs =1;
       
--         select tsk_priority;
       
        OPEN inner_cursor;
      
-- 		       inner_loop: LOOP
		           
		           FETCH inner_cursor INTO tsk_status, tsk_statusType, status_cnt;
		           WHILE indexs < status_cnt DO
		          		FETCH inner_cursor INTO cur_status, cur_statusType, status_cnt;
				        -- Loop logic
		          		IF indexs = 1 then
		          		  SET @column_name = CONCAT(tsk_status, '_', tsk_priority);
       					  SET @create_table_query = CONCAT(@create_table_query, ', ',REPLACE(REPLACE(@column_name, '-', '_'), ' ', '_'), ' VARCHAR(255)');
       					END IF;
		          		
		                SET @column_name = CONCAT(cur_status, '_' , tsk_priority);
	       				SET @create_table_query = CONCAT(@create_table_query, ', ',REPLACE(REPLACE(@column_name, '-', '_'), ' ', '_'), ' VARCHAR(255)');
	       			
	       				IF indexs = status_cnt - 1 then
		          		  SET @column_name = CONCAT('Total-Tasks-', tsk_priority);
       					  SET @create_table_query = CONCAT(@create_table_query, ', ',REPLACE(REPLACE(@column_name, '-', '_'), ' ', '_'), ' VARCHAR(255)');
       					  SET @create_table_query = CONCAT(@create_table_query, ', ',REPLACE(REPLACE(CONCAT('Completion_Percent_', tsk_priority), '-', '_'), ' ', '_'), ' VARCHAR(255)');
       					END IF;
		           
				        SET indexs = indexs + 1;
				   END WHILE;
		    		
		        -- Your inner loop logic here using outer_value and inner_value
		            
		          
		        	
-- 		        END LOOP inner_loop;
               
        CLOSE inner_cursor;
        
    END LOOP outer_loop;
   
   SET @create_table_query = CONCAT(@create_table_query, ');');
		    
  			-- Drop the temporary table
    		DROP TEMPORARY TABLE IF EXISTS temp_table_empPerf;
    	
		    -- Prepare and execute the CREATE TABLE statement
		    PREPARE stmt FROM @create_table_query;
		    EXECUTE stmt;
		    DEALLOCATE PREPARE stmt;
    
    CLOSE outer_cursor;
     -- Print the contents of the temporary table
--     SELECT * FROM temp_table_empPerf;
    
END;


-----------------------------------------------------------------------------------------------------------------------

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_emp_performance_sp`(
    IN start_date DATE,
    IN end_date DATE,
    IN inp_company_id INT,
    IN inp_employee_id INT,
    IN inp_project_id INT
   
)
begin
	DECLARE priority_done INT DEFAULT FALSE;
	DECLARE status_done INT DEFAULT FALSE;
	DECLARE done INT DEFAULT FALSE;
	DECLARE doneEmpPerf INT DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(255);
    DECLARE dept_name TEXT;
    DECLARE reporting_name VARCHAR(255);
   
    DECLARE tsk_priority VARCHAR(255);
    DECLARE tsk_priorityType VARCHAR(255);
    DECLARE tsk_status VARCHAR(255);
    DECLARE i INT DEFAULT 0;
    declare empTotalTsks INT DEFAULT 0;  
	declare empCompTsks INT DEFAULT 0;
    DECLARE completionPercentResult DECIMAL(20, 2);
   
    DECLARE empPriWiTotalTsks INT DEFAULT 0; 
	DECLARE empPriWiCompTsks INT DEFAULT 0; 
	DECLARE completionPercentResultPriWi DECIMAL(20, 2);
   
--    Declare variables for employee perf rsults
    DECLARE employeeName VARCHAR(255);
    DECLARE deptName VARCHAR(255);
    DECLARE reportingToName VARCHAR(255);
	DECLARE taskStatusId VARCHAR(255);
	DECLARE taskStatus VARCHAR(255);
	DECLARE taskPriority VARCHAR(255);
	declare	taskPriorityId VARCHAR(255);
	declare taskStatusType VARCHAR(255);
	DECLARE	taskPriorityType VARCHAR(255);
	DECLARE	totalTasks VARCHAR(255);

    DECLARE rowCount INT;
    DECLARE projEmpChkRowCount INT;
   
  

     -- Declare a cursor to select task priority list
    DECLARE task_priority_cursor CURSOR FOR
        SELECT task_priority, task_priority_type  FROM pms_mst_task_priority where company_id = inp_company_id;  
   
    -- Declare a cursor to select task status list  
    DECLARE task_status_cursor CURSOR FOR
        SELECT task_status FROM pms_mst_task_status where company_id = inp_company_id;
   
   -- Declare a cursor to select employees
    DECLARE employees_cursor CURSOR FOR
        SELECT employee_id, employee_name, department_name, reporting_to_name
        FROM employee_info_view where company_id = inp_company_id;
     
    
    -- Declare continue handler for the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;
       
      -- Call the procedure to create the temporary table
    CALL create_temp_table_emp_performance_sp(inp_company_id);
	
	   -- Open the cursor
    OPEN employees_cursor;

    read_loop: LOOP
        -- Fetch data from the cursor into variables
        FETCH employees_cursor INTO emp_id, emp_name, dept_name, reporting_name;
        

        -- Exit the loop if no more rows
        IF done THEN
            LEAVE read_loop;
        END IF;
       
       
	        IF inp_project_id != 0 then
		    		projEmpChk:BEGIN
			        	 DECLARE projEmpChk_cursor CURSOR FOR
				             SELECT employee_id FROM project_employee_info_view where company_id = inp_company_id and employee_id = emp_id
				                 and project_id = inp_project_id;
			             OPEN projEmpChk_cursor;   
				             SET projEmpChkRowCount = FOUND_ROWS();
				            
				             IF projEmpChkRowCount = 0 then
				                iterate read_loop;
							 END IF;
						close projEmpChk_cursor;	
					 end projEmpChk;
	
	        END IF;
       
        IF inp_employee_id != 0 THEN
            set emp_id = inp_employee_id;
        END IF;
        -- Your loop body logic here
      
		--  SELECT emp_id, emp_name;
       		 BLOCK2: BEGIN
	   		 DECLARE emp_perf_resp_cursor CURSOR FOR
				        SELECT employee_name,
				        department_name,
				        reporting_to_name,
				        task_status_id,
				        task_status,
				        task_priority,
				        task_priority_id,
				        task_status_type,
				        task_priority_type,
				        COUNT(task_id) AS total_tasks
				   
				    FROM pms_project_task_info_view
				    WHERE
				        is_deleted = 0
				        AND task_start_date BETWEEN start_date AND end_date
				        AND company_id = inp_company_id
				        AND assignee_employee_id = emp_id 
				        AND (project_id = inp_project_id OR inp_project_id = 0)
				    GROUP BY task_status_id
				    ORDER BY task_status_id;
				    set i = 0;
				    set @columnNames = 'employee_id, employee_name, department_name, reporting_to_name'; 
					set @columnValues = '';
				   
				            BLOCK3:begin
					            -- Declare continue handler for the emp_perf_resp_cursor
									DECLARE CONTINUE HANDLER FOR NOT FOUND
									SET doneEmpPerf = TRUE; 
								
						  -- Open the inner cursor
					        OPEN emp_perf_resp_cursor;
					        	
					         -- Check the number of rows using FOUND_ROWS()
    							SET rowCount = FOUND_ROWS();
					
					        -- Loop through the inner cursor
					        inner_loop: LOOP
						            FETCH emp_perf_resp_cursor INTO employeeName, deptName, reportingToName,
						           		taskStatusId, taskStatus, taskPriority, taskPriorityId, taskStatusType, taskPriorityType, totalTasks;
					
						            -- Exit the inner loop if there are no more rows
						            IF doneEmpPerf then
						            	set doneEmpPerf = false;
						                LEAVE inner_loop;
						            END IF;
					           
-- 					           		   SELECT employeeName, taskStatus;
						            IF taskStatusType = 7 THEN
						          	  set empCompTsks = empCompTsks + totalTasks;
								    END IF;
								   
								   set empTotalTsks = empTotalTsks + totalTasks;
					           		  
						            IF i = 0 then
						              set @columnValues = CONCAT(@columnValues,  emp_id);
						          	  set @columnValues = CONCAT(@columnValues, ', ', QUOTE(employeeName));
						          	  set @columnValues = CONCAT(@columnValues, ', ', QUOTE(deptName));
						              set @columnValues = CONCAT(@columnValues, ', ', QUOTE(reportingToName));
								    END IF; 
									 
								    set @createColName = concat(REPLACE(REPLACE(taskStatus, '-', '_'), ' ', '_'), '_totTasks'); 
							        set @columnNames = CONCAT(@columnNames, ', ', @createColName);
							        set @columnValues = CONCAT(@columnValues, ', ', totalTasks);
							       
							        set @createColName = concat(REPLACE(REPLACE(taskStatus, '-', '_'), ' ', '_'), '_', taskPriority);
							        set @columnNames = CONCAT(@columnNames, ', ', @createColName);
							        set @columnValues = CONCAT(@columnValues, ', ', totalTasks);
					           		  
					        		set i = i + 1;         
					
					        END LOOP inner_loop;
					        CLOSE emp_perf_resp_cursor; 
				            END BLOCK3;
				           
				           
			                IF rowCount = 0  then
-- 				                select rowCount;
			                   set @columnValues = CONCAT(@columnValues,  emp_id);
					           set @columnValues = CONCAT(@columnValues, ', ', QUOTE(emp_name));
					           set @columnValues = CONCAT(@columnValues, ', ', QUOTE(dept_name));
						       set @columnValues = CONCAT(@columnValues, ', ', QUOTE(reporting_name));
				    	    END IF;

					     -- Check if divisor is not zero to avoid division by zero error
   							IF empTotalTsks <> 0 THEN
					        	SET completionPercentResult = empCompTsks / empTotalTsks * 100;
					        ELSE
						        SET completionPercentResult = 0.00;
						    END IF;
						    
						    
				            BLOCK4: BEGIN
					        
					        DECLARE CONTINUE HANDLER FOR NOT FOUND SET priority_done = TRUE;
					        OPEN task_priority_cursor; 
					        task_priority_loop: LOOP
					        FETCH FROM task_priority_cursor INTO tsk_priority, tsk_priorityType;   
					            IF priority_done THEN
						            set priority_done = false;
						            LEAVE task_priority_loop;   
					            END IF; 
					           
-- 					            select tsk_priority;
					           
					                  INNER_BLOCK4: begin
						                  			DECLARE doneEmpPerfINRBL4 INT DEFAULT FALSE;
						                  		   -- Declare continue handler for the emp_perf_resp_cursor
													DECLARE CONTINUE HANDLER FOR NOT FOUND
													SET doneEmpPerfINRBL4 = TRUE; 
													
													-- Open the inner cursor
					    						    OPEN emp_perf_resp_cursor;
					    						   		 -- Loop through the inner cursor
					        								inner_loop: loop
						        								   FETCH emp_perf_resp_cursor INTO employeeName, deptName, reportingToName,
						           											taskStatusId, taskStatus, taskPriority, taskPriorityId, taskStatusType, taskPriorityType, totalTasks ;
						        								
						           								 -- Exit the inner loop if there are no more rows
														            IF doneEmpPerfINRBL4 then
														            	set doneEmpPerfINRBL4 = false;
														                LEAVE inner_loop;
														            END IF;
														            
														           IF tsk_priority = taskPriority then
														            	 set empPriWiTotalTsks = empPriWiTotalTsks + totalTasks;
														                 IF taskStatusType = 7 then
														                    set empPriWiCompTsks = empPriWiCompTsks + totalTasks;
														                 END IF; 
														           END IF; 
														             
					        									
					        								END LOOP inner_loop;
					        								
					    						    
					    						    CLOSE emp_perf_resp_cursor; 
						               
						              END INNER_BLOCK4; 
						             
						              set @createColName =  concat('Total_Tasks_', REPLACE(REPLACE(tsk_priority, '-', '_'), ' ', '_'));
						              set @columnNames = CONCAT(@columnNames, ', ', @createColName);
					        		  set @columnValues = CONCAT(@columnValues, ', ', empPriWiTotalTsks);
					        		 
					        		   -- Check if divisor is not zero to avoid division by zero error
		   							  IF empPriWiTotalTsks <> 0 THEN
							        	 SET completionPercentResultPriWi = empPriWiCompTsks / empPriWiTotalTsks * 100;
							          ELSE
								         SET completionPercentResultPriWi = 0.00;
								      END IF;
					        		 
								      set @createColName =  concat('Completion_Percent_', REPLACE(REPLACE(tsk_priority, '-', '_'), ' ', '_'));
								      set @columnNames = CONCAT(@columnNames,', ', @createColName);
					        		  set @columnValues = CONCAT(@columnValues, ', ', completionPercentResultPriWi);
					        		  
					        		 -- 	reinitialize variable from priority
						              set completionPercentResultPriWi = 0.00;
							          set empPriWiTotalTsks = 0; 
									  set empPriWiCompTsks = 0;    
							 
					        END LOOP task_priority_loop;
					        CLOSE task_priority_cursor;
					        END BLOCK4;
						   
						   
					        set @columnNames = CONCAT(@columnNames,' , ', 'Total_Tasks_totTasks');
					        set @columnValues = CONCAT(@columnValues, ' , ',  empTotalTsks);
					       
					        set @columnNames = CONCAT(@columnNames,' , ', 'Completion_Percent_totTasks');
					        set @columnValues = CONCAT(@columnValues, ' , ', completionPercentResult);
					       
					        SET @tempTbInsertquery = CONCAT('INSERT INTO temp_table_empPerf ', ' (', @columnNames, ') VALUES (', @columnValues, ')');   
							
-- 							select @tempTbInsertquery;
					        -- exeution of insert query  	
				            PREPARE stmt FROM @tempTbInsertquery;
					        EXECUTE stmt;
					        DEALLOCATE PREPARE stmt;
					       
						-- 	reinitialize variables of emp_cur
							set empTotalTsks = 0;  
					        set empCompTsks = 0;
					        SET completionPercentResult = 0.00;
				   
					END BLOCK2;
				    
                    		       
	   
	    IF inp_employee_id != 0 THEN
            LEAVE read_loop;
        END IF;

    END LOOP;

    -- Close the cursor
    CLOSE employees_cursor;   
   
	 -- Use the data from the temporary table
	    SELECT * FROM temp_table_empPerf;  
	   
	  
   
END;

----------------------------------------------------------------------------------------------------------
-- pmsdakshabhi_qa.pms_project_task_info_view source

create or replace
algorithm = UNDEFINED view `pms_project_task_info_view` as
select
    `employee`.`employee_name` as `employee_name`,
    `project_task`.`task_name` as `task_name`,
    `task_status`.`task_status` as `task_status`,
    `task_priority`.`task_priority` as `task_priority`,
    `project_task`.`task_start_date` as `task_start_date`,
    `project_task`.`task_due_dateTime` as `task_due_dateTime`,
    (case
        when (`task_status`.`task_status` <> 'Closed') then concat(timestampdiff(day, `project_task`.`task_due_dateTime`, now()), ' days ', timediff(now(), `project_task`.`task_due_dateTime`))
        else '0'
    end) as `delay`,
    `project_task`.`task_due_date` as `task_due_date`,
    `project_task`.`task_id` as `task_id`,
    `project_task`.`company_id` as `company_id`,
    `project_task`.`project_id` as `project_id`,
    `project_task`.`task_description` as `task_description`,
    `project_task`.`task_status_id` as `task_status_id`,
    `project_task`.`task_type_id` as `task_type_id`,
    `project_task`.`task_priority_id` as `task_priority_id`,
    `project_task`.`assignee_employee_id` as `assignee_employee_id`,
    `project_task`.`task_estimated_time` as `task_estimated_time`,
    `project_task`.`task_completion_value` as `task_completion_value`,
    `project_task`.`is_deleted` as `is_deleted`,
    `project_task`.`followers` as `followers`,
    `project_task`.`created_by` as `created_by`,
    `project_task`.`created_on` as `created_on`,
    `project_task`.`modified_by` as `modified_by`,
    `project_task`.`modified_on` as `modified_on`,
    `project_task`.`deleted_by` as `deleted_by`,
    `project_task`.`deleted_on` as `deleted_on`,
    `task_type`.`task_type` as `task_type`,
    `task_status`.`task_status_type` as `task_status_type`,
    `task_priority`.`task_priority_type` as `task_priority_type`,
    `project`.`project_name` as `project_name`,
    `project`.`is_deleted` as `project_is_deleted`,
    `employee`.`department_id` as `department_id`,
    `employee`.`department_name` as `department_name`,
    `employee`.`reporting_to_name` as `reporting_to_name`
from
    (((((`pms_project_task` `project_task`
left join `pms_mst_task_type` `task_type` on
    ((`project_task`.`task_type_id` = `task_type`.`task_type_id`)))
left join `pms_mst_task_status` `task_status` on
    ((`project_task`.`task_status_id` = `task_status`.`task_status_id`)))
left join `pms_mst_task_priority` `task_priority` on
    ((`project_task`.`task_priority_id` = `task_priority`.`task_priority_id`)))
join `employee_info_view` `employee` on
    (((`project_task`.`assignee_employee_id` = `employee`.`employee_id`)
        and (`employee`.`is_deleted` = 0))))
join `pms_projects` `project` on
    (((`project_task`.`project_id` = `project`.`project_id`)
        and (`project`.`is_deleted` = 0))));


-------Alter table pms_companies for add column from_login and to_login ,time_zone
      
ALTER TABLE  pmsdakshabhi_qa.pms_companies
ADD from_login varchar(255) NOT NULL DEFAULT "09:00 am";

ALTER TABLE  pmsdakshabhi_qa.pms_companies
ADD to_login varchar(255) NOT NULL DEFAULT "07:00 pm";

ALTER TABLE  pmsdakshabhi_qa.pms_companies
ADD time_zone varchar(45) NOT NULL DEFAULT '+0530';

ALTER TABLE  pmsdakshabhi_qa.pms_companies
ADD isToggleOn varchar(45) NOT NULL DEFAULT 'no';


----------create table pms_dakshabhi_mail_details ------------------

CREATE TABLE `pms_dakshabhi_mail_details` (
  `pkid` int(11) NOT NULL AUTO_INCREMENT,
  `from_Email` varchar(255) DEFAULT NULL,
  `to_Email` varchar(255) DEFAULT NULL,
  `email_Subject` varchar(255) DEFAULT NULL,
  `email_body` text DEFAULT NULL,
  `from_name` varchar(45) DEFAULT NULL,
  `to_name` varchar(45) DEFAULT NULL,
  `send_date` DATE DEFAULT NULL,
  PRIMARY KEY (`pkid`)
)

INSERT INTO `pms_dakshabhi_mail_details` VALUES (1,'diptinarkhede03456@gmail.com','pmsdakshabhi@gmail.com','Re: This msg for test subject...','<div dir=\"ltr\">It is done.....</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Tue, 19 Sept 2023 at 18:01, Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','Dipti Narkhede','Dipti','2023-09-19'),(2,'diptinarkhede03456@gmail.com','pmsdakshabhi@gmail.com','Re: This msg for test subject...','<div dir=\"ltr\">It is done.....</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Tue, 19 Sept 2023 at 18:01, Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','Dipti Narkhede','Dipti','2023-09-19'),(3,'nayab.shivanjali123@gmail.com','pmsdakshabhi@gmail.com','Re: This msg for test subject...','<div dir=\"ltr\">Its done ...</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Tue, Sep 19, 2023 at 6:03 PM Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','Shivanjali Nayab','Dipti','2023-09-19'),(4,'vishalbari83706@gmail.com','pmsdakshabhi@gmail.com','Re: subject.....','<div dir=\"auto\">It&#39;s done...</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Tue, Sep 19, 2023, 6:05 PM Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','Vishal Bari','Dipti','2023-09-19'),(5,'nayab.shivanjali123@gmail.com','pmsdakshabhi@gmail.com','Re: subject..','<div dir=\"ltr\">It done..</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Wed, Sep 20, 2023 at 11:05 AM Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','Shivanjali Nayab','Dipti','2023-09-20'),(6,'nayab.shivanjali123@gmail.com','pmsdakshabhi@gmail.com','Re: subject..','<div dir=\"ltr\">It done..</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Wed, Sep 20, 2023 at 11:05 AM Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','Shivanjali Nayab','Dipti','2023-09-20'),(7,'diptinarkhede03456@gmail.com','pmsdakshabhi@gmail.com','Re: this message for subject...','<div dir=\"ltr\">okk done..</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Wed, 20 Sept 2023 at 13:20, Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','Dipti Narkhede','Dipti','2023-09-20'),(8,'ujjwala.gurav114@gmail.com','pmsdakshabhi@gmail.com','Re: This msg for test subject .','<div dir=\"ltr\">done</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Wed, 20 Sept 2023 at 16:45, Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','ujjwala gurav','Dipti','2023-09-20'),(9,'nayab.shivanjali123@gmail.com','pmsdakshabhi@gmail.com','Re: Test subject...','<div dir=\"ltr\">Its done...</div><br><div class=\"gmail_quote\"><div dir=\"ltr\" class=\"gmail_attr\">On Thu, Sep 21, 2023 at 12:14 PM Dipti &lt;<a href=\"mailto:pmsdakshabhi@gmail.com\">pmsdakshabhi@gmail.com</a>&gt; wrote:<br></div><blockquote class=\"gmail_quote\" style=\"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex\"><div dir=\"ltr\"><br></div>\r\n</blockquote></div>\r\n','Shivanjali Nayab','Dipti','2023-09-21');


-------Alter project_employee_info_view --------------------

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `project_employee_info_view` AS
    SELECT 
        `projemp`.`project_employee_id` AS `project_employee_id`,
        `projemp`.`company_id` AS `company_id`,
        `projemp`.`project_id` AS `project_id`,
        `projemp`.`employee_id` AS `employee_id`,
        `employees`.`department_id` AS `department_id`,
        `employees`.`is_active` AS `is_active`,
        `projemp`.`date_added` AS `date_added`,
        `projemp`.`is_deleted` AS `is_deleted`,
        `projects`.`project_name` AS `project_name`,
        `employees`.`employee_name` AS `employee_name`,
        `employees`.`employee_email` AS `employee_email`,
        `department`.`department_name` AS `department_name`,
        `employeerole`.`employe_role_name` AS `employe_role_name`,
        `employees`.`profile_photo` AS `profile_photo`
    FROM
        ((((`pms_project_employee` `projemp`
        LEFT JOIN `pms_projects` `projects` ON (`projemp`.`project_id` = `projects`.`project_id`))
        LEFT JOIN `pms_empoyees` `employees` ON (`projemp`.`employee_id` = `employees`.`employee_id`))
        LEFT JOIN `pms_mst_department` `department` ON (`employees`.`department_id` = `department`.`department_id`))
        LEFT JOIN `pms_mst_employee_role` `employeerole` ON (`employees`.`employee_role` = `employeerole`.`employee_role_id`))
        
        
        
        
  -----------27-09-2023 Alter table  pankaj changes in master.jsp page  -------------  
  
  pms_mst_employee_status (table)
  
  ALTER TABLE pms_mst_employee_status ADD employe_role_desc VARCHAR(255) AFTER employee_status_name
  
              ------------
              
  pms_mst_project_status (table)

ALTER TABLE pms_mst_project_status ADD project_role_desc VARCHAR(255) AFTER project_status  
  
           -----------------
           
pms_mst_task_status (table)

ALTER TABLE pms_mst_task_status ADD task_role_desc VARCHAR(255) AFTER task_status_type;

------------------------------------------------------------------------



  
  -----------12-10-2023 by vishal changes in pms_dakshabhi_mail_details  -------------  
  
 ALTER TABLE  pms_dakshabhi_mail_details
  ADD COLUMN `is_deleted` int(1) default '0';
          

