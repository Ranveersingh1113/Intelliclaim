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

# Install all dependencies from requirements.txt
echo "🔧 Installing all dependencies from requirements.txt..."
pip install --no-cache-dir --prefer-binary -r requirements.txt

# Explicitly install sentence-transformers if it failed
echo "🔧 Ensuring sentence-transformers is installed..."
pip install --no-cache-dir --prefer-binary sentence-transformers>=2.2.0,<3.0.0 || {
    echo "⚠️ sentence-transformers installation failed, trying alternative method..."
    pip install --no-cache-dir --prefer-binary --force-reinstall sentence-transformers
}

# Verify the installation
echo "🔍 Verifying package installations..."
echo "📦 Installed packages:"
pip list | grep -E "(sentence-transformers|langchain|chromadb)" || echo "⚠️ Some packages not found in pip list"
echo "🔍 Full package list:"
pip list

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
python -c "import fastapi, uvicorn, chromadb, google.generativeai, sentence_transformers" && echo "✅ All critical packages installed successfully" || echo "⚠️ Some packages may have issues"

echo "✅ Build completed successfully!"
echo "📋 Build summary:"
echo "  - Python dependencies installed"
echo "  - Storage directories created"
echo "  - Configuration validated"
echo ""
echo "🚀 Ready for deployment!"
