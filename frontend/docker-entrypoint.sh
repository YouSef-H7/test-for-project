#!/bin/sh
set -e

# Replace placeholder with actual API base URL in nginx config
if [ -n "$VITE_API_BASE_URL" ]; then
  echo "🔧 Replacing API base URL with: $VITE_API_BASE_URL"
  sed -i "s|__API_BASE_URL__|$VITE_API_BASE_URL|g" /etc/nginx/conf.d/default.conf
else
  echo "⚠️ No VITE_API_BASE_URL provided, using default."
  sed -i "s|__API_BASE_URL__|http://135.220.213.50|g" /etc/nginx/conf.d/default.conf
fi

# Also replace any environment variables in built files if needed
if [ -n "$VITE_API_BASE_URL" ]; then
  echo "🔧 Updating built assets with API URL: $VITE_API_BASE_URL"
  find /usr/share/nginx/html -name "*.js" -type f -exec sed -i "s|__API_BASE_URL__|$VITE_API_BASE_URL|g" {} \;
  find /usr/share/nginx/html -name "*.html" -type f -exec sed -i "s|__API_BASE_URL__|$VITE_API_BASE_URL|g" {} \;
fi

# Display final nginx config for debugging
echo "📋 Final nginx configuration:"
echo "================================"
cat /etc/nginx/conf.d/default.conf
echo "================================"

# Test nginx configuration
echo "🧪 Testing nginx configuration..."
nginx -t

# Start Nginx
echo "🚀 Starting nginx..."
exec nginx -g "daemon off;"
