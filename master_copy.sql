insert into pms_mst_customer_type(company_id,customer_type) select 2,customer_type from pms_mst_customer_type where company_id = 1;

insert into pms_mst_department(company_id,department_name) select 2,department_name from pms_mst_department where company_id = 1; 

insert into pms_mst_employee_role(company_id,employe_role_name,employe_role_desc,employee_role_type) select 2,employe_role_name,employe_role_desc,employee_role_type from pms_mst_employee_role where company_id = 1;

insert into pms_mst_employee_status(company_id,employee_status_name) select 2,employee_status_name from pms_mst_employee_status where company_id = 1; 

insert into pms_mst_employee_type(company_id,employee_type_name) select 2,employee_type_name from pms_mst_employee_type where company_id = 1;

insert into pms_mst_project_status(company_id,project_status) select 2,project_status from pms_mst_project_status where company_id = 1;

insert into pms_mst_project_type(company_id,project_type) select 2,project_type from pms_mst_project_type where company_id = 1;

insert into pms_mst_task_activity(company_id,task_activity) select 2,task_activity from pms_mst_task_activity where company_id = 1;

insert into pms_mst_task_priority(company_id,task_priority,task_priority_type) select 2,task_priority,task_priority_type from pms_mst_task_priority where company_id = 1;

insert into pms_mst_task_status(company_id,task_status,task_status_type) select 2,task_status from pms_mst_task_status,task_status_type where company_id = 1;

insert into pms_mst_task_type(company_id,task_type) select 2,task_type from pms_mst_task_type where company_id = 1;