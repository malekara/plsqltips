DECLARE
    v_clob CLOB;
    v_offset NUMBER := 1;  -- starting offset
    v_chunk_size NUMBER := 100;  -- size of each chunk

    v_chunk VARCHAR2(4000);

BEGIN
select request_content into v_clob from g4b_tb_license where request_number = 2874634 ;

    -- Loop through the CLOB and print chunks
    WHILE v_offset <= DBMS_LOB.GETLENGTH(v_clob)
    LOOP
        DBMS_LOB.READ(v_clob, v_chunk_size, v_offset, v_chunk);
        htp.p(v_chunk);

        -- Update offset for the next iteration
        v_offset := v_offset + v_chunk_size;
    END LOOP;
END;
