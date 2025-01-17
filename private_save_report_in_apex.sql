select  * from apex_application_page_ir s where APPLICATION_ID = 600 and NUMBER_OF_PRIVATE_REPORTS <> 0	;
select  * from apex_application_page_ir_rpt s where APPLICATION_ID = 600;

CREATE TABLE TEMP_apex_application_page_ir_rpt AS
select R.* from apex_application_page_ir_rpt r ,apex_application_page_ir s   where s.REGION_ID	 = r.REGION_ID  and s.APPLICATION_ID = 600  


CREATE TABLE TEMP_apex_application_page_ir AS
select S.* from apex_application_page_ir_rpt r ,apex_application_page_ir s   where s.REGION_ID	 = r.REGION_ID  and s.APPLICATION_ID = 600  


SELECT COUNT(1) FROM apex_application_page_ir R, TEMP_apex_application_page_ir I WHERE I.PAGE_ID = R.PAGE_ID AND R.APPLICATION_ID = I.APPLICATION_ID AND R.NUMBER_OF_COLUMNS = I.NUMBER_OF_COLUMNS AND I.REGION_NAME = R.REGION_NAME


