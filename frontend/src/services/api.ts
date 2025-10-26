import axios from 'axios';
import type { Ingredient, CartItem, Order, IngredientsResponse, IngredientCategory } from '../types';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080';

// Debug: Log the API URL to help with troubleshooting
console.log('🌐 API Configuration:');
console.log('  - API_BASE_URL:', API_BASE_URL);
console.log('  - VITE_API_BASE_URL env var:', import.meta.env.VITE_API_BASE_URL);
console.log('  - Environment mode:', import.meta.env.MODE);
console.log('  - Expected backend:', 'http://135.220.213.50');

const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 10000, // 10 second timeout
});

// Request interceptor for logging
apiClient.interceptors.request.use(
  (config: any) => {
    console.log(`🚀 API Request: ${config.method?.toUpperCase()} ${config.baseURL}${config.url}`);
    return config;
  },
  (error: any) => {
    console.error('❌ API Request Error:', error);
    return Promise.reject(error);
  }
);

// Response interceptor for logging
apiClient.interceptors.response.use(
  (response: any) => {
    console.log(`✅ API Response: ${response.status} ${response.config.method?.toUpperCase()} ${response.config.url}`);
    return response;
  },
  (error: any) => {
    console.error('❌ API Response Error:', {
      status: error.response?.status,
      url: error.config?.url,
      message: error.message,
      baseURL: error.config?.baseURL
    });
    return Promise.reject(error);
  }
);

// Ingredients APIs
export const getIngredients = async (): Promise<IngredientsResponse | Ingredient[]> => {
  const response = await apiClient.get<Ingredient[]>('/api/ingredients');
  return response.data;
};

export const getIngredientsByCategory = async (category: IngredientCategory): Promise<Ingredient[]> => {
  const response = await apiClient.get<Ingredient[]>(`/api/ingredients/${category}`);
  return response.data;
};

// Cart APIs
export const addToCart = async (item: {
  sessionId: string;
  ingredientId: number;
  quantity: number;
  burgerLayers?: { ingredientId: number; layerOrder: number; quantity: number }[];
}): Promise<CartItem> => {
  const response = await apiClient.post<CartItem>('/api/cart/items', item);
  return response.data;
};

export const getCart = async (sessionId: string): Promise<CartItem[]> => {
  const response = await apiClient.get<CartItem[]>(`/api/cart/${sessionId}`);
  return response.data;
};

export const removeCartItem = async (itemId: number): Promise<void> => {
  await apiClient.delete(`/api/cart/items/${itemId}`);
};

// Order APIs
export const createOrder = async (orderData: {
  sessionId: string;
  customerName: string;
  customerEmail: string;
  customerPhone: string;
  cartItemIds: number[];
}): Promise<Order> => {
  const response = await apiClient.post<Order>('/api/orders', orderData);
  return response.data;
};

export const getOrder = async (orderId: string): Promise<Order> => {
  const response = await apiClient.get<Order>(`/api/orders/${orderId}`);
  return response.data;
};

// Order History APIs
export const getOrderHistory = async (email?: string): Promise<Order[]> => {
  const params = email ? { email } : {};
  const response = await apiClient.get<Order[]>('/api/orders/history', { params });
  return response.data;
};

export const getOrdersByCustomerEmail = async (email: string): Promise<Order[]> => {
  const response = await apiClient.get<Order[]>(`/api/orders/customer/${email}`);
  return response.data;
};

export const getOrdersBySession = async (sessionId: string): Promise<Order[]> => {
  const response = await apiClient.get<Order[]>(`/api/orders/session/${sessionId}`);
  return response.data;
};

export default apiClient;

