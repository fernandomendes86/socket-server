<#
--Subindo o SocketServer--
Exemplo 1:
.\SocketServer.ps1
-Inicia o servidor em 0.0.0.0 (todas as interfaces de rede [MEU_IP_DE_REDE]) na porta padrão e com resposta padrão.

-Para testar uma conexão remota, utilize o Telnet ou o PuTTY (em modo Raw), por exemplo, no telnet:
> telnet MEU_IP_DE_REDE 5000

Exemplo 2:
.\SocketServer.ps1 -Porta 5001
-Inicia o servidor em  0.0.0.0 (todas as interfaces de rede [MEU_IP_DE_REDE]) na porta 5001 e com resposta padrão.

Exemplo 3:
.\SocketServer.ps1 -Ip "127.0.0.1" -Porta 5001 -Resposta "RESPOSTA_DO_TESTE_1234"
-Inicia o servidor localmente na porta 5001 e com resposta personalizada.
#>

param (
    [string]$Ip = "0.0.0.0",
    [int]$Porta = 5000,
    [string]$Resposta = "0000FBIPI9999922"
)

$ipAddress = [System.Net.IPAddress]::Parse($Ip)
$listener = [System.Net.Sockets.TcpListener]::new($ipAddress, $Porta)

try {
    $listener.Start()
    Write-Host "Servidor em ${Ip}:${Porta}"
    Write-Host "Pressione Ctrl+C para parar`n"

    while ($true)
    {
        if (-not $listener.Pending()) {
            Start-Sleep -Milliseconds 100
            continue
        }

        $cliente = $listener.AcceptTcpClient()
        $stream = $cliente.GetStream()
        $buffer = New-Object byte[] 1024
        $bytes = $stream.Read($buffer, 0, $buffer.Length)

        if ($bytes -gt 0)
        {
            $recebido = [System.Text.Encoding]::ASCII.GetString($buffer, 0, $bytes)
            Write-Host "Recebido: $recebido"

            $dados = [System.Text.Encoding]::ASCII.GetBytes($Resposta)
            $stream.Write($dados, 0, $dados.Length)
            
            Write-Host "Resposta: $Resposta"
        }

        $stream.Close()
        $cliente.Close()
    }
}
catch {
    Write-Host "Ocorreu um erro: $_"
}
finally {
    $listener.Stop()
    Write-Host "`nServidor parado com sucesso."
}