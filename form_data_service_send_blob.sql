DECLARE
       lc_response      clob;
       lm_multipart     apex_web_service.t_multipart_parts;
       ln_email_address VARCHAR2(100) := 'email_adress@email.com';
       lc_json          clob          := '{"hello":"world"}';   
       lv_filename      VARCHAR2(20)  := 'my_file';
       lv_base_url      VARCHAR2(100); -- webservice base URL; 
       lv_api_key       VARCHAR2(100); -- API KEY 
       lb_blob          blob; -- Blob part of the multipart

BEGIN

        apex_web_service.g_request_headers.delete();
        apex_web_service.g_request_headers(1).name  := 'x-api-key';
        apex_web_service.g_request_headers(1).value := lv_api_key;   

        /* add a CLOB (JSON) to a multipart/form request body */
        IF lc_json is not null 
        THEN
        apex_web_service.APPEND_TO_MULTIPART (
                p_multipart    => lm_multipart,
                p_name         => 'json_param',
                p_content_type => 'application/json',
                p_body         => lc_json );
        END IF;

        /* add a plain text to a multipart/form request body */
        IF ln_email_address is not null
        THEN        
        apex_web_service.APPEND_TO_MULTIPART (
                p_multipart    => lm_multipart,
                p_name         => 'email_address',
                p_content_type => 'text/plain',
                p_body         => ln_email_address ); 
        END IF;        

        /*add a BLOB to a multipart/form request body.*/        
        apex_web_service.APPEND_TO_MULTIPART (
                p_multipart    => lm_multipart,
                p_name         => 'filename',
                p_filename     => lv_filename,
                p_content_type => 'application/octet-stream',
                p_body_blob    => lb_blob );

        l_response  := apex_web_service.make_rest_request(
                               p_url => lv_base_url,
                               p_http_method => 'POST',
                               p_body_blob => apex_web_service.generate_request_body(lm_multipart)); 

        -- generate_request_body: This function generates the multipart/form-data request body from the data in the t_multiparts array.

        dbms_output.put_line(l_response);                      

END;
