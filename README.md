# Active Directory User Automation Demo (PowerShell)

[![PowerShell](https://img.shields.io/badge/PowerShell-Demo-blue)](https://github.com/)

**Project by @YourGitHubUsername**

---

## Overview
This project demonstrates Active Directory user automation using PowerShell in a **safe demo environment**.  
No real domain is needed; all scripts are **demo-only**.

Features:
- CSV-driven user creation
- Group assignment simulation
- Home folder creation simulation
- Secure random password generation
- Mock Azure Key Vault secret retrieval
- Error handling and logging

---

## Files
- `create_user_basic_demo.ps1` — single-user demo script
- `create_users_csv_demo.ps1` — CSV-driven demo script
- `users.csv` — example input CSV
- `onboarding_run_log_demo.csv` — generated log file
- `sample_screenshots/` — mock screenshots
- `.gitignore` — ignores logs, temp files, and screenshots
- `LICENSE` — MIT license

---

## Usage
**Single user demo:**
```powershell
.\create_user_basic_demo.ps1 -FirstName "Alice" -LastName "Johnson"
```

**CSV-driven demo:**
```powershell
.\create_users_csv_demo.ps1 -CsvPath ".\users.csv"
```

All scripts are **safe to run** and do not require a real Active Directory domain.
