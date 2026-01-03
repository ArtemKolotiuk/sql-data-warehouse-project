/*
| REPLACE     | What replaces                 |
| ----------- | --------------------------- |
| `CHAR(160)` | NBSP (non-breaking space)   |
| `CHAR(9)`   | tab (`\t`)                  |
| `CHAR(10)`  | LF / line feed (`\n`)       |
| `CHAR(13)`  | CR / carriage return (`\r`) |

*/
SELECT CASE
           WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
           ELSE cid
           END AS cid,
       CASE
           WHEN bdate > GETDATE() THEN NULL
           ELSE bdate
           END AS bdate,
       CASE
           WHEN UPPER(
                        LTRIM(RTRIM(
                                REPLACE(REPLACE(REPLACE(REPLACE(gen, CHAR(160), ''), CHAR(9), ''), CHAR(10),
                                                ''), CHAR(13), '')
                              ))
                ) IN ('F', 'FEMALE') THEN 'Female'

           WHEN UPPER(
                        LTRIM(RTRIM(
                                REPLACE(REPLACE(REPLACE(REPLACE(gen, CHAR(160), ''), CHAR(9), ''), CHAR(10),
                                                ''), CHAR(13), '')
                              ))
                ) IN ('M', 'MALE') THEN 'Male'

           ELSE 'unknown'
           END AS gen
FROM bronze.erp_cust_az12;
