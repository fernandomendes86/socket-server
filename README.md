# socket-server

Este documento reúne exemplos de uso do servidor TCP nas duas versões disponíveis: **Ruby** (`socket-server.rb`) e **PowerShell** (`SocketServer.ps1`).

## Índice

- [Ruby](#ruby)
  - [Exemplo 1 — Valores padrão](#exemplo-1--valores-padrão)
  - [Exemplo 2 — IP, porta e resposta customizados](#exemplo-2--ip-porta-e-resposta-customizados)
  - [Exemplo 3 — Flags no formato longo](#exemplo-3--flags-no-formato-longo)
- [PowerShell](#powershell)
  - [Exemplo 1 — Valores padrão](#exemplo-1--valores-padrão-1)
  - [Exemplo 2 — Porta customizada](#exemplo-2--porta-customizada)
  - [Exemplo 3 — IP, porta e resposta customizados](#exemplo-3--ip-porta-e-resposta-customizados-1)

---

## Ruby

> Execução: `ruby socket-server.rb [opções]`

| Flag curta | Flag longa      | Descrição      | Padrão             |
|------------|-----------------|-----------------|---------------------|
| `-i`       | `--ip`          | Endereço IP     | `0.0.0.0`           |
| `-p`       | `--porta`       | Porta           | `5000`              |
| `-r`       | `--resposta`    | Resposta enviada| `0000FBIPI9999922`  |

### Exemplo 1 — Valores padrão

```bash
ruby socket-server.rb
```

Sobe o servidor em `0.0.0.0:5000` com a resposta padrão `0000FBIPI9999922`.

### Exemplo 2 — IP, porta e resposta customizados

```bash
ruby socket-server.rb -i 127.0.0.1 -p 6000 -r "MINHA_RESPOSTA"
```

Sobe o servidor em `127.0.0.1:6000`, respondendo com `MINHA_RESPOSTA` a qualquer cliente conectado.

### Exemplo 3 — Flags no formato longo

```bash
ruby socket-server.rb --ip 0.0.0.0 --porta 5000 --resposta "0000FBIPI9999922"
```

Equivalente ao Exemplo 1, mas usando a forma longa das opções.

---

## PowerShell

> Execução: `.\SocketServer.ps1 [opções]`

| Parâmetro   | Descrição       | Padrão             |
|-------------|------------------|---------------------|
| `-Ip`       | Endereço IP      | `0.0.0.0`           |
| `-Porta`    | Porta            | `5000`              |
| `-Resposta` | Resposta enviada | `0000FBIPI9999922`  |

### Exemplo 1 — Valores padrão

```powershell
.\SocketServer.ps1
```

Inicia o servidor em `0.0.0.0` (todas as interfaces de rede `[MEU_IP_DE_REDE]`) na porta padrão e com resposta padrão.

Para testar uma conexão remota, utilize o Telnet ou o PuTTY (em modo Raw), por exemplo, no telnet:

```bash
telnet MEU_IP_DE_REDE 5000
```

### Exemplo 2 — Porta customizada

```powershell
.\SocketServer.ps1 -Porta 5001
```

Inicia o servidor em `0.0.0.0` (todas as interfaces de rede `[MEU_IP_DE_REDE]`) na porta `5001` e com resposta padrão.

### Exemplo 3 — IP, porta e resposta customizados

```powershell
.\SocketServer.ps1 -Ip "127.0.0.1" -Porta 5001 -Resposta "RESPOSTA_DO_TESTE_1234"
```

Inicia o servidor localmente na porta `5001` e com resposta personalizada.