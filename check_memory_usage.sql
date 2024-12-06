CREATE OR REPLACE FUNCTION get_stat (p_stat IN VARCHAR2) RETURN NUMBER AS
  l_return  NUMBER;
BEGIN
  SELECT ms.value
  INTO   l_return
  FROM   v$mystat ms,
         v$statname sn
  WHERE  ms.statistic# = sn.statistic#
  AND    sn.name = p_stat;
  RETURN l_return;
END get_stat;
/
