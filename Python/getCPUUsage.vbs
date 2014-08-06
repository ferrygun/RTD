 Option Explicit 
 
 Dim oWsh, oWshSysEnv, objWMIService 
 Dim colItems, objItem 
 Dim  strLineProcessorTime

 ' Added for loop counter
 Dim counter, duration, sleepTime
 
 Set oWsh = WScript.CreateObject("WScript.Shell") 
 Set oWshSysEnv = oWsh.Environment("PROCESS") 
 Set objWMIService = GetObject("winmgmts:\\.\root\CIMV2") 
 
 
 Const ForReading = 1, ForWriting = 2, ForAppending = 8
 
 ' set the time to pause between each loop
 sleepTime = 1000 '1000 Milliseconds to a second
 
 ' set how long it should loop for
 duration = 10 * 1000 'seconds (5 minutes)
 
 For counter = 1 To duration
        strLineProcessorTime = ""

		'Gets Processor Usage 
        Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PerfFormattedData_PerfOS_Processor WHERE Name = '_Total'") 
        For Each objItem In colItems    
                strLineProcessorTime = strLineProcessorTime & " " & objItem.PercentProcessorTime 
        Next 
 
             
        'Send the CPU Information
        oWsh.Run "cmd.exe /S /C C:\Python34\sendCPU.bat " + strLineProcessorTime , 0, true
        

        WScript.Sleep sleepTime
 Next
 
 WScript.Quit 
