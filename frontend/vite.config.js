import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0', // Allow access from Docker
    port: 3000,      // Expose port 3000
    watch: {
      usePolling: true, // Use polling for file changes in Docker
    },
  },
});
