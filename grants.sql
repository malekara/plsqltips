SELECT    'GRANT '
       || PRIVILEGE
       || ' ON '
       || OWNER
       || '.'
       || TABLE_NAME
       || ' TO '
       || GRANTEE
       || ' WITH GRANT OPTION;'    GRANT_SQL
  FROM SYS.DBA_TAB_PRIVS A
WHERE GRANTEE = 'TICKET_OWNER'
 --  AND OWNER = 'BUSINESS_OWNER'
   AND TABLE_NAME NOT LIKE '%==$%'
   AND GRANTABLE = 'YES'
UNION
SELECT    'GRANT '
       || PRIVILEGE
       || ' ON '
       || OWNER
       || '.'
       || TABLE_NAME
       || ' TO '
       || GRANTEE
       || ';'    GRANT_SQL
  FROM SYS.DBA_TAB_PRIVS A
WHERE GRANTEE = 'TICKET_OWNER'
   --AND OWNER = 'BUSINESS_OWNER'
   AND TABLE_NAME NOT LIKE '%==$%'
   AND GRANTABLE = 'NO'
