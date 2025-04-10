- 🇺🇸 [English - US](./README-enUS.md)

Este projeto tem como objetivo **instalar em massa o Tactical RMM Agent, o Mesh Agent e o NextTime** em computadores com **Windows 7 até versões atuais** (msi funciona da 98 para cima), utilizando **Active Directory (AD)** para distribuir o instalador .msi de forma automática, silenciosa e indetectável por antivírus (quando instalado via AD).

---

## 🧠 Visão Geral

A instalação funciona com dois mecanismos principais:

- **VBScript (`main.vbs`)**: executa o instalador .exe (agente TacticalMeshetc).
- **PowerShell (`main.ps1`)**: executa o instalador .exe caso o VBScript esteja desabilitado no sistema.

Esse fallback duplo garante maior compatibilidade e evita bloqueios.

---

## 📦 Requisitos

Antes de tudo, certifique-se de:

1. Ter o [.NET SDK](https://dotnet.microsoft.com/download) instalado  
2. Instalar a ferramenta WiX globalmente:
   ```bash
   dotnet tool install --global wix
   ```
3. Ter os arquivos gerados pelo **Tactical RMM**:
   - Arquivo .exe do agente
   - Arquivo .ps1 do instalador  
4. Ter acesso ao **Active Directory** com permissão para distribuição de .msi para estações

---

## 🗂️ Estrutura de Arquivos

Coloque os arquivos renomeados na mesma pasta do .wxs:

```
TaticalRMM
├── installer.wxs
├── main.exe     ← Tactical RMM Agent ou Mesh Agent
├── main.ps1     ← Script do instalador do Tactical RMM
├── main.vbs     ← VBS que executa o EXE
```

---

## 🛠️ Como usar

### 1. Prepare os arquivos

- Gere os arquivos .exe e .ps1 do Tactical RMM
- Renomeie:
  - .exe para main.exe
  - .ps1 para main.ps1
- Crie um main.vbs com o seguinte conteúdo:

```vbscript
Set objShell = CreateObject("WScript.Shell")
objShell.Run "main.exe", 0, False
```

> Este script executa o instalador EXE em segundo plano (modo oculto).

### 2. Compile o instalador MSI

No terminal, navegue até a pasta do projeto e execute:

```bash
wix build installer.wxs -out TaticalRMM.msi
```

Isso irá gerar o TaticalRMM.msi pronto para distribuição.

---

## 🖥️ Instalação em Massa via Active Directory

1. Copie o arquivo TaticalRMM.msi para um compartilhamento acessível da rede (ex: \\servidor\\distribuicao\\TaticalRMM.msi)
2. No Active Directory:
   - Vá até **Group Policy Management**
   - Crie ou edite uma **GPO**
   - Vá em: Computer Configuration → Policies → Software Settings → Software Installation
   - Adicione um novo pacote apontando para o caminho UNC do .msi
3. Reinicie as máquinas clientes ou force a atualização com:

```bash
gpupdate force
```

---

## ✅ Compatibilidade

- **Windows 7** até o **Windows 11**
- Compatível com domínios e GPO
- Executa silenciosamente
- **Bypass de antivírus**, desde que instalado via Active Directory

---

## 📌 Observações

- É importante que o PowerShell esteja presente nos sistemas (Windows XP SP2+ já tem).
- O main.ps1 será executado **caso o VBS esteja desativado**.
- Todos os scripts rodam de forma **oculta e assíncrona**.
- Os arquivos são instalados em:  
  C:\\Program Files\\TaticalRMM\\

---
