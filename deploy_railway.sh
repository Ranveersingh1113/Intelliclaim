#!/bin/bash
# Quick Railway deployment script for IntelliClaim

echo "🚂 Railway Deployment Script for IntelliClaim"
echo "=============================================="

# Check if Railway CLI is installed
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI not found. Installing..."
    npm install -g @railway/cli
else
    echo "✅ Railway CLI found"
fi

# Check if user is logged in
if ! railway whoami &> /dev/null; then
    echo "🔐 Please login to Railway..."
    railway login
else
    echo "✅ Already logged in to Railway"
fi

echo ""
echo "📋 Next steps:"
echo "1. Go to https://railway.app"
echo "2. Create new project from GitHub repo"
echo "3. Set root directory to 'backend'"
echo "4. Set build command: chmod +x railway_build.sh && ./railway_build.sh"
echo "5. Set start command: python setup_storage.py && uvicorn app:app --host 0.0.0.0 --port \$PORT"
echo "6. Add environment variables (see RAILWAY_DEPLOYMENT.md)"
echo "7. Deploy!"
echo ""
echo "🔗 After deployment, update your frontend API configuration with the Railway URL"
echo "📖 See RAILWAY_DEPLOYMENT.md for detailed instructions"
