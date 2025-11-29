#!/bin/bash

# Development scripts for PBP project
# Run these commands from the project root after activating flox environment

echo "🚀 PBP Development Scripts"
echo "========================="
echo ""

case "$1" in
    "frontend:dev")
        echo "Starting Astro development server..."
        if [ -n "$_FLOX_ACTIVE_ENVIRONMENTS" ]; then
            flox services start frontend
        else
            echo "⚠️  Please run this command from within the activated flox environment:"
            echo "   flox activate"
            echo "   ./dev-scripts.sh frontend:dev"
        fi
        ;;
    "frontend:build")
        echo "Building Astro project..."
        cd frontend && npm run build
        ;;
    "frontend:preview")
        echo "Starting Astro preview server..."
        cd frontend && npm run preview
        ;;
    "backend:dev")
        echo "Starting Payload CMS development server..."
        if [ -n "$_FLOX_ACTIVE_ENVIRONMENTS" ]; then
            flox services start backend
        else
            echo "⚠️  Please run this command from within the activated flox environment:"
            echo "   flox activate"
            echo "   ./dev-scripts.sh backend:dev"
        fi
        ;;
    "backend:build")
        echo "Building Payload CMS project..."
        cd backend && npm run build
        ;;
    "backend:generate:types")
        echo "Generating Payload CMS TypeScript types..."
        cd backend && npm run generate:types
        ;;
    "dev")
        echo "Starting both frontend and backend servers..."
        echo "📡 Backend will start on http://localhost:3000"
        echo "🌐 Frontend will start on http://localhost:4321"
        echo ""
        
        if [ -n "$_FLOX_ACTIVE_ENVIRONMENTS" ]; then
            echo "Press Ctrl+C to stop all servers"
            echo ""
            # Use flox services to start both services
            flox services start backend frontend
        else
            echo "💡 To start both services, use:"
            echo "   flox activate --start-services"
            echo ""
            echo "Or activate first, then start:"
            echo "   flox activate"
            echo "   ./dev-scripts.sh dev"
        fi
        ;;
    "setup")
        echo "Setting up development environment..."
        echo "✅ Flox environment initialized with Node.js & Python"
        echo "✅ Astro project created in frontend/"
        echo "✅ Payload CMS created in backend/"
        echo "📝 Next steps:"
        echo "   1. Copy .env.example to .env and configure your Supabase credentials"
        echo "   2. Run './dev-scripts.sh dev' to start both servers"
        echo "   3. Visit http://localhost:3000/admin to set up your first admin user"
        ;;
    "check")
        echo "Checking project status..."
        echo ""
        
        # Check flox environment
        if command -v flox >/dev/null 2>&1; then
            echo "✅ Flox environment: Available"
        else
            echo "❌ Flox environment: Not available"
        fi
        
        # Check frontend
        if [ -f "frontend/package.json" ]; then
            echo "✅ Frontend (Astro): Set up"
        else
            echo "❌ Frontend (Astro): Not found"
        fi
        
        # Check backend
        if [ -f "backend/package.json" ]; then
            echo "✅ Backend (Payload CMS): Set up"
        else
            echo "❌ Backend (Payload CMS): Not found"
        fi
        
        # Check environment files
        if [ -f ".env" ]; then
            echo "✅ Environment file: Configured"
            
            # Check if DATABASE_URI is set
            if grep -q "DATABASE_URI=postgresql" .env 2>/dev/null; then
                echo "✅ Supabase configuration: Found"
            else
                echo "⚠️  Supabase configuration: DATABASE_URI not configured"
            fi
        else
            echo "⚠️  Environment file: Run ./setup-supabase.sh to configure"
        fi
        ;;
    "supabase:setup")
        echo "Starting Supabase setup..."
        ./setup-supabase.sh
        ;;
    "supabase:test")
        echo "Testing Supabase database connection..."
        if [ ! -f ".env" ]; then
            echo "❌ .env file not found! Run ./setup-supabase.sh first."
            exit 1
        fi
        if [ -n "$_FLOX_ACTIVE_ENVIRONMENTS" ]; then
            flox services start db-test
        else
            echo "⚠️  Please run this command from within the activated flox environment:"
            echo "   flox activate"
            echo "   ./dev-scripts.sh supabase:test"
        fi
        ;;
    "status")
        echo "📊 PBP-v01 Project Status"
        echo "========================"
        echo ""
        echo "🎯 Project: Astro + PayloadCMS + Supabase Monorepo"
        echo "📅 Setup Date: $(date '+%Y-%m-%d')"
        echo ""
        
        # Check all components
        echo "Component Status:"
        if [ -f "frontend/package.json" ]; then
            echo "  ✅ Frontend (Astro): Ready"
        else
            echo "  ❌ Frontend (Astro): Missing"
        fi
        
        if [ -f "backend/package.json" ]; then
            echo "  ✅ Backend (PayloadCMS): Ready"
        else
            echo "  ❌ Backend (PayloadCMS): Missing"
        fi
        
        if [ -f ".env" ] && grep -q "SUPABASE_PROJECT_ID" .env; then
            echo "  ✅ Database (Supabase): Configured"
        else
            echo "  ❌ Database (Supabase): Not configured"
        fi
        
        if command -v flox >/dev/null 2>&1; then
            echo "  ✅ Environment (Flox): Active"
        else
            echo "  ❌ Environment (Flox): Not available"
        fi
        
        echo ""
        echo "📋 Quick Commands:"
        echo "  ./dev-scripts.sh dev        - Start both services"
        echo "  ./dev-scripts.sh check      - Verify configuration"
        echo "  ./dev-scripts.sh help       - Show all commands"
        echo ""
        echo "🌐 Access Points (when running):"
        echo "  Frontend:    http://localhost:4321"
        echo "  Backend:     http://localhost:3000/admin"
        echo "  API:         http://localhost:3000/api"
        echo "  Test Page:   http://localhost:4321/api-test"
        ;;
    "services:start")
        echo "Starting all flox services..."
        if [ -n "$_FLOX_ACTIVE_ENVIRONMENTS" ]; then
            flox services start
        else
            echo "⚠️  Please run this command from within the activated flox environment:"
            echo "   flox activate"
            echo "   ./dev-scripts.sh services:start"
            echo ""
            echo "Or use: flox activate --start-services"
        fi
        ;;
    "services:stop")
        echo "Stopping all flox services..."
        if [ -n "$_FLOX_ACTIVE_ENVIRONMENTS" ]; then
            flox services stop
        else
            echo "⚠️  Please run this command from within the activated flox environment:"
            echo "   flox activate"
            echo "   ./dev-scripts.sh services:stop"
        fi
        ;;
    "services:status")
        echo "Checking flox services status..."
        if [ -n "$_FLOX_ACTIVE_ENVIRONMENTS" ]; then
            flox services status
        else
            echo "⚠️  Please run this command from within the activated flox environment:"
            echo "   flox activate"
            echo "   ./dev-scripts.sh services:status"
        fi
        ;;
    "services:logs")
        echo "Showing flox services logs..."
        if [ -n "$_FLOX_ACTIVE_ENVIRONMENTS" ]; then
            flox services logs
        else
            echo "⚠️  Please run this command from within the activated flox environment:"
            echo "   flox activate"
            echo "   ./dev-scripts.sh services:logs"
        fi
        ;;
    "python:install")
        echo "Installing Python dependencies with uv..."
        uv pip install -e .
        ;;
    "python:install:dev")
        echo "Installing Python dependencies with development tools..."
        uv pip install -e ".[dev]"
        ;;
    "python:venv")
        echo "Creating Python virtual environment with uv..."
        uv venv
        echo "Activate with: source .venv/bin/activate"
        ;;
    "python:test")
        echo "Running Python tests..."
        if [ -d ".venv" ]; then
            source .venv/bin/activate
        fi
        python -m pytest
        ;;
    "mcp:install")
        echo "Installing MCP server dependencies..."
        echo "This will install the required MCP servers globally."
        echo ""
        npm install -g @modelcontextprotocol/server-memory \
                       @modelcontextprotocol/server-postgres \
                       @modelcontextprotocol/server-sequential-thinking \
                       enhanced-postgres-mcp-server
        echo ""
        echo "✅ MCP servers installed successfully!"
        echo "📖 Next: Configure Warp MCP settings or read MCP_SETUP.md for other AI tools"
        ;;
    "mcp:test")
        echo "Testing MCP server connections..."
        echo ""
        
        # Test each MCP server
        echo "Testing memory server..."
        if npx @modelcontextprotocol/server-memory --version > /dev/null 2>&1; then
            echo "  ✅ Memory server: Available"
        else
            echo "  ❌ Memory server: Not found"
        fi
        
        echo "Testing postgres server..."
        if npx @modelcontextprotocol/server-postgres --version > /dev/null 2>&1; then
            echo "  ✅ Postgres server: Available"
        else
            echo "  ❌ Postgres server: Not found"
        fi
        
        echo "Testing sequential-thinking server..."
        if npx @modelcontextprotocol/server-sequential-thinking --version > /dev/null 2>&1; then
            echo "  ✅ Sequential-thinking server: Available"
        else
            echo "  ❌ Sequential-thinking server: Not found"
        fi
        
        echo "Testing enhanced-postgres server..."
        if npx enhanced-postgres-mcp-server --version > /dev/null 2>&1; then
            echo "  ✅ Enhanced-postgres server: Available"
        else
            echo "  ❌ Enhanced-postgres server: Not found"
        fi
        ;;
    "mcp:status")
        echo "📊 MCP Configuration Status"
        echo "==========================="
        echo ""
        
        # Check configuration files
        if [ -f "mcp.json" ]; then
            echo "✅ MCP configuration: Found (mcp.json)"
        else
            echo "❌ MCP configuration: Missing (mcp.json)"
        fi
        
        if [ -f "mcp-resources.json" ]; then
            echo "✅ MCP resources: Found (mcp-resources.json)"
        else
            echo "❌ MCP resources: Missing (mcp-resources.json)"
        fi
        
        if [ -f "MCP_SETUP.md" ]; then
            echo "✅ MCP documentation: Found (MCP_SETUP.md)"
        else
            echo "❌ MCP documentation: Missing (MCP_SETUP.md)"
        fi
        
        echo ""
        echo "📋 Configuration Summary:"
        if [ -f "mcp.json" ]; then
            echo "  • Memory server: Configured"
            echo "  • PostgreSQL server: Configured"
            echo "  • Sequential-thinking server: Configured"
            echo "  • Enhanced PostgreSQL server: Configured"
        fi
        
        # Check Warp configuration
        if [ -f "/Users/alejo/Library/Application Support/dev.warp.Warp-Stable/mcp_servers.json" ]; then
            echo "  • Warp MCP configuration: Found"
        else
            echo "  • Warp MCP configuration: Missing"
        fi
        
        echo ""
        echo "🔗 Next Steps:"
        echo "  1. Run './dev-scripts.sh mcp:install' to install servers"
        echo "  2. Configure your AI tool (see MCP_SETUP.md)"
        echo "  3. Test with './dev-scripts.sh mcp:test'"
        ;;
    "mcp:setup")
        echo "🤖 MCP Setup Instructions"
        echo "========================"
        echo ""
        echo "Your project is configured with Model Context Protocol (MCP) support!"
        echo ""
        echo "📁 Configuration Files:"
        echo "  • mcp.json          - Main MCP server configuration"
        echo "  • mcp-resources.json - Project-specific resource definitions"
        echo "  • MCP_SETUP.md      - Detailed setup guide"
        echo ""
        echo "🚀 Quick Setup:"
        echo "  1. Install MCP servers:    ./dev-scripts.sh mcp:install"
        echo "  2. Test installation:      ./dev-scripts.sh mcp:test"
        echo "  3. Check status:           ./dev-scripts.sh mcp:status"
        echo ""
        echo "📖 For detailed instructions, see: MCP_SETUP.md"
        echo "🔧 Configure your AI tool with the MCP servers to get enhanced assistance!"
        ;;
    "db:pull")
        echo "Pulling database from Supabase to local..."
        ./scripts/db-pull.sh
        ;;
    "db:push")
        echo "Pushing database from local to Supabase..."
        ./scripts/db-push.sh
        ;;
    "db:switch")
        if [ -z "$2" ]; then
            ./scripts/db-switch.sh
        else
            ./scripts/db-switch.sh "$2"
        fi
        ;;
    "db:status")
        ./scripts/db-switch.sh status
        ;;
    "help"|*)
        echo "Available commands:"
        echo ""
        echo "🚀 Development:"
        echo "  dev             - Start both frontend and backend servers"
        echo "  frontend:dev    - Start Astro dev server only"
        echo "  backend:dev     - Start Payload CMS dev server only"
        echo ""
        echo "🔨 Build:"
        echo "  frontend:build  - Build Astro project"
        echo "  backend:build   - Build Payload CMS project"
        echo "  frontend:preview - Preview built Astro project"
        echo ""
        echo "⚙️  Utils:"
        echo "  backend:generate:types - Generate Payload TypeScript types"
        echo "  setup           - Show setup status and next steps"
        echo "  check           - Check project configuration"
        echo "  status          - Show complete project status"
        echo ""
        echo "🔗 Supabase:"
        echo "  supabase:setup  - Interactive Supabase configuration setup"
        echo "  supabase:test   - Test database connection to Supabase"
        echo ""
        echo "🔄 Database Sync:"
        echo "  db:pull         - Pull database from Supabase to local"
        echo "  db:push         - Push database from local to Supabase"
        echo "  db:switch       - Switch between local and Supabase database"
        echo "  db:status       - Show current database configuration"
        echo ""
        echo "🐍 Python (UV):"
        echo "  python:install  - Install Python dependencies with uv"
        echo "  python:install:dev - Install with development dependencies"
        echo "  python:venv     - Create Python virtual environment"
        echo "  python:test     - Run Python tests"
        echo ""
        echo "🔧 Service Management:"
        echo "  services:start  - Start all services"
        echo "  services:stop   - Stop all services"
        echo "  services:status - Show services status"
        echo "  services:logs   - Show services logs"
        echo ""
        echo "🤖 MCP (Model Context Protocol):"
        echo "  mcp:install     - Install MCP server dependencies"
        echo "  mcp:test        - Test MCP server connections"
        echo "  mcp:status      - Check MCP configuration status"
        echo "  mcp:setup       - Show MCP setup instructions"
        echo ""
        echo "Usage: ./dev-scripts.sh <command>"
        echo "Note: Run 'flox activate' first to enter the development environment"
        ;;
esac
