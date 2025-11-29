# PowerShell Development Scripts for PBP project (Windows 11)
# Run these commands from the project root after activating flox environment

Write-Host "🚀 PBP Development Scripts (Windows)" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

param(
    [Parameter(Position=0)]
    [string]$Command,
    [Parameter(Position=1)]
    [string]$SecondArg
)

# Function to check if flox environment is active
function Test-FloxEnvironment {
    return $env:_FLOX_ACTIVE_ENVIRONMENTS -ne $null
}

# Function to check if a command exists
function Test-Command {
    param([string]$CommandName)
    try {
        Get-Command $CommandName -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

switch ($Command) {
    "frontend:dev" {
        Write-Host "Starting Astro development server..." -ForegroundColor Green
        if (Test-FloxEnvironment) {
            flox services start frontend
        } else {
            Write-Host "⚠️  Please run this command from within the activated flox environment:" -ForegroundColor Yellow
            Write-Host "   flox activate" -ForegroundColor White
            Write-Host "   .\dev-scripts.ps1 frontend:dev" -ForegroundColor White
        }
    }
    "frontend:build" {
        Write-Host "Building Astro project..." -ForegroundColor Green
        Set-Location frontend
        npm run build
        Set-Location ..
    }
    "frontend:preview" {
        Write-Host "Starting Astro preview server..." -ForegroundColor Green
        Set-Location frontend
        npm run preview
        Set-Location ..
    }
    "backend:dev" {
        Write-Host "Starting Payload CMS development server..." -ForegroundColor Green
        if (Test-FloxEnvironment) {
            flox services start backend
        } else {
            Write-Host "⚠️  Please run this command from within the activated flox environment:" -ForegroundColor Yellow
            Write-Host "   flox activate" -ForegroundColor White
            Write-Host "   .\dev-scripts.ps1 backend:dev" -ForegroundColor White
        }
    }
    "backend:build" {
        Write-Host "Building Payload CMS project..." -ForegroundColor Green
        Set-Location backend
        npm run build
        Set-Location ..
    }
    "backend:generate:types" {
        Write-Host "Generating Payload CMS TypeScript types..." -ForegroundColor Green
        Set-Location backend
        npm run generate:types
        Set-Location ..
    }
    "dev" {
        Write-Host "Starting both frontend and backend servers..." -ForegroundColor Green
        Write-Host "📡 Backend will start on http://localhost:3000" -ForegroundColor Blue
        Write-Host "🌐 Frontend will start on http://localhost:4321" -ForegroundColor Blue
        Write-Host ""
        
        if (Test-FloxEnvironment) {
            Write-Host "Press Ctrl+C to stop all servers" -ForegroundColor Yellow
            Write-Host ""
            # Use flox services to start both services
            flox services start backend frontend
        } else {
            Write-Host "💡 To start both services, use:" -ForegroundColor Blue
            Write-Host "   flox activate --start-services" -ForegroundColor White
            Write-Host "" 
            Write-Host "Or activate first, then start:" -ForegroundColor Blue
            Write-Host "   flox activate" -ForegroundColor White
            Write-Host "   .\dev-scripts.ps1 dev" -ForegroundColor White
        }
    }
    "setup" {
        Write-Host "Setting up development environment..." -ForegroundColor Green
        Write-Host "✅ Flox environment initialized with Node.js & Python" -ForegroundColor Green
        Write-Host "✅ Astro project created in frontend/" -ForegroundColor Green
        Write-Host "✅ Payload CMS created in backend/" -ForegroundColor Green
        Write-Host "📝 Next steps:" -ForegroundColor Blue
        Write-Host "   1. Copy .env.example to .env and configure your Supabase credentials" -ForegroundColor White
        Write-Host "   2. Run '.\dev-scripts.ps1 dev' to start both servers" -ForegroundColor White
        Write-Host "   3. Visit http://localhost:3000/admin to set up your first admin user" -ForegroundColor White
    }
    "check" {
        Write-Host "Checking project status..." -ForegroundColor Green
        Write-Host ""
        
        # Check flox environment
        if (Test-Command "flox") {
            Write-Host "✅ Flox environment: Available" -ForegroundColor Green
        } else {
            Write-Host "❌ Flox environment: Not available" -ForegroundColor Red
        }
        
        # Check frontend
        if (Test-Path "frontend/package.json") {
            Write-Host "✅ Frontend (Astro): Set up" -ForegroundColor Green
        } else {
            Write-Host "❌ Frontend (Astro): Not found" -ForegroundColor Red
        }
        
        # Check backend
        if (Test-Path "backend/package.json") {
            Write-Host "✅ Backend (Payload CMS): Set up" -ForegroundColor Green
        } else {
            Write-Host "❌ Backend (Payload CMS): Not found" -ForegroundColor Red
        }
        
        # Check environment files
        if (Test-Path ".env") {
            Write-Host "✅ Environment file: Configured" -ForegroundColor Green
            
            # Check if DATABASE_URI is set
            $envContent = Get-Content ".env" -Raw -ErrorAction SilentlyContinue
            if ($envContent -match "DATABASE_URI=postgresql") {
                Write-Host "✅ Supabase configuration: Found" -ForegroundColor Green
            } else {
                Write-Host "⚠️  Supabase configuration: DATABASE_URI not configured" -ForegroundColor Yellow
            }
        } else {
            Write-Host "⚠️  Environment file: Run .\setup-supabase.ps1 to configure" -ForegroundColor Yellow
        }
    }
    "supabase:setup" {
        Write-Host "Starting Supabase setup..." -ForegroundColor Green
        if (Test-Path ".\setup-supabase.ps1") {
            .\setup-supabase.ps1
        } else {
            Write-Host "❌ setup-supabase.ps1 not found! Using shell script fallback..." -ForegroundColor Red
            .\setup-supabase.sh
        }
    }
    "supabase:test" {
        Write-Host "Testing Supabase database connection..." -ForegroundColor Green
        if (-not (Test-Path ".env")) {
            Write-Host "❌ .env file not found! Run .\setup-supabase.ps1 first." -ForegroundColor Red
            exit 1
        }
        if (Test-FloxEnvironment) {
            flox services start db-test
        } else {
            Write-Host "⚠️  Please run this command from within the activated flox environment:" -ForegroundColor Yellow
            Write-Host "   flox activate" -ForegroundColor White
            Write-Host "   .\dev-scripts.ps1 supabase:test" -ForegroundColor White
        }
    }
    "status" {
        Write-Host "📊 PBP-v01 Project Status (Windows)" -ForegroundColor Cyan
        Write-Host "====================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "🎯 Project: Astro + PayloadCMS + Supabase Monorepo" -ForegroundColor Blue
        Write-Host "📅 Setup Date: $(Get-Date -Format 'yyyy-MM-dd')" -ForegroundColor Blue
        Write-Host ""
        
        # Check all components
        Write-Host "Component Status:" -ForegroundColor Blue
        if (Test-Path "frontend/package.json") {
            Write-Host "  ✅ Frontend (Astro): Ready" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Frontend (Astro): Missing" -ForegroundColor Red
        }
        
        if (Test-Path "backend/package.json") {
            Write-Host "  ✅ Backend (PayloadCMS): Ready" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Backend (PayloadCMS): Missing" -ForegroundColor Red
        }
        
        if ((Test-Path ".env") -and ((Get-Content ".env" -Raw) -match "SUPABASE_PROJECT_ID")) {
            Write-Host "  ✅ Database (Supabase): Configured" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Database (Supabase): Not configured" -ForegroundColor Red
        }
        
        if (Test-Command "flox") {
            Write-Host "  ✅ Environment (Flox): Active" -ForegroundColor Green
        } else {
            Write-Host "  ❌ Environment (Flox): Not available" -ForegroundColor Red
        }
        
        Write-Host ""
        Write-Host "📋 Quick Commands:" -ForegroundColor Blue
        Write-Host "  .\dev-scripts.ps1 dev        - Start both services" -ForegroundColor White
        Write-Host "  .\dev-scripts.ps1 check      - Verify configuration" -ForegroundColor White
        Write-Host "  .\dev-scripts.ps1 help       - Show all commands" -ForegroundColor White
        Write-Host ""
        Write-Host "🌐 Access Points (when running):" -ForegroundColor Blue
        Write-Host "  Frontend:    http://localhost:4321" -ForegroundColor White
        Write-Host "  Backend:     http://localhost:3000/admin" -ForegroundColor White
        Write-Host "  API:         http://localhost:3000/api" -ForegroundColor White
        Write-Host "  Test Page:   http://localhost:4321/api-test" -ForegroundColor White
    }
    "services:start" {
        Write-Host "Starting all flox services..." -ForegroundColor Green
        if (Test-FloxEnvironment) {
            flox services start
        } else {
            Write-Host "⚠️  Please run this command from within the activated flox environment:" -ForegroundColor Yellow
            Write-Host "   flox activate" -ForegroundColor White
            Write-Host "   .\dev-scripts.ps1 services:start" -ForegroundColor White
            Write-Host ""
            Write-Host "Or use: flox activate --start-services" -ForegroundColor White
        }
    }
    "services:stop" {
        Write-Host "Stopping all flox services..." -ForegroundColor Green
        if (Test-FloxEnvironment) {
            flox services stop
        } else {
            Write-Host "⚠️  Please run this command from within the activated flox environment:" -ForegroundColor Yellow
            Write-Host "   flox activate" -ForegroundColor White
            Write-Host "   .\dev-scripts.ps1 services:stop" -ForegroundColor White
        }
    }
    "services:status" {
        Write-Host "Checking flox services status..." -ForegroundColor Green
        if (Test-FloxEnvironment) {
            flox services status
        } else {
            Write-Host "⚠️  Please run this command from within the activated flox environment:" -ForegroundColor Yellow
            Write-Host "   flox activate" -ForegroundColor White
            Write-Host "   .\dev-scripts.ps1 services:status" -ForegroundColor White
        }
    }
    "services:logs" {
        Write-Host "Showing flox services logs..." -ForegroundColor Green
        if (Test-FloxEnvironment) {
            flox services logs
        } else {
            Write-Host "⚠️  Please run this command from within the activated flox environment:" -ForegroundColor Yellow
            Write-Host "   flox activate" -ForegroundColor White
            Write-Host "   .\dev-scripts.ps1 services:logs" -ForegroundColor White
        }
    }
    "python:install" {
        Write-Host "Installing Python dependencies with uv..." -ForegroundColor Green
        uv pip install -e .
    }
    "python:install:dev" {
        Write-Host "Installing Python dependencies with development tools..." -ForegroundColor Green
        uv pip install -e ".[dev]"
    }
    "python:venv" {
        Write-Host "Creating Python virtual environment with uv..." -ForegroundColor Green
        uv venv
        Write-Host "Activate with: .venv\Scripts\Activate.ps1" -ForegroundColor Yellow
    }
    "python:test" {
        Write-Host "Running Python tests..." -ForegroundColor Green
        if (Test-Path ".venv") {
            .venv\Scripts\Activate.ps1
        }
        python -m pytest
    }
    "mcp:install" {
        Write-Host "Installing MCP server dependencies..." -ForegroundColor Green
        Write-Host "This will install the required MCP servers globally." -ForegroundColor Blue
        Write-Host ""
        npm install -g @modelcontextprotocol/server-memory @modelcontextprotocol/server-postgres @modelcontextprotocol/server-sequential-thinking enhanced-postgres-mcp-server
        Write-Host ""
        Write-Host "✅ MCP servers installed successfully!" -ForegroundColor Green
        Write-Host "📖 Next: Configure Warp MCP settings or read MCP_SETUP.md for other AI tools" -ForegroundColor Blue
    }
    "mcp:test" {
        Write-Host "Testing MCP server connections..." -ForegroundColor Green
        Write-Host ""
        
        # Test each MCP server
        Write-Host "Testing memory server..." -ForegroundColor Blue
        try {
            $output = npx @modelcontextprotocol/server-memory --version 2>$null
            Write-Host "  ✅ Memory server: Available" -ForegroundColor Green
        }
        catch {
            Write-Host "  ❌ Memory server: Not found" -ForegroundColor Red
        }
        
        Write-Host "Testing postgres server..." -ForegroundColor Blue
        try {
            $output = npx @modelcontextprotocol/server-postgres --version 2>$null
            Write-Host "  ✅ Postgres server: Available" -ForegroundColor Green
        }
        catch {
            Write-Host "  ❌ Postgres server: Not found" -ForegroundColor Red
        }
        
        Write-Host "Testing sequential-thinking server..." -ForegroundColor Blue
        try {
            $output = npx @modelcontextprotocol/server-sequential-thinking --version 2>$null
            Write-Host "  ✅ Sequential-thinking server: Available" -ForegroundColor Green
        }
        catch {
            Write-Host "  ❌ Sequential-thinking server: Not found" -ForegroundColor Red
        }
        
        Write-Host "Testing enhanced-postgres server..." -ForegroundColor Blue
        try {
            $output = npx enhanced-postgres-mcp-server --version 2>$null
            Write-Host "  ✅ Enhanced-postgres server: Available" -ForegroundColor Green
        }
        catch {
            Write-Host "  ❌ Enhanced-postgres server: Not found" -ForegroundColor Red
        }
    }
    "mcp:status" {
        Write-Host "📊 MCP Configuration Status (Windows)" -ForegroundColor Cyan
        Write-Host "=====================================" -ForegroundColor Cyan
        Write-Host ""
        
        # Check configuration files
        if (Test-Path "mcp.json") {
            Write-Host "✅ MCP configuration: Found (mcp.json)" -ForegroundColor Green
        } else {
            Write-Host "❌ MCP configuration: Missing (mcp.json)" -ForegroundColor Red
        }
        
        if (Test-Path "mcp-resources.json") {
            Write-Host "✅ MCP resources: Found (mcp-resources.json)" -ForegroundColor Green
        } else {
            Write-Host "❌ MCP resources: Missing (mcp-resources.json)" -ForegroundColor Red
        }
        
        if (Test-Path "MCP_SETUP.md") {
            Write-Host "✅ MCP documentation: Found (MCP_SETUP.md)" -ForegroundColor Green
        } else {
            Write-Host "❌ MCP documentation: Missing (MCP_SETUP.md)" -ForegroundColor Red
        }
        
        Write-Host ""
        Write-Host "📋 Configuration Summary:" -ForegroundColor Blue
        if (Test-Path "mcp.json") {
            Write-Host "  • Memory server: Configured" -ForegroundColor White
            Write-Host "  • PostgreSQL server: Configured" -ForegroundColor White
            Write-Host "  • Sequential-thinking server: Configured" -ForegroundColor White
            Write-Host "  • Enhanced PostgreSQL server: Configured" -ForegroundColor White
        }
        
        # Check Windows-specific MCP configuration paths
        $warpConfigPath = "$env:APPDATA\dev.warp.Warp-Stable\mcp_servers.json"
        if (Test-Path $warpConfigPath) {
            Write-Host "  • Warp MCP configuration: Found" -ForegroundColor Green
        } else {
            Write-Host "  • Warp MCP configuration: Missing" -ForegroundColor Yellow
        }
        
        Write-Host ""
        Write-Host "🔗 Next Steps:" -ForegroundColor Blue
        Write-Host "  1. Run '.\dev-scripts.ps1 mcp:install' to install servers" -ForegroundColor White
        Write-Host "  2. Configure your AI tool (see MCP_SETUP.md)" -ForegroundColor White
        Write-Host "  3. Test with '.\dev-scripts.ps1 mcp:test'" -ForegroundColor White
    }
    "mcp:setup" {
        Write-Host "🤖 MCP Setup Instructions (Windows)" -ForegroundColor Cyan
        Write-Host "====================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Your project is configured with Model Context Protocol (MCP) support!" -ForegroundColor Green
        Write-Host ""
        Write-Host "📁 Configuration Files:" -ForegroundColor Blue
        Write-Host "  • mcp.json          - Main MCP server configuration" -ForegroundColor White
        Write-Host "  • mcp-resources.json - Project-specific resource definitions" -ForegroundColor White
        Write-Host "  • MCP_SETUP.md      - Detailed setup guide" -ForegroundColor White
        Write-Host ""
        Write-Host "🚀 Quick Setup:" -ForegroundColor Blue
        Write-Host "  1. Install MCP servers:    .\dev-scripts.ps1 mcp:install" -ForegroundColor White
        Write-Host "  2. Test installation:      .\dev-scripts.ps1 mcp:test" -ForegroundColor White
        Write-Host "  3. Check status:           .\dev-scripts.ps1 mcp:status" -ForegroundColor White
        Write-Host ""
        Write-Host "📖 For detailed instructions, see: MCP_SETUP.md" -ForegroundColor Blue
        Write-Host "🔧 Configure your AI tool with the MCP servers to get enhanced assistance!" -ForegroundColor Green
    }
    "db:pull" {
        Write-Host "Pulling database from Supabase to local..." -ForegroundColor Green
        if (Test-Path ".\scripts\db-pull.ps1") {
            .\scripts\db-pull.ps1
        } else {
            Write-Host "⚠️  PowerShell version not found, using shell script..." -ForegroundColor Yellow
            bash .\scripts\db-pull.sh
        }
    }
    "db:push" {
        Write-Host "Pushing database from local to Supabase..." -ForegroundColor Green
        if (Test-Path ".\scripts\db-push.ps1") {
            .\scripts\db-push.ps1
        } else {
            Write-Host "⚠️  PowerShell version not found, using shell script..." -ForegroundColor Yellow
            bash .\scripts\db-push.sh
        }
    }
    "db:switch" {
        if ([string]::IsNullOrEmpty($SecondArg)) {
            if (Test-Path ".\scripts\db-switch.ps1") {
                .\scripts\db-switch.ps1
            } else {
                bash .\scripts\db-switch.sh
            }
        } else {
            if (Test-Path ".\scripts\db-switch.ps1") {
                .\scripts\db-switch.ps1 $SecondArg
            } else {
                bash .\scripts\db-switch.sh $SecondArg
            }
        }
    }
    "db:status" {
        if (Test-Path ".\scripts\db-switch.ps1") {
            .\scripts\db-switch.ps1 status
        } else {
            bash .\scripts\db-switch.sh status
        }
    }
    { $_ -in @("help", "") -or $null -eq $_ } {
        Write-Host "Available commands:" -ForegroundColor Blue
        Write-Host ""
        Write-Host "🚀 Development:" -ForegroundColor Green
        Write-Host "  dev             - Start both frontend and backend servers" -ForegroundColor White
        Write-Host "  frontend:dev    - Start Astro dev server only" -ForegroundColor White
        Write-Host "  backend:dev     - Start Payload CMS dev server only" -ForegroundColor White
        Write-Host ""
        Write-Host "🔨 Build:" -ForegroundColor Green
        Write-Host "  frontend:build  - Build Astro project" -ForegroundColor White
        Write-Host "  backend:build   - Build Payload CMS project" -ForegroundColor White
        Write-Host "  frontend:preview - Preview built Astro project" -ForegroundColor White
        Write-Host ""
        Write-Host "⚙️  Utils:" -ForegroundColor Green
        Write-Host "  backend:generate:types - Generate Payload TypeScript types" -ForegroundColor White
        Write-Host "  setup           - Show setup status and next steps" -ForegroundColor White
        Write-Host "  check           - Check project configuration" -ForegroundColor White
        Write-Host "  status          - Show complete project status" -ForegroundColor White
        Write-Host ""
        Write-Host "🔗 Supabase:" -ForegroundColor Green
        Write-Host "  supabase:setup  - Interactive Supabase configuration setup" -ForegroundColor White
        Write-Host "  supabase:test   - Test database connection to Supabase" -ForegroundColor White
        Write-Host ""
        Write-Host "🔄 Database Sync:" -ForegroundColor Green
        Write-Host "  db:pull         - Pull database from Supabase to local" -ForegroundColor White
        Write-Host "  db:push         - Push database from local to Supabase" -ForegroundColor White
        Write-Host "  db:switch       - Switch between local and Supabase database" -ForegroundColor White
        Write-Host "  db:status       - Show current database configuration" -ForegroundColor White
        Write-Host ""
        Write-Host "🐍 Python (UV):" -ForegroundColor Green
        Write-Host "  python:install  - Install Python dependencies with uv" -ForegroundColor White
        Write-Host "  python:install:dev - Install with development dependencies" -ForegroundColor White
        Write-Host "  python:venv     - Create Python virtual environment" -ForegroundColor White
        Write-Host "  python:test     - Run Python tests" -ForegroundColor White
        Write-Host ""
        Write-Host "🔧 Service Management:" -ForegroundColor Green
        Write-Host "  services:start  - Start all services" -ForegroundColor White
        Write-Host "  services:stop   - Stop all services" -ForegroundColor White
        Write-Host "  services:status - Show services status" -ForegroundColor White
        Write-Host "  services:logs   - Show services logs" -ForegroundColor White
        Write-Host ""
        Write-Host "🤖 MCP (Model Context Protocol):" -ForegroundColor Green
        Write-Host "  mcp:install     - Install MCP server dependencies" -ForegroundColor White
        Write-Host "  mcp:test        - Test MCP server connections" -ForegroundColor White
        Write-Host "  mcp:status      - Check MCP configuration status" -ForegroundColor White
        Write-Host "  mcp:setup       - Show MCP setup instructions" -ForegroundColor White
        Write-Host ""
        Write-Host "Usage: .\dev-scripts.ps1 <command>" -ForegroundColor Blue
        Write-Host "Note: Run 'flox activate' first to enter the development environment" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "💡 Windows-specific notes:" -ForegroundColor Blue
        Write-Host "  - Use PowerShell 5.1 or later" -ForegroundColor White
        Write-Host "  - Python virtual env activates with: .venv\Scripts\Activate.ps1" -ForegroundColor White
        Write-Host "  - Some database scripts may fall back to bash if PowerShell versions are missing" -ForegroundColor White
    }
    default {
        Write-Host "❌ Unknown command: $Command" -ForegroundColor Red
        Write-Host "Run '.\dev-scripts.ps1 help' to see available commands." -ForegroundColor Blue
    }
}