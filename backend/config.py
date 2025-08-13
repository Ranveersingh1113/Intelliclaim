"""
Configuration settings for IntelliClaim system
"""

import os
from typing import Dict, Any

class Config:
    # API Configuration
    API_TITLE = "IntelliClaim RAG API"
    API_VERSION = "1.0.0"
    API_HOST = "0.0.0.0"
    API_PORT = 8000
    
    # Model Configuration
    EMBEDDING_MODEL = "BAAI/bge-m3"
    LLM_MODEL = "gemini-1.5-flash"
    
    # Document Processing
    CHUNK_SIZE = 2000
    CHUNK_OVERLAP = 100
    MAX_FILE_SIZE = 50 * 1024 * 1024  # 50MB
    
    # Vector Store
    VECTOR_STORE_PATH = "./chroma_db"
    UPLOAD_PATH = "./uploads"
    
    # Retrieval Settings
    TOP_K_DOCUMENTS = 5
    SIMILARITY_THRESHOLD = 0.7
    
    # Processing Settings
    MAX_PROCESSING_TIME = 30  # seconds
    BATCH_SIZE = 50
    
    # Security
    ALLOWED_ORIGINS = ["*"]  # Configure for production
    API_KEY_HEADER = "X-API-Key"
    
    # Logging
    LOG_LEVEL = "INFO"
    LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    
    # Feature Flags
    ENABLE_CACHING = True
    ENABLE_RATE_LIMITING = False
    ENABLE_AUDIT_TRAIL = True
    ENABLE_EXPLAINABILITY = True
    
    @classmethod
    def get_model_config(cls) -> Dict[str, Any]:
        return {
            "embedding_model": cls.EMBEDDING_MODEL,
            "llm_model": cls.LLM_MODEL,
            "chunk_size": cls.CHUNK_SIZE,
            "chunk_overlap": cls.CHUNK_OVERLAP,
            "top_k": cls.TOP_K_DOCUMENTS,
            "similarity_threshold": cls.SIMILARITY_THRESHOLD
        }
    
    @classmethod
    def get_api_config(cls) -> Dict[str, Any]:
        return {
            "title": cls.API_TITLE,
            "version": cls.API_VERSION,
            "host": cls.API_HOST,
            "port": cls.API_PORT
        }

class DevelopmentConfig(Config):
    DEBUG = True
    LOG_LEVEL = "DEBUG"
    ENABLE_RATE_LIMITING = False

class ProductionConfig(Config):
    DEBUG = False
    LOG_LEVEL = "WARNING"
    ENABLE_RATE_LIMITING = True
    ALLOWED_ORIGINS = [
        "https://yourdomain.com",
        "https://www.yourdomain.com"
    ]

# Environment-based configuration
def get_config():
    env = os.getenv("ENVIRONMENT", "development").lower()
    if env == "production":
        return ProductionConfig()
    return DevelopmentConfig() 