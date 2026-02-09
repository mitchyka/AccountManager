<script setup lang="ts">
import { onMounted } from 'vue';
import { useAccountStore } from '@/stores/accountStore';
import AccountRow from '@/components/AccountRow.vue';

const store = useAccountStore();

onMounted(() => {
  store.loadAccounts();
});

const handleAddAccount = () => {
  store.addAccount();
};
</script>

<template>
  <div class="app">
    <div class="container">
      <header class="header">
        <h1 class="title">Учетные записи</h1>
        <button class="add-button" @click="handleAddAccount" aria-label="Добавить учетную запись">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
            <line x1="12" y1="5" x2="12" y2="19"/>
            <line x1="5" y1="12" x2="19" y2="12"/>
          </svg>
        </button>
      </header>

      <div class="hint">
        <svg class="hint-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="12" r="10"/>
          <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/>
          <line x1="12" y1="17" x2="12.01" y2="17"/>
        </svg>
        <span>Для указания нескольких меток для одной пары логин/пароль используйте разделитель ;</span>
      </div>

      <div class="accounts-container">
        <div class="accounts-header">
          <div class="header-cell">Метки</div>
          <div class="header-cell">Тип записи</div>
          <div class="header-cell">Логин</div>
          <div class="header-cell">Пароль</div>
          <div class="header-cell"></div>
        </div>

        <div class="accounts-list">
          <AccountRow
            v-for="account in store.accounts"
            :key="account.id"
            :account="account"
          />
          
          <div v-if="store.accounts.length === 0" class="empty-state">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
              <circle cx="12" cy="7" r="4"/>
            </svg>
            <p>Нет учетных записей</p>
            <p class="empty-hint">Нажмите кнопку "+" чтобы добавить первую запись</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
:root {
  /* Colors - Dark elegant theme */
  --bg-primary: #0f0f0f;
  --bg-secondary: #1a1a1a;
  --bg-tertiary: #242424;
  --border-color: #2a2a2a;
  --text-color: #e8e8e8;
  --text-secondary: #a0a0a0;
  --primary-color: #4a9eff;
  --primary-hover: #3d8de8;
  --input-bg: #1a1a1a;
  --input-border: #2a2a2a;
  --focus-ring: rgba(74, 158, 255, 0.15);
  --error-color: #ff4757;
  --error-ring: rgba(255, 71, 87, 0.15);
  --error-bg: rgba(255, 71, 87, 0.1);
  --icon-color: #666;
  --hint-bg: #1e1e1e;
  --hint-border: #2a2a2a;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Noto Sans", Helvetica, Arial, sans-serif;
  background: var(--bg-primary);
  color: var(--text-color);
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.app {
  min-height: 100vh;
  padding: 40px 20px;
}

.container {
  max-width: 1400px;
  margin: 0 auto;
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 24px;
  padding-bottom: 20px;
  border-bottom: 2px solid var(--border-color);
}

.title {
  font-size: 28px;
  font-weight: 600;
  letter-spacing: -0.5px;
  color: var(--text-color);
}

.add-button {
  width: 44px;
  height: 44px;
  background: var(--primary-color);
  border: none;
  border-radius: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  transition: all 0.2s ease;
  box-shadow: 0 2px 8px rgba(74, 158, 255, 0.2);
}

.add-button:hover {
  background: var(--primary-hover);
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(74, 158, 255, 0.3);
}

.add-button:active {
  transform: translateY(0);
}

.hint {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 16px 18px;
  background: var(--hint-bg);
  border: 1px solid var(--hint-border);
  border-radius: 8px;
  margin-bottom: 28px;
  font-size: 14px;
  color: var(--text-secondary);
  line-height: 1.5;
}

.hint-icon {
  flex-shrink: 0;
  margin-top: 2px;
  color: var(--primary-color);
}

.accounts-container {
  background: var(--bg-secondary);
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid var(--border-color);
}

.accounts-header {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr auto;
  gap: 12px;
  padding: 16px 16px;
  background: var(--bg-tertiary);
  border-bottom: 1px solid var(--border-color);
}

.header-cell {
  font-size: 13px;
  font-weight: 600;
  color: var(--text-secondary);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.accounts-list {
  padding: 0 16px;
  min-height: 200px;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 80px 20px;
  color: var(--text-secondary);
  text-align: center;
}

.empty-state svg {
  margin-bottom: 16px;
  opacity: 0.5;
}

.empty-state p {
  font-size: 16px;
  margin-bottom: 8px;
}

.empty-hint {
  font-size: 14px;
  opacity: 0.7;
}

@media (max-width: 1024px) {
  .accounts-header {
    display: none;
  }
  
  .title {
    font-size: 24px;
  }
}
</style>
