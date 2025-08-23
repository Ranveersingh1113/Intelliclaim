const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';

export const API_ENDPOINTS = {
  QUERY: `${API_BASE_URL}/query`,
  UPLOAD: `${API_BASE_URL}/upload`,
  HEALTH: `${API_BASE_URL}/health`,
};

export default API_BASE_URL;
