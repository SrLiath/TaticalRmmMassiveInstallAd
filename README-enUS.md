This project is designed to **mass install the Tactical RMM Agent, Mesh Agent, and NextTime** on machines from **Windows 7 to current versions** (MSI works in version 98 and above), using **Active Directory (AD)** to silently deploy the installer .msi without detection by antivirus software (when installed via AD).

---

## 🧠 Overview

Installation runs using two methods:

- **VBScript (`main.vbs`)**: runs the .exe installer
- **PowerShell (`main.ps1`)**: runs the .exe if VBS is disabled

This fallback ensures compatibility across systems.

---

## 📦 Requirements

1. Install [.NET SDK](https://dotnet.microsoft.com/download)  
2. Install WiX globally:  
   ```bash
   dotnet tool install --global wix
   ```
3. Export the Tactical RMM `.exe` and `.ps1`
4. Access to Active Directory environment

---

## 🗂️ Structure

```
TaticalRMM
├── installer.wxs
├── main.exe
├── main.ps1
├── main.vbs
```

---

## 🛠️ How to Use

Build the MSI:

```bash
wix build installer.wxs -out TaticalRMM.msi
```

Deploy the `.msi` via Active Directory:

1. Copy to a shared folder:  
   \\server\\share\\TaticalRMM.msi
2. In GPO:  
   Computer Configuration → Policies → Software Installation
3. Add the package and apply
4. Run:

```bash
gpupdate force
```

---
