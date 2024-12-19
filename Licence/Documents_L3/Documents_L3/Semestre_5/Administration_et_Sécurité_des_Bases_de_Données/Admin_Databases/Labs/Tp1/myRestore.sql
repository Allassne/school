	-- Apply the first transaction log backup. 
RESTORE LOG BDTransact 
	FROM BDtransact_log1
	WITH NORECOVERY;
GO 
	-- Apply the last transaction log backup. 
RESTORE LOG BDTransact 
	FROM BDTransact_log2 
	WITH RECOVERY;
GO