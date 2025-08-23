#!/bin/bash
# Build script for Render deployment
# This script is executed during the build phase on Render

set -e  # Exit on any error

echo "🚀 Starting IntelliClaim build process for Render..."

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install -r requirements.txt

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

echo "✅ Build completed successfully!"
echo "📋 Build summary:"
echo "  - Python dependencies installed"
echo "  - Storage directories created"
echo "  - Configuration validated"
echo ""
echo "🚀 Ready for deployment!"
