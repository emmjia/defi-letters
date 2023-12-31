SELECT 

	--SHAW Transaction Data
	 SUBSTRING(A.F0132_CROSS_KEY,1,7)'account'
	,A.R_TR_TR_AC_CODE'ac_code'
	,A.R_TR_DESC'desc'
	,CONVERT(DATE, A.R_TR_EFF_DTE)'date'
	,A.R_TR_PRIN'principle'
	,A.R_TR_INT'interest'
	,A.R_TR_MISC'misc'
	,A.R_TR_TOTAL_AMT'amount'
	,A.R_TR_OLD_BAL'balance'
	--REMARKETING DATA
	,B.F1190_SOLD_AMOUNT'proceeds'
	,B.F5075_AUCTION_SALE_FEES'sale fee'
	,B.F5079_AUCTION_KEY_FEES'key fees'
	,B.F5078_AUCTION_TRANSPORT_FEES'transport fee'
	,B.F5022_AUCTION_OTHER_FEES'auction other fee'
	,B.F5080_AUCTION_REPAIR_FEES'auction repair fees'
	,B.F5059_AUCTION_RECONDITION_FEES'recondition fee'
	--Overpmt Info
	,C.F0268_OVER_PAYMENT_AMOUNT'Overpayment'
	,D.PMTAMT'Check Issued'
	--General Customer/Loan/Vehichle Data
	,right(C.F0003_ACCOUNT, 17) 'Account'
	,C.F0157_NOTE_DATE 'note date'
	,B.F1037_SOLD_DATE'sold date'
	,C.F0120_BORROWER_NAME 'name'
	,C.F0122_BORROWER_ADDRESS_1 'address'
	,C.F0124_BORROWER_CITY 'city'
	,C.F0125_BORROWER_STATE 'state'
	,C.F0126_BORROWER_ZIP 'Zip'
	,C.F0376_MODEL_YEAR'year'
	,C.F0696_MAKE_DESCRIPTION'make'
	,C.F0697_MODEL_DESCRIPTION'model'
	,C.F0212_VIN 'vin'

	
FROM 

	SHAW_HISTORY.DBO.DWR_RETAIL_TRAN_HISTORY A
	LEFT JOIN [SHAW_EOD].[dbo].[DWR_REMARKETING] B ON A.F0132_CROSS_KEY = B.F0132_CROSS_KEY
--testing area tables
	LEFT JOIN SHAW_EOD.DBO.DWR_RETAIL C ON A.F0132_CROSS_KEY = C.F0132_CROSS_KEY
	LEFT JOIN live_mas500_app.dbo.vdvVoucherAppl D ON LEFT(A.F0132_CROSS_KEY, 7) = RIGHT(D.VendID, 7)

WHERE 
	
	SUBSTRING(A.F0132_CROSS_KEY, 1,7) IN ('1582254',
'1614311',
'1615224')

	AND A.R_TR_DESC NOT IN ('NULL','****','DDIS','UGAP','WPAY','DRSV','DCRV','ADIS','GPSR'
	)

	AND A.R_TR_TR_AC_CODE NOT IN ('46-6','46-R','40-R','40-A','41-3','31-5')

ORDER BY
	 A.F0132_CROSS_KEY
	,A.R_TR_EFF_DTE DESC
