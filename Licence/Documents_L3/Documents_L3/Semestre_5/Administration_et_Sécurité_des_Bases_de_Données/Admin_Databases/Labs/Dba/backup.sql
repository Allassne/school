-- Run a Full backup of dbaUtilities
EXECUTE dba.dbo.DatabaseBackup
@Databases = 'dba',
@Directory = 'C:\Dba\Backup',
@BackupType = 'FULL',
@Compress = 'Y'
GO
-- Wait 5 Seconds
WAITFOR DELAY '00:00:05'
-- Run a Tlog backup of dbaUtilities
EXECUTE dba.dbo.DatabaseBackup
@Databases = 'dba',
@Directory = 'C:\Dba\Backup',
@BackupType = 'LOG',
@Compress = 'Y'
GO