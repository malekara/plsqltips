```
/* Formatted on 10/12/2022 2:46:21 PM (QP5 v5.374) Amin Safizade */
CREATE OR REPLACE PROCEDURE APEX_210200.SEND_MAIL_TST3 (
    P_USERNAME     IN VARCHAR2,
    P_PASSWORD     IN VARCHAR2,
    P_TO           IN VARCHAR2,
    P_FROM         IN VARCHAR2,
    P_MESSAGE      IN VARCHAR2,
    P_SMTP_HOST    IN VARCHAR2,
    P_SMTP_PORT    IN NUMBER DEFAULT 25)
AS
    L_MAIL_CONN      UTL_SMTP.CONNECTION;
    V_USERNAME_B64   VARCHAR2 (1000);
    V_PASSWORD_B64   VARCHAR2 (1000);
    MSG              VARCHAR2 (4000);
BEGIN
    V_USERNAME_B64   := --'rightel-CDR@rightel.ir';--utl_encode.text_encode('rightel-cdr','WE8ISO8859P1',UTL_ENCODE.BASE64);
        UTL_RAW.CAST_TO_VARCHAR2 (
            UTL_ENCODE.BASE64_ENCODE (UTL_RAW.CAST_TO_RAW (P_USERNAME)));
    V_PASSWORD_B64   :=                                     --'123456asdZXC$';
        --utl_encode.text_encode('123456asdZXC#','WE8ISO8859P1',UTL_ENCODE.BASE64);
         UTL_RAW.CAST_TO_VARCHAR2 (
            UTL_ENCODE.BASE64_ENCODE (UTL_RAW.CAST_TO_RAW (P_PASSWORD)));
    L_MAIL_CONN   := UTL_SMTP.OPEN_CONNECTION (P_SMTP_HOST, P_SMTP_PORT);
    UTL_SMTP.EHLO (L_MAIL_CONN, P_SMTP_HOST);
    UTL_SMTP.COMMAND (L_MAIL_CONN, 'AUTH', 'LOGIN'); -- should receive a 334 response, prompting for username
    UTL_SMTP.COMMAND (L_MAIL_CONN, V_USERNAME_B64); -- should receive a 334 response, prompting for password
    UTL_SMTP.COMMAND (L_MAIL_CONN, V_PASSWORD_B64); -- should receive a 235 response, you are authenticated

    UTL_SMTP.MAIL (L_MAIL_CONN, P_FROM);
    UTL_SMTP.RCPT (L_MAIL_CONN, P_TO);



    UTL_SMTP.OPEN_DATA (L_MAIL_CONN);

    --UTL_SMTP.WRITE_raw_DATA(c, UTL_RAW.cast_to_raw('Subject: '||REPLACE(utl_encode.MIMEHEADER_ENCODE(Subj, 'utf8'),CHR(13) || CHR(10),'') || utl_tcp.CRLF));
    --UTL_SMTP.WRITE_raw_DATA(c, UTL_RAW.cast_to_raw('Subject: '||REPLACE(utl_encode.MIMEHEADER_ENCODE(Subj, 'utf8'),CHR(13) || CHR(10),'') || utl_tcp.CRLF));
    --UTL_SMTP.WRITE_raw_DATA(c, UTL_RAW.cast_to_raw('Subject: '||REPLACE(utl_encode.MIMEHEADER_ENCODE(Subj, 'utf8'),CHR(13) || CHR(10),'') || utl_tcp.CRLF));

    MSG           :=
           'Content-Type: text/html; charset="windows-1256"'
        || UTL_TCP.CRLF
        || 'Content-Transfer-Encoding: 8bit'
        || UTL_TCP.CRLF
        || 'From'
        || ': '
        || P_FROM
        || UTL_TCP.CRLF
        ||   -- send_header('To', '"Recipient" <h.asad@bankofpalestine.com>');
           'TO'
        || ': '
        || P_TO
        || UTL_TCP.CRLF
        || 'Subject'
        || ': '
        || '3'
        || UTL_TCP.CRLF
        || UTL_TCP.CRLF
        || P_MESSAGE;

    UTL_SMTP.WRITE_RAW_DATA (L_MAIL_CONN, UTL_RAW.CAST_TO_RAW (MSG));
    UTL_SMTP.CLOSE_DATA (L_MAIL_CONN);
    UTL_SMTP.QUIT (L_MAIL_CONN); 
END;

BEGIN
    APEX_210200.SEND_MAIL_TST3 (P_USERNAME    => 'RighTel-CDR',
                                P_PASSWORD    => '123456asdZXC!',
                                P_TO          => 'asfz.8886@gmail.com',
                                P_FROM        => 'Rightel-web@rightel.ir',
                                P_MESSAGE     => 'My Email Body.',
                                P_SMTP_HOST   => 'mail.rightel.ir',
                                P_SMTP_PORT   => 25);
END;

BEGIN
    APEX_MAIL.SEND (P_TO     => 'asfz.8886@gmail.com',
                    P_FROM   => 'Rightel-cdr@rightel.ir',
                    P_BODY   => 'My Email Body.',
                    P_SUBJ   => 'Mail subject');
     APEX_MAIL.PUSH_QUEUE;
END;

BEGIN
    APEX_INSTANCE_ADMIN.VALIDATE_EMAIL_CONFIG;
END;
BEGIN
    APEX_210200.SEND_MAIL_TST3 (P_USERNAME    => 'rightel-cdr',
                                P_PASSWORD    => '123456asdZXC!',
                                P_TO          => 'a.safizadeh@behsacorp.com',
                                P_FROM        => 'Rightel-cdr@rightel.ir',
                                P_MESSAGE     => 'My Email Body.',
                                P_SMTP_HOST   => 'mail.rightel.ir',
                                P_SMTP_PORT   => 25);
END;

BEGIN
   APEX_MAIL.SEND (P_TO     => 'a.safizadeh@behsacorp.com',
                    P_FROM   => 'Rightel-cdr@rightel.ir',
                    P_BODY   => 'My Email Body.',
                    P_SUBJ   => 'Mail subject'); 
     APEX_MAIL.PUSH_QUEUE;
END;
BEGIN
    APEX_INSTANCE_ADMIN.VALIDATE_EMAIL_CONFIG;
END; 

BEGIN 
     APEX_MAIL.PUSH_QUEUE;
END;


SELECT 
ID, TEXTBODY, FILE_CONTENT, 
   FILE_NAME, MIME_TYPE, TEL_NUM, 
   FILE_PK, CDR_PK, CREATED_ON, 
   CREATED_BY, FROM_EMAIL, TO_EMAIL, 
   STATUS, RES_CODE, RES_DESC
FROM TBL_SEND_EMAIL_LOG
where trunc(CREATED_ON)>=to_date('23/9/2022','dd/mm/yyyy');

update TBL_SEND_EMAIL_LOG
set status = 0 
where trunc(CREATED_ON)>=to_date('23/9/2022','dd/mm/yyyy');
```
