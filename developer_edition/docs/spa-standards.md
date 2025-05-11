# SPA Standards

This document outlines the standards for developing and maintaining Single Page Applications (SPAs) within the stage0 platform.

## Architecture Overview

### Technology Stack
- Vue.js 3.x
- TypeScript
- Vite for build tooling
- Pinia for state management
- Vue Router for routing
- Axios for HTTP client

### Project Structure
```
/
├── src/
│   ├── assets/              # Static assets
│   ├── components/          # Reusable Vue components
│   │   ├── common/         # Shared components
│   │   └── features/       # Feature-specific components
│   ├── composables/        # Vue composables
│   ├── router/             # Route definitions
│   ├── stores/             # Pinia stores
│   ├── types/              # TypeScript type definitions
│   ├── utils/              # Utility functions
│   ├── views/              # Page components
│   ├── App.vue            # Root component
│   └── main.ts            # Application entry point
├── public/                 # Public static files
├── tests/                  # Test files
│   ├── unit/              # Unit tests
│   └── e2e/               # End-to-end tests
└── vite.config.ts         # Vite configuration
```

## Development Standards

### Component Structure
- Use Composition API with `<script setup>`
- Define props and emits explicitly
- Use TypeScript for type safety
- Follow single responsibility principle

Example:
```vue
<script setup lang="ts">
import { ref } from 'vue'
import type { PropType } from 'vue'

interface User {
  id: string
  name: string
}

const props = defineProps<{
  user: User
}>()

const emit = defineEmits<{
  (e: 'update', user: User): void
}>()

const localUser = ref<User>(props.user)
</script>

<template>
  <div class="user-card">
    <h2>{{ localUser.name }}</h2>
    <!-- Component content -->
  </div>
</template>

<style scoped>
.user-card {
  /* Component styles */
}
</style>
```

### State Management
- Use Pinia for global state
- Keep stores focused and minimal
- Use TypeScript for store definitions
- Implement proper error handling

Example:
```typescript
import { defineStore } from 'pinia'
import type { User } from '@/types'

export const useUserStore = defineStore('user', {
  state: () => ({
    currentUser: null as User | null,
    loading: false,
    error: null as string | null
  }),
  
  actions: {
    async fetchUser(id: string) {
      this.loading = true
      try {
        const response = await api.get(`/users/${id}`)
        this.currentUser = response.data
      } catch (error) {
        this.error = 'Failed to fetch user'
      } finally {
        this.loading = false
      }
    }
  }
})
```

### API Communication
- Use Axios for HTTP requests
- Implement request/response interceptors
- Handle errors consistently
- Use TypeScript interfaces for API responses

Example:
```typescript
import axios from 'axios'
import type { AxiosInstance } from 'axios'

const api: AxiosInstance = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL,
  timeout: 5000
})

api.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  error => Promise.reject(error)
)

api.interceptors.response.use(
  response => response,
  error => {
    if (error.response?.status === 401) {
      // Handle unauthorized
    }
    return Promise.reject(error)
  }
)
```

### Routing
- Use Vue Router for navigation
- Implement route guards for authentication
- Use lazy loading for routes
- Keep route definitions organized

Example:
```typescript
import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: () => import('@/views/Home.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/login',
    component: () => import('@/views/Login.vue')
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth && !isAuthenticated()) {
    next('/login')
  } else {
    next()
  }
})
```

## Testing Standards

### Unit Testing
- Use Vitest for unit tests
- Test components in isolation
- Mock external dependencies
- Maintain high test coverage

Example:
```typescript
import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import UserCard from '@/components/UserCard.vue'

describe('UserCard', () => {
  it('renders user name correctly', () => {
    const user = { id: '1', name: 'John Doe' }
    const wrapper = mount(UserCard, {
      props: { user }
    })
    expect(wrapper.text()).toContain('John Doe')
  })
})
```

### E2E Testing
- Use Cypress for E2E tests
- Test critical user flows
- Maintain test data
- Use TypeScript for tests

## Build and Deployment

### Development
- Use Vite for development server
- Implement hot module replacement
- Use environment variables for configuration
- Follow consistent code formatting

### Production
- Optimize bundle size
- Implement proper caching
- Use CDN for static assets
- Enable source maps for debugging

## Performance Standards

### Code Splitting
- Implement route-based code splitting
- Lazy load components when possible
- Optimize initial bundle size

### Asset Optimization
- Compress images
- Use modern image formats
- Implement proper caching strategies
- Minimize third-party dependencies

## Accessibility

### Standards
- Follow WCAG 2.1 guidelines
- Implement proper ARIA attributes
- Ensure keyboard navigation
- Maintain proper color contrast

### Testing
- Use automated accessibility testing
- Perform manual testing
- Test with screen readers
- Validate keyboard navigation

## Security

### Best Practices
- Implement proper authentication
- Use HTTPS
- Sanitize user input
- Prevent XSS attacks
- Implement proper CORS policies

### Data Protection
- Encrypt sensitive data
- Implement proper session management
- Follow security headers best practices
- Regular security audits 