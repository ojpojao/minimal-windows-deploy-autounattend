Start-Transcript -Path C:\setup-log.txt -Force

Write-Host "===== INICIANDO SETUP ====="

# Aguarda rede estabilizar
Write-Host "Aguardando rede..."
Start-Sleep 30

# Habilitar RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0 -Force

netsh advfirewall firewall add rule name="RDP" protocol=TCP dir=in localport=3389 action=allow

# Desabilitar Telemetria
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Force | Out-Null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Value 0 -Force

# Compartilhamento e ICMP
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'everyoneincludesanonymous' -Value 1 -Force
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'restrictnullsessaccess' -Value 0 -Force

## Desativar compartilhamento protegido por senha
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name 'limitblankpassworduse' -Value 0 -Force

## Ativar compartilhamento de pasta publica (NullSessionShares é REG_MULTI_SZ)
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'NullSessionShares' -Value @('public') -Force

## Firewall
netsh advfirewall firewall add rule name="ICMP Allow" protocol=icmpv4:8, any dir=in action=allow
netsh advfirewall firewall set rule group="Compartilhamento de Arquivo e Impressora" new enable=yes
Write-Host "Compartilhamento, pasta publica e ICMP habilitados"

# Remover Bloatware
$apps = @(
    'Microsoft.XboxApp',
    'Microsoft.XboxGameOverlay',
    'Microsoft.XboxGamingOverlay',
    'Microsoft.XboxIdentityProvider',
    'Microsoft.XboxSpeechToTextOverlay',
    'king.com.CandyCrushSaga',
    'king.com.CandyCrushFriends',
    'Microsoft.BingWeather',
    'Microsoft.BingNews',
    'Microsoft.GetHelp',
    'Microsoft.Getstarted',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.People',
    'Microsoft.SkypeApp',
    'Microsoft.ZuneMusic',
    'Microsoft.ZuneVideo'
)

foreach ($app in $apps) {
    Write-Host "Removendo: $app"
    Get-AppxPackage -Name $app | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online |
    Where-Object DisplayName -eq $app |
    Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

# Instalar Chocolatey
Write-Host "Instalando Chocolatey..."

try {
    [System.Net.ServicePointManager]::SecurityProtocol = 3072
    iex ((New-Object System.Net.WebClient).DownloadString(
            'https://community.chocolatey.org/install.ps1'))
    Write-Host "Chocolatey instalado"
}
catch {
    Write-Host "Erro Chocolatey: $($_.Exception.Message)"
}



Write-Host "Reiniciando..."
Stop-Transcript
Restart-Computer -Force
