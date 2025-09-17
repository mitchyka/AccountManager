# AccountManager

## Описание
Приложение на Vue 3 с Pinia и TypeScript для управления учетными записями (LDAP/Local). Хранит данные в localStorage. Поддерживает добавление, редактирование, удаление аккаунтов с валидацией.

## Требования
- Node.js 16+
- Vue CLI или Vite

## Установка
1. Создайте проект: `vue create accounts-app` (или Vite: `npm init vue@latest`).
2. Установите Pinia: `npm install pinia`.
3. Скопируйте файлы в проект:
   - `src/stores/accounts.ts`
   - `src/components/AccountItem.vue`
   - `src/App.vue` (замените существующий)
4. В `main.ts` добавьте:
   ```typescript
   import { createPinia } from 'pinia';
   app.use(createPinia());
