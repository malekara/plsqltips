/* Formatted on 11/15/2023 12:24:19 PM (QP5 v5.374) By Behnam Malekara */
CREATE OR REPLACE PROCEDURE get_shahbaz_key
IS
    soap_request     VARCHAR2 (30000);
    soap_respond     VARCHAR2 (30000);
    http_req         UTL_HTTP.req;
    http_resp        UTL_HTTP.resp;
    obj              json_list;
    v_access_token   VARCHAR2 (4000);
    V_TOTAL          VARCHAR2 (4000);
    V_ID             NUMBER;
BEGIN
    soap_request :=
        'username=RMTO-Org&password=g2]ORY|XQOwLBa4&grant_type=password';

    BEGIN
        UTL_HTTP.set_transfer_timeout (10);

        http_req :=
            UTL_HTTP.begin_request (
                'http://172.30.5.151:9090/shahbaz/login?username=barnameh&password==sys@Barnameh$1400',
                'POST',
                'HTTP/1.1');
    END;

    UTL_HTTP.set_body_charset (http_req, 'UTF-8');
    UTL_HTTP.set_header (http_req,
                         'Content-Type',
                         'application/x-www-form-urlencoded; charset=UTF-8');
    UTL_HTTP.set_header (http_req,
                         'X-Parse-Application-Id',
                         'gaiquieFooveiC1wauraiph5ia3laiy6');
    UTL_HTTP.set_header (http_req, 'X-Parse-Revocable-Session', '1');
    UTL_HTTP.write_text (http_req, soap_request);
    http_resp := UTL_HTTP.get_response (http_req);
    UTL_HTTP.read_text (http_resp, soap_respond);
    UTL_HTTP.end_response (http_resp);
    V_TOTAL := soap_respond;
    soap_respond := '[' || soap_respond || ']';
    BEGIN
        obj := json_list (soap_respond);
    END;

    FOR i IN 1 .. obj.COUNT
    LOOP
        BEGIN
            v_access_token :=
                json_ext.get_string (json (obj.get (i)), 'sessionToken');
        EXCEPTION
            WHEN OTHERS
            THEN
                NULL;
        END;

        DELETE TR_JSON.KEY_SHAHBAZ;

        INSERT INTO TR_JSON.KEY_SHAHBAZ (TOTAL, ACCESS_TOKEN)
             VALUES (soap_respond, v_access_token)
             RETURN ID
               INTO V_ID;

        COMMIT;
    END LOOP;
END;
