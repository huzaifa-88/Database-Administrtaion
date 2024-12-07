DELETE FROM ADDRESS;

INSERT INTO ADDRESS(addressid, street, city, province, postalcode, employeeid)
SELECT DISTINCT addressid, street, city, province, postalcode, employeeid
FROM ZZZ_DIRECTORY
WHERE addressid IS NOT NULL
  AND street IS NOT NULL
  AND city IS NOT NULL
  AND province IS NOT NULL
  AND postalcode IS NOT NULL;

INSERT INTO ADDRESS(addressid, street, city, province, postalcode, customerid)
SELECT DISTINCT addressid, street, city, province, postalcode, customerid
FROM ZZZ_SALES
WHERE addressid IS NOT NULL
  AND street IS NOT NULL
  AND city IS NOT NULL
  AND province IS NOT NULL
  AND postalcode IS NOT NULL;
  
--when run this query in SQLPLUS commit is neccessary
commit;