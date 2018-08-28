--Possible Hash Dump

SELECT mn.MachineName, sfn.Filename, mproc.CreateUTCTime, pa2.Path, la.LaunchArguments

FROM
	[dbo].[mocProcesses] AS [mproc] WITH(NOLOCK)
	INNER JOIN [dbo].[MachineModulePaths] AS [mp] WITH(NOLOCK) ON ([mp].[PK_MachineModulePaths] = [mproc].[FK_MachineModulePaths])
	INNER JOIN [dbo].[FileNames] AS [sfn] WITH(NOLOCK) ON ([sfn].[PK_FileNames] = [mp].[FK_FileNames])
	INNER JOIN [dbo].[machines] AS [mn] WITH(NOLOCK) ON [mn].[PK_Machines] = [mproc].[FK_Machines] 
	INNER JOIN [dbo].LaunchArguments AS [la] WITH(NOLOCK) on [la].PK_LaunchArguments = [mproc].[FK_LaunchArguments]
	INNER JOIN [dbo].[Paths] AS [pa2] WITH(NOLOCK) ON [pa2].[PK_Paths] = [mproc].[FK_Paths__ParentPath]

WHERE
	sfn.FileName = N'rundll32.exe'
	AND (la.LaunchArguments like N'%aclayers.dll%' OR la.LaunchArguments like N'%samcli.dll%')
	