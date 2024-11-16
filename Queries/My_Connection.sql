SELECT 
    G.firstname, 
    G.lastname, 
    Ft.feetypename, 
    F.datecharged, 
    F.feecharged, 
    TOTAL.TOTALFEE
FROM 
    Guest G
JOIN 
    Fee F ON G.guestid = F.guestid
JOIN 
    Fee_type Ft ON F.feetypeid = Ft.feetypeid
JOIN 
    (
        SELECT guestid, SUM(feecharged) AS TOTALFEE
        FROM Fee
        GROUP BY guestid
    ) TOTAL ON G.guestid = TOTAL.guestid;

