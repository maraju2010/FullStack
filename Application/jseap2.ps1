$computername = 'MANORAJU1-3D4NH'
$userId = $env:UserName
$url = 'http://localhost:8888'
$postParams = @{Account=$userId;Machine=$computername} | ConvertTo-Json -Compress


function Failure($attempt){
try {
$r  = Invoke-WebRequest -UseBasicParsing $url -ContentType "application/json" -Method POST -Body $postParams -TimeoutSec 180 -ErrorAction:Stop

$p=$r.RawContent -replace "`n",''
Write-Host "data returned: $p"
} catch {
	Write-Host "exception occured while connecting to middleware on attempt $attempt"
	Start-Sleep -s 30
	
	
}
}

try {
$r  = Invoke-WebRequest -UseBasicParsing $url -ContentType "application/json" -Method POST -Body $postParams -TimeoutSec 180 -ErrorAction:Stop

$p=$r.RawContent -replace "`n",''
Write-Host "data returned: $p"
} catch {
	Write-Host "exception occured while connecting to middleware on attempt 1"
	Start-Sleep -s 30
	Failure "2"
	Start-Sleep -s 60
	Failure "3"
	Start-Sleep -s 120
	Failure "4"
	Start-Sleep -s 240
	Failure "5"
	Start-Sleep -s 480
	Failure "6"
	
}