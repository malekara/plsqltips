you can access session from database


BEGIN
   apex_session.attach (p_app_id       => 177, --  Application ID
                        p_page_id      => 5, -- Page ID
                        p_session_id   => 19278163964528 -- Session ID
						);
END;


SELECT * FROM apex_collections 
	where collection_name= 'TEST';


SELECT v('P5_ITEM') FROM dual;


begin
    apex_session.detach;
end;
