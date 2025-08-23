const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://intelliclaim-backend.onrender.com';

export const API_ENDPOINTS = {
  QUERY: `${API_BASE_URL}/query`,
  UPLOAD: `${API_BASE_URL}/upload`,
  HEALTH: `${API_BASE_URL}/health`,
};

export default API_BASE_URL;
