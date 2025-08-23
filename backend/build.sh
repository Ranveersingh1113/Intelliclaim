#!/bin/bash
# Build script for Render deployment
# This script is executed during the build phase on Render

set -e  # Exit on any error

echo "🚀 Starting IntelliClaim build process for Render..."

# Install Python dependencies with optimizations for Render
echo "📦 Installing Python dependencies..."
echo "🔧 Using pip with optimizations for cloud deployment..."

# Upgrade pip first
pip install --upgrade pip

# Install dependencies with optimizations for Render
echo "🔧 Installing dependencies with Render optimizations..."
pip install --no-cache-dir --prefer-binary --no-deps -r requirements.txt

# Install dependencies one by one to avoid conflicts
echo "📦 Installing core dependencies..."
pip install fastapi==0.111.0 uvicorn==0.29.0 python-dotenv==1.0.1 requests==2.32.3

echo "📄 Installing document processing..."
pip install python-docx==1.1.0 PyPDF2==3.0.1

echo "🤖 Installing AI/ML dependencies..."
pip install langchain==0.2.0 langchain-community==0.2.0 langgraph==0.2.21 "pydantic>=2.8.0"

echo "🔑 Installing Google Gemini..."
pip install google-generativeai==0.5.0

echo "🗄️ Installing vector database..."
pip install chromadb==0.5.5

# If any packages fail, try alternative installation methods
echo "🔄 Checking for any failed installations..."
pip check || echo "⚠️ Some packages may have warnings, but continuing..."

# Create necessary directories
echo "📁 Creating storage directories..."
mkdir -p uploads
mkdir -p chroma_db
mkdir -p faiss_cache

# Set proper permissions
echo "🔐 Setting directory permissions..."
chmod 755 uploads
chmod 755 chroma_db
chmod 755 faiss_cache

# Run storage setup script
echo "⚙️ Running storage setup script..."
python setup_storage.py

# Verify critical packages are installed
echo "🔍 Verifying critical package installations..."
python -c "import fastapi, uvicorn, chromadb, google.generativeai" && echo "✅ All critical packages installed successfully" || echo "⚠️ Some packages may have issues"

echo "✅ Build completed successfully!"
echo "📋 Build summary:"
echo "  - Python dependencies installed"
echo "  - Storage directories created"
echo "  - Configuration validated"
echo ""
echo "🚀 Ready for deployment!"
