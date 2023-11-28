DECLARE
   v_ws_id        apex_workspaces.workspace_id%TYPE; -- Workspace ID
   v_app_id       NUMBER := 177; --  APEX application ID
   v_session_id   NUMBER := 15685783007363; -- APEX application session ID
BEGIN
   SELECT MAX (workspace_id)
     INTO v_ws_id
     FROM apex_applications
    WHERE application_id = v_app_id;

   -- Set Workspace ID
   wwv_flow_api.set_security_group_id (v_ws_id);

   -- Set Application ID
   APEX_APPLICATION.g_flow_id := v_app_id;

   -- Set Session ID
   APEX_APPLICATION.g_instance := v_session_id;
END;


SELECT *
  FROM apex_collections
 WHERE collection_name = 'TEST';
