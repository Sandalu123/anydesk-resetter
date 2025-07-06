# AnyDesk Resetter

A comprehensive Windows batch script to completely remove AnyDesk from your system, including all user data, driver files, and temporary files.

> **⚠️ Important: Uninstall AnyDesk First**  
> Before running this script, **uninstall AnyDesk through Windows Settings or Control Panel**. This script removes residual files and components that remain after the standard uninstall process.

## 🚀 Quick Start

**One-liner to download and execute:**
```bash
curl -L https://raw.githubusercontent.com/Sandalu123/anydesk-resetter/main/anydesk-resetter.bat -o anydesk-resetter.bat && anydesk-resetter.bat
```

## 📋 Features

- **Complete Removal**: Removes all AnyDesk components including user data, drivers, and temporary files
- **Modern Interface**: Clean, colorful interface with progress indicators
- **Error Handling**: Comprehensive error handling with detailed status reporting
- **Auto-Elevation**: Automatically requests administrator privileges when needed
- **Safe Operation**: Terminates AnyDesk processes before removal
- **Verification**: Verifies successful removal of all components
- **Summary Report**: Provides detailed operation summary

## 🛠️ What It Does

This script is designed to clean up **residual files and components** that remain after uninstalling AnyDesk through standard Windows uninstall methods. It performs the following operations:

1. **Process Termination**: Safely terminates any remaining AnyDesk processes
2. **User Data Cleanup**: Removes leftover AnyDesk user data directory (`%AppData%\AnyDesk`)
3. **Driver Store Cleanup**: Removes AnyDesk drivers from Windows driver store that aren't removed by standard uninstall
4. **Temporary Files**: Cleans temporary files that might contain AnyDesk data
5. **Verification**: Confirms successful removal of all residual components

## 📥 Installation & Usage

### Prerequisites
**Before using this script:**
1. **Uninstall AnyDesk** through Windows Settings (Apps & Features) or Control Panel (Programs and Features)
2. **Restart your computer** (recommended)
3. **Run this script** to clean up remaining files and registry entries

### Method 1: Direct Download and Execute
```bash
curl -L https://raw.githubusercontent.com/Sandalu123/anydesk-resetter/main/anydesk-resetter.bat -o anydesk-resetter.bat && anydesk-resetter.bat
```

### Method 2: Download Only
```bash
curl -L https://raw.githubusercontent.com/Sandalu123/anydesk-resetter/main/anydesk-resetter.bat -o anydesk-resetter.bat
```

### Method 3: Clone Repository
```bash
git clone https://github.com/Sandalu123/anydesk-resetter.git
cd anydesk-resetter
anydesk-resetter.bat
```

### Method 4: Manual Download
1. Download the `anydesk-resetter.bat` file from the repository
2. Right-click the file and select "Run as administrator"
3. Follow the on-screen instructions

## 🔧 Requirements

- Windows 10/11 (or Windows Server 2016+)
- Administrator privileges (script will auto-elevate)
- PowerShell (for UAC elevation)

## ⚠️ Important Notes

- **Uninstall First**: Always uninstall AnyDesk through Windows Settings/Control Panel before running this script
- **Administrator Rights**: The script requires administrator privileges to access system directories and driver store
- **AnyDesk Closure**: The script will automatically close any remaining AnyDesk processes
- **Backup Warning**: This script permanently removes AnyDesk residual data. Backup any important AnyDesk configurations before running
- **Antivirus**: Some antivirus software may flag the script due to its system-level operations
- **Restart Recommended**: Restart your computer before running the script for best results

## 🖼️ Interface Preview

```
 ╔════════════════════════════════════════════════════════════════════════╗
 ║                          AnyDesk Resetter v2.0                        ║
 ║                    Complete AnyDesk Removal Tool                       ║
 ╚════════════════════════════════════════════════════════════════════════╝

[STEP 1/5] Terminating AnyDesk processes...
─────────────────────────────────────────────────────────────────────────
[SUCCESS] AnyDesk process terminated successfully.

[STEP 2/5] Cleaning user data directory...
─────────────────────────────────────────────────────────────────────────
[SUCCESS] User data directory removed successfully.

...
```

## 🔍 Troubleshooting

### Common Issues

**Script won't run:**
- Ensure you've uninstalled AnyDesk first through Windows Settings
- Ensure you're running as Administrator
- Check if PowerShell execution policy allows the script
- Verify Windows version compatibility

**Partial removal:**
- Make sure you uninstalled AnyDesk properly before running the script
- Some files may be locked by other processes
- Try restarting Windows and running the script again
- Check antivirus software for quarantined files

**UAC Prompt issues:**
- Ensure UAC is enabled in Windows
- Try running Command Prompt as Administrator first

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

### Development

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Sandalu Pabasara Perera**
- GitHub: [@Sandalu123](https://github.com/Sandalu123)
- Email: [your-email@example.com]

## 🙏 Acknowledgments

- Thanks to the open-source community for inspiration
- Special thanks to users who provided feedback and suggestions

## 🐛 Issues

If you encounter any issues or have suggestions, please [create an issue](https://github.com/Sandalu123/anydesk-resetter/issues) on GitHub.

## 📊 Stats

![GitHub stars](https://img.shields.io/github/stars/Sandalu123/anydesk-resetter?style=social)
![GitHub forks](https://img.shields.io/github/forks/Sandalu123/anydesk-resetter?style=social)
![GitHub issues](https://img.shields.io/github/issues/Sandalu123/anydesk-resetter)
![GitHub license](https://img.shields.io/github/license/Sandalu123/anydesk-resetter)

---

⭐ **Star this repository if you find it helpful!** ⭐
