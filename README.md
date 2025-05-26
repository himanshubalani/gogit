# gogit
Scripts to open git remote url in browsers



It defaults to the `origin` remote but supports passing a different remote name if needed.

---

## What you need to have
- Have a Windows OS device
- Have Git installed and available in your system PATH (see [Enviroment Variables](https://learn.microsoft.com/en-us/previous-versions/office/developer/sharepoint-2010/ee537574(v=office.14)))
- A valid Git repository initialized in the current directory

---

## Quick Install (PowerShell)

Paste this into PowerShell to download both scripts to your `Scripts` folder:

```powershell
$target="$env:USERPROFILE\Scripts"; New-Item -ItemType Directory -Force -Path $target; Invoke-WebRequest https://raw.githubusercontent.com/himanshubalani/gogit/main/gogit.bat -OutFile "$target\gogit.bat"; Invoke-WebRequest https://raw.githubusercontent.com/himanshubalani/gogit/main/gogit.ps1 -OutFile "$target\gogit.ps1"

```
---
## Install

To use these scripts from any folder on your system, follow these steps:

1. **Download the scripts**: [gogit.ps1](https://raw.githubusercontent.com/himanshubalani/gogit/main/gogit.ps1) and [gogit.bat](https://raw.githubusercontent.com/himanshubalani/gogit/main/gogit.bat)
2. **Move the scripts**: Place the script in a directory of your choice (e.g., `C:\Users\<YourUsername>\Scripts`).
3. **Add the directory to your PATH**: This allows you to run the script from any command prompt or PowerShell window. (see [Enviroment Variables](https://learn.microsoft.com/en-us/previous-versions/office/developer/sharepoint-2010/ee537574(v=office.14)))
    - Press Win + S and search for "Environment Variables"
    - Click "Edit the system environment variables"
    - In the System Properties window, click "Environment Variables"
    - Under "User variables", find and select Path, then click Edit
    - Click New, and add the path to your Scripts folder (e.g., C:\Users\<YourUsername>\Scripts)

 - Click OK to save and close all dialogs

## Usage

```
gogit
```
or
```
gogit [remote-name]
```

- If no argument is provided, it defaults to `origin`
- Converts SSH-style URLs (e.g., `git@github.com:user/repo.git`) to HTTPS
- Opens the repository page in your default browser

**Example:**

```bat
gogit
gogit dev
```

## How It Works

1. The script checks if the current folder is a Git repository.
2. It fetches the URL for the given remote (default: `origin`).
3. If the remote uses SSH (`git@github.com:user/repo.git`), it converts it to HTTPS.
4. It strips the `.git` suffix (if present).
5. It opens the resulting URL in your default browser.

---

## Troubleshooting

- **"Not a Git repository"**  
  Make sure you're inside a folder with a `.git` directory (i.e., a valid Git repo).

- **"Remote not found"**  
  Double-check the remote name by running `git remote -v`.

- **PowerShell script execution policy blocks the script**  
  You may need to allow script execution:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
  ```

- **Opening URL fails**  
  Ensure you have a default browser set and you're not running in a restricted environment.

---

## Tip

You can rename these scripts and add them to a folder in your system `PATH` for easier access from any Git repo.
