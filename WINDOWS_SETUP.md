# Windows 11 Setup Guide - PBP-v01 Project

**Project:** Astro + PayloadCMS + Supabase Monorepo  
**Target OS:** Windows 11  
**Last Updated:** September 27, 2025

---

## 🎯 Quick Start for Windows Developers

### **Prerequisites**
- ✅ **Windows 11** (or Windows 10 version 1903+)
- ✅ **PowerShell 5.1** or later (included with Windows 11)
- ✅ **Git for Windows** - [Download here](https://git-scm.windows.com/)
- ✅ **Node.js 18.20+** or **20.9+** - [Download here](https://nodejs.org/)
- ✅ **Flox** - [Install from flox.dev](https://flox.dev)

### **Quick Setup Commands**
```powershell
# 1. Clone the repository
git clone [repository-url]
cd pbp-v01

# 2. Activate flox environment
flox activate

# 3. Start development servers
.\dev-scripts.ps1 dev

# 4. Open in browser
# Frontend: http://localhost:4321
# Backend:  http://localhost:3000
```

---

## 🛠️ Detailed Installation Guide

### **Step 1: Install Prerequisites**

#### **1.1 PowerShell (Built-in)**
Windows 11 comes with PowerShell 5.1+. To verify:
```powershell
$PSVersionTable.PSVersion
# Should show 5.1 or higher
```

#### **1.2 Git for Windows**
1. Download from [git-scm.windows.com](https://git-scm.windows.com/)
2. Run installer with default settings
3. Verify installation:
```powershell
git --version
```

#### **1.3 Node.js**
1. Download LTS version from [nodejs.org](https://nodejs.org/)
2. Install with default settings
3. Verify installation:
```powershell
node --version  # Should be 18.20+ or 20.9+
npm --version
```

#### **1.4 Flox Environment Manager**
1. Visit [flox.dev](https://flox.dev) and follow Windows installation instructions
2. Verify installation:
```powershell
flox --version
```

### **Step 2: Project Setup**

#### **2.1 Clone Repository**
```powershell
git clone [repository-url]
cd pbp-v01
```

#### **2.2 Activate Flox Environment**
```powershell
# Activate the development environment
flox activate

# This will automatically install:
# - Node.js and npm
# - Python and uv
# - PostgreSQL
# - Other project dependencies
```

#### **2.3 Environment Configuration**
```powershell
# Copy environment template
Copy-Item .env.example .env

# Edit .env file with your preferred editor
notepad .env
# or
code .env
```

#### **2.4 Database Setup**
```powershell
# Option 1: Use local database (recommended for development)
.\dev-scripts.ps1 db:switch local

# Option 2: Configure Supabase (if you have a project)
.\dev-scripts.ps1 supabase:setup
```

---

## 🚀 Development Workflow

### **Starting Development**
```powershell
# Start both frontend and backend servers
.\dev-scripts.ps1 dev

# Or start individually:
.\dev-scripts.ps1 frontend:dev  # Astro on port 4321
.\dev-scripts.ps1 backend:dev   # PayloadCMS on port 3000
```

### **Building the Project**
```powershell
# Build frontend
.\dev-scripts.ps1 frontend:build

# Build backend
.\dev-scripts.ps1 backend:build

# Generate TypeScript types
.\dev-scripts.ps1 backend:generate:types
```

### **Working with Services**
```powershell
# Check service status
.\dev-scripts.ps1 services:status

# Stop all services
.\dev-scripts.ps1 services:stop

# View service logs
.\dev-scripts.ps1 services:logs
```

---

## 🔧 Windows-Specific Commands

### **PowerShell Script Usage**
The project includes `dev-scripts.ps1` which provides Windows-native functionality:

```powershell
# Show all available commands
.\dev-scripts.ps1 help

# Check project configuration
.\dev-scripts.ps1 check

# Show project status
.\dev-scripts.ps1 status
```

### **Python Development**
```powershell
# Create virtual environment
.\dev-scripts.ps1 python:venv

# Activate virtual environment (Windows-specific path)
.venv\Scripts\Activate.ps1

# Install dependencies
.\dev-scripts.ps1 python:install

# Run tests
.\dev-scripts.ps1 python:test
```

### **Database Operations**
```powershell
# Pull from cloud to local
.\dev-scripts.ps1 db:pull

# Push from local to cloud (careful - destructive!)
.\dev-scripts.ps1 db:push

# Switch between databases
.\dev-scripts.ps1 db:switch local
.\dev-scripts.ps1 db:switch supabase

# Check current database
.\dev-scripts.ps1 db:status
```

---

## 🔍 Windows-Specific Configuration

### **File Paths**
Windows uses backslashes (`\`) in file paths. The PowerShell script handles this automatically:

- ✅ **PowerShell script:** `.\dev-scripts.ps1`
- ✅ **Virtual environment:** `.venv\Scripts\Activate.ps1`
- ✅ **Configuration files:** Use standard relative paths

### **MCP Server Configuration**
For AI tool integration on Windows:

```powershell
# Install MCP servers
.\dev-scripts.ps1 mcp:install

# Test MCP servers
.\dev-scripts.ps1 mcp:test

# Check MCP configuration
.\dev-scripts.ps1 mcp:status
```

**Windows MCP paths:**
- Warp Terminal: `%APPDATA%\dev.warp.Warp-Stable\mcp_servers.json`
- Other AI tools: See `MCP_SETUP.md` for details

### **Environment Variables**
Windows PowerShell uses `$env:` prefix for environment variables:

```powershell
# Check if flox is active
echo $env:_FLOX_ACTIVE_ENVIRONMENTS

# Set additional variables if needed
$env:NODE_ENV = "development"
```

---

## 🛟 Troubleshooting

### **Common Issues**

#### **"Execution Policy" Error**
If you get execution policy errors:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### **Flox Not Found**
Ensure Flox is properly installed and in PATH:
```powershell
# Check PATH
$env:PATH -split ";"

# Restart PowerShell after installation
```

#### **PostgreSQL Connection Issues**
For local database problems:
```powershell
# Check if PostgreSQL is running
.\dev-scripts.ps1 services:status

# Restart PostgreSQL if needed
flox activate
pg_ctl -D .flox/postgres-data start
```

#### **Port Already in Use**
If ports 3000 or 4321 are occupied:
```powershell
# Check what's using the port
netstat -ano | findstr :3000
netstat -ano | findstr :4321

# Kill process if needed (replace PID)
taskkill /PID [process-id] /F
```

### **Performance Tips**

#### **Windows Defender Exclusions**
Add project folder to Windows Defender exclusions for better performance:
1. Open Windows Security
2. Go to Virus & threat protection
3. Add exclusion for project folder

#### **WSL Alternative**
For enhanced Linux compatibility, consider using WSL2:
```powershell
# Install WSL2 (if preferred)
wsl --install

# Then work from within WSL2 environment
```

---

## 📋 Command Reference

### **Development Commands**
| Command | Description |
|---------|-------------|
| `.\dev-scripts.ps1 dev` | Start both frontend and backend |
| `.\dev-scripts.ps1 frontend:dev` | Start Astro dev server only |
| `.\dev-scripts.ps1 backend:dev` | Start PayloadCMS dev server only |
| `.\dev-scripts.ps1 frontend:build` | Build Astro project |
| `.\dev-scripts.ps1 backend:build` | Build PayloadCMS project |

### **Utility Commands**
| Command | Description |
|---------|-------------|
| `.\dev-scripts.ps1 check` | Check project configuration |
| `.\dev-scripts.ps1 status` | Show complete project status |
| `.\dev-scripts.ps1 setup` | Show setup instructions |

### **Database Commands**
| Command | Description |
|---------|-------------|
| `.\dev-scripts.ps1 db:status` | Show current database configuration |
| `.\dev-scripts.ps1 db:switch local` | Switch to local PostgreSQL |
| `.\dev-scripts.ps1 db:switch supabase` | Switch to Supabase cloud |
| `.\dev-scripts.ps1 db:pull` | Pull from Supabase to local |
| `.\dev-scripts.ps1 db:push` | Push from local to Supabase |

### **Service Management**
| Command | Description |
|---------|-------------|
| `.\dev-scripts.ps1 services:start` | Start all services |
| `.\dev-scripts.ps1 services:stop` | Stop all services |
| `.\dev-scripts.ps1 services:status` | Show services status |
| `.\dev-scripts.ps1 services:logs` | Show services logs |

---

## 🔗 Cross-Platform Notes

### **Script Equivalents**
- **Unix/macOS:** `./dev-scripts.sh [command]`
- **Windows:** `.\dev-scripts.ps1 [command]`

### **Path Differences**
- **Unix:** Forward slashes `/`
- **Windows:** Backslashes `\` (handled automatically)

### **Virtual Environment Activation**
- **Unix/macOS:** `source .venv/bin/activate`
- **Windows:** `.venv\Scripts\Activate.ps1`

### **Fallback Support**
The PowerShell script includes fallback support:
- If PowerShell versions of database scripts aren't found, it uses bash scripts via Git Bash
- Ensures compatibility even in mixed environments

---

## 📞 Getting Help

### **Project Commands**
```powershell
# Show all available commands
.\dev-scripts.ps1 help

# Check current configuration
.\dev-scripts.ps1 check

# Show detailed status
.\dev-scripts.ps1 status
```

### **Documentation**
- **General setup:** `README.md`
- **Database sync:** `DATABASE_SYNC_REPORT.md`
- **Script functionality:** `DEV_SCRIPTS_FUNCTIONALITY_REPORT.md`
- **MCP setup:** `MCP_SETUP.md`

### **Support**
- Check existing documentation files
- Review error messages carefully
- Ensure all prerequisites are installed
- Verify flox environment is activated

---

**Windows Setup Guide Version:** 1.0  
**Compatible with:** Windows 11, Windows 10 (1903+)  
**PowerShell Version:** 5.1+