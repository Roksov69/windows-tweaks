# 👾 windows-tweaks by roksov69

![Windows 11](https://img.shields.io/badge/Windows-11-0078D6?style=for-the-badge&logo=windows11&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Batch Script](https://img.shields.io/badge/Language-Batch-4D4D4D?style=for-the-badge&logo=windows-terminal&logoColor=white)

**windows-tweaks** is a lightweight and minimalist set of utilities built into a single `.bat` file, allowing you to quickly configure Windows 11 without installing third-party software.

The script works through standard system tools (Registry and PowerShell), does not put a load on the PC, and is always at hand.

---

## ✨ Features

All control is done through a convenient console menu. Here is what the script can do:

- 🎨 **Customization**
  - Manage desktop icons ("This PC", "Recycle Bin")
  - Fine-tune Explorer (remove "Home", "Gallery", "Network")
  - Enable compact mode in Explorer
  - Open Explorer directly to "This PC"
  - Set dark highlight color and dark system theme
  - Restore the classic context menu (like in Windows 10)

- ⚡ **Activation**
  - Quick launch of the official MAS (Microsoft Activation Scripts) for system activation (via `get.activated.win`)

- 💻 **PC Specs**
  - View processor, graphics card, RAM capacity, and total physical disk capacity

- 🧹 **Cleanup**
  - Safe deletion of temporary files (`%TEMP%`) with a report on freed space and folder path

- 🌐 **Multilingual**
  - Toggle the interface between Russian (RU) and English (EN) languages.

---

## 🚀 Getting Started

1. Go to the **Code** section (green button) and download the ZIP archive, or download the file directly.
2. Extract the archive (if you downloaded the ZIP).
3. **Right-click** on the `.bat` file and select **"Run as administrator"** (this is important because some tweaks require administrator privileges).

---

## 📸 Screenshot

<div align="center">
  <img width="320" alt="Menu Screenshot" src="https://github.com/user-attachments/assets/b039163b-4415-4f02-8968-bcf5990c8e10" />
  &nbsp;&nbsp;
  <img width="320" alt="Explorer Screenshot" src="https://github.com/user-attachments/assets/c6c00c2d-1c12-4f97-a8f0-07e732901e96" />
</div>

---

## ⚠️ Important Note
Before running, make sure your antivirus is not blocking the `.bat` file. The script does not contain malicious code but uses the Registry and PowerShell to make changes. All actions are reversible.
