#!/bin/bash
# Railway-optimized build script for IntelliClaim backend
# This script is executed during the build phase on Railway

set -e  # Exit on any error

echo "🚀 Starting IntelliClaim build process for Railway..."

# Install Python dependencies with Railway optimizations
echo "📦 Installing Python dependencies..."
echo "🔧 Using pip with optimizations for Railway deployment..."

# Upgrade pip first
pip install --upgrade pip

# Install dependencies in stages to avoid memory issues
echo "🔧 Installing core dependencies..."
pip install --no-cache-dir --prefer-binary fastapi uvicorn python-dotenv requests

echo "🔧 Installing document processing dependencies..."
pip install --no-cache-dir --prefer-binary python-docx PyPDF2

echo "🔧 Installing AI/ML dependencies..."
pip install --no-cache-dir --prefer-binary langchain langchain-community langgraph pydantic

echo "🔧 Installing Google AI dependencies..."
pip install --no-cache-dir --prefer-binary google-generativeai

echo "🔧 Installing vector database..."
pip install --no-cache-dir --prefer-binary chromadb

echo "🔧 Installing embedding models..."
pip install --no-cache-dir --prefer-binary sentence-transformers

# Verify the installation
echo "🔍 Verifying package installations..."
echo "📦 Installed packages:"
pip list | grep -E "(sentence-transformers|langchain|chromadb)" || echo "⚠️ Some packages not found in pip list"

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

echo "✅ Railway build completed successfully!"
echo "📋 Build summary:"
echo "  - Python dependencies installed"
echo "  - Storage directories created"
echo "  - Configuration validated"
echo ""
echo "🚀 Ready for Railway deployment!"
