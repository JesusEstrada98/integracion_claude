#!/bin/bash

# Interactive Supabase Setup Script for PBP-v01
# This script helps configure your environment variables for Supabase integration

echo "🚀 PBP-v01 Supabase Setup"
echo "========================="
echo ""
echo "This script will help you configure Supabase integration."
echo "Make sure you have created a Supabase project first!"
echo ""

# Check if .env already exists
if [ -f ".env" ]; then
    echo "⚠️  .env file already exists!"
    read -p "Do you want to overwrite it? (y/N): " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting setup. You can manually edit your .env file."
        exit 0
    fi
fi

echo ""
echo "📋 Please gather the following from your Supabase dashboard:"
echo "   1. Go to Settings → Database for connection string"
echo "   2. Go to Settings → API for project URL and keys"
echo ""
read -p "Press Enter when you're ready to continue..."

echo ""
echo "🔧 Configuration Setup"
echo "====================="
echo ""

# Get Supabase Project ID
echo "1. Supabase Project ID"
echo "   (e.g., 'abcdefghijklmnop' from your project URL)"
read -p "   Enter your project ID: " SUPABASE_PROJECT_ID

# Validate project ID
if [ -z "$SUPABASE_PROJECT_ID" ]; then
    echo "❌ Project ID cannot be empty!"
    exit 1
fi

# Get Database Password
echo ""
echo "2. Database Password"
echo "   (The password you set when creating the project)"
read -s -p "   Enter your database password: " DB_PASSWORD
echo ""

# Validate password
if [ -z "$DB_PASSWORD" ]; then
    echo "❌ Database password cannot be empty!"
    exit 1
fi

# Get Supabase Anon Key
echo ""
echo "3. Supabase Anon Key"
echo "   (From Settings → API → Project API keys → anon public)"
read -p "   Enter your anon key: " SUPABASE_ANON_KEY

# Validate anon key
if [ -z "$SUPABASE_ANON_KEY" ]; then
    echo "❌ Anon key cannot be empty!"
    exit 1
fi

# Get Service Role Key
echo ""
echo "4. Supabase Service Role Key"
echo "   (From Settings → API → Project API keys → service_role)"
echo "   ⚠️  This is secret - keep it secure!"
read -s -p "   Enter your service role key: " SUPABASE_SERVICE_ROLE_KEY
echo ""

# Validate service role key
if [ -z "$SUPABASE_SERVICE_ROLE_KEY" ]; then
    echo "❌ Service role key cannot be empty!"
    exit 1
fi

# Generate Payload Secret
PAYLOAD_SECRET=$(openssl rand -hex 16 2>/dev/null || head -c 32 /dev/urandom | base64 | tr -d '\\n' | head -c 32)

echo ""
echo "🔐 Generated PAYLOAD_SECRET: $PAYLOAD_SECRET"
echo ""

# Create .env file
echo "📝 Creating .env file..."

cat > .env << EOF
# ===========================================
# PBP-v01 Monorepo Environment Configuration
# ===========================================
# Generated on: $(date)

# ===========================================
# SUPABASE CONFIGURATION
# ===========================================

SUPABASE_PROJECT_ID=$SUPABASE_PROJECT_ID
SUPABASE_URL=https://$SUPABASE_PROJECT_ID.supabase.co
SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY=$SUPABASE_SERVICE_ROLE_KEY

# Database connection (used by PayloadCMS)
DATABASE_URI=postgresql://postgres:$DB_PASSWORD@db.$SUPABASE_PROJECT_ID.supabase.co:5432/postgres?sslmode=require

# ===========================================
# PAYLOAD CMS CONFIGURATION
# ===========================================

PAYLOAD_SECRET=$PAYLOAD_SECRET

# Server URLs
PAYLOAD_PUBLIC_SERVER_URL=http://localhost:3001
NEXT_PUBLIC_PAYLOAD_URL=http://localhost:3001

# ===========================================
# ASTRO FRONTEND CONFIGURATION
# ===========================================

# API endpoints
PUBLIC_API_URL=http://localhost:3001/api
PUBLIC_CMS_URL=http://localhost:3001

# ===========================================
# DEVELOPMENT CONFIGURATION
# ===========================================

# Development server ports
FRONTEND_PORT=4321
BACKEND_PORT=3001

# Node environment
NODE_ENV=development

# ===========================================
# PRODUCTION CONFIGURATION (when deploying)
# ===========================================

# Set these when deploying to production
# PAYLOAD_PUBLIC_SERVER_URL=https://your-backend-domain.com
# PUBLIC_API_URL=https://your-backend-domain.com/api
# PUBLIC_CMS_URL=https://your-backend-domain.com
# NODE_ENV=production
EOF

echo "✅ .env file created successfully!"
echo ""
echo "🔒 Security Note:"
echo "   Your .env file contains sensitive keys and has been added to .gitignore"
echo "   Never commit this file to version control!"
echo ""
echo "🧪 Next Steps:"
echo "   1. Run: flox activate"
echo "   2. Run: ./dev-scripts.sh backend:dev"
echo "   3. Visit: http://localhost:3001/admin"
echo "   4. Create your first admin user"
echo ""
echo "🔧 If there are connection issues:"
echo "   - Verify your Supabase project is active"
echo "   - Check that your IP is allowlisted (or disable IP restrictions for dev)"
echo "   - Confirm your database password is correct"
echo ""
echo "✨ Setup complete! Happy coding!"
