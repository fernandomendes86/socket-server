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

        $client = $listener.AcceptTcpClient()
        $stream = $client.GetStream()
        $buffer = New-Object byte[] 1024
        $bytes = $stream.Read($buffer, 0, $buffer.Length)

        if ($bytes -gt 0)
        {
            $recebido = [System.Text.Encoding]::ASCII.GetString($buffer, 0, $bytes)
            $recebido = [Regex]::Replace($recebido, "\r?\n", "")
            if (-not $recebido.Trim()) { break }

            Write-Host "Recebido: $recebido"

            $dados = [System.Text.Encoding]::ASCII.GetBytes($Resposta)
            $stream.Write($dados, 0, $dados.Length)
            Write-Host "Resposta: $Resposta`n"
        }

        $stream.Close()
        $client.Close()
    }
}
catch {
    Write-Host "Ocorreu um erro: $_"
}
finally {
    $listener.Stop()
    Write-Host "`nServidor parado com sucesso."
}