import React, { useEffect, useState } from 'react';
import { getIngredients } from '../../services/api';

interface ApiTestProps {}

const ApiTest: React.FC<ApiTestProps> = () => {
  const [status, setStatus] = useState<'loading' | 'success' | 'error'>('loading');
  const [data, setData] = useState<any>(null);
  const [error, setError] = useState<string>('');

  useEffect(() => {
    const testApiConnection = async () => {
      try {
        console.log('🧪 Testing API connection...');
        const ingredients = await getIngredients();
        console.log('✅ API test successful:', ingredients);
        setData(ingredients);
        setStatus('success');
      } catch (err: any) {
        console.error('❌ API test failed:', err);
        setError(err.message || 'Unknown error');
        setStatus('error');
      }
    };

    testApiConnection();
  }, []);

  return (
    <div style={{ 
      padding: '20px', 
      margin: '20px', 
      border: '2px solid #ccc', 
      borderRadius: '8px',
      backgroundColor: '#f9f9f9'
    }}>
      <h3>🔗 API Connection Test</h3>
      <p><strong>Backend URL:</strong> {import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080'}</p>
      <p><strong>Environment:</strong> {import.meta.env.MODE}</p>
      
      {status === 'loading' && <p>⏳ Testing connection...</p>}
      
      {status === 'success' && (
        <div>
          <p style={{ color: 'green' }}>✅ API Connection Successful!</p>
          <p>Retrieved {Array.isArray(data) ? data.length : 'unknown'} ingredients</p>
        </div>
      )}
      
      {status === 'error' && (
        <div>
          <p style={{ color: 'red' }}>❌ API Connection Failed</p>
          <p><strong>Error:</strong> {error}</p>
          <p><strong>Check:</strong> Make sure backend is running at http://135.220.213.50</p>
        </div>
      )}
    </div>
  );
};

export default ApiTest;