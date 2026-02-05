<script setup lang="ts">
import { ref, computed, watch } from 'vue';
import { useAccountStore } from '@/stores/accountStore';
import type { Account, AccountType, ValidationErrors } from '@/types';

const props = defineProps<{
  account: Account;
}>();

const store = useAccountStore();

// Local state for form fields
const tagsInput = ref(store.tagsToString(props.account.tags));
const type = ref<AccountType>(props.account.type);
const login = ref(props.account.login);
const password = ref(props.account.password || '');

// Validation errors
const errors = ref<ValidationErrors>({});

// Computed property to check if password field should be visible
const isPasswordVisible = computed(() => type.value === 'Локальная');

// Watch for type changes to handle password visibility
watch(type, (newType) => {
  if (newType === 'LDAP') {
    password.value = '';
    delete errors.value.password;
  }
  updateAccount();
});

// Validation function
const validate = (): boolean => {
  errors.value = {};
  let isValid = true;

  // Validate login (required, max 100 chars)
  if (!login.value.trim() || login.value.length > 100) {
    errors.value.login = true;
    isValid = false;
  }

  // Validate password (required for Локальная type, max 100 chars)
  if (type.value === 'Локальная') {
    if (!password.value.trim() || password.value.length > 100) {
      errors.value.password = true;
      isValid = false;
    }
  }

  return isValid;
};

// Update account in store
const updateAccount = () => {
  if (!validate()) return; // Don't save if validation fails

  const tags = store.parseTags(tagsInput.value);
  
  store.updateAccount(props.account.id, {
    tags,
    type: type.value,
    login: login.value,
    password: type.value === 'LDAP' ? null : password.value,
  });
};

// Handle input blur events
const handleTagsBlur = () => {
  // Validate tags length (max 50 chars)
  if (tagsInput.value.length > 50) {
    tagsInput.value = tagsInput.value.substring(0, 50);
  }
  updateAccount();
};

const handleLoginBlur = () => {
  updateAccount();
};

const handlePasswordBlur = () => {
  updateAccount();
};

// Handle delete
const handleDelete = () => {
  store.deleteAccount(props.account.id);
};
</script>

<template>
  <div class="account-row">
    <div class="field">
      <input
        v-model="tagsInput"
        type="text"
        placeholder="Значение"
        maxlength="50"
        @blur="handleTagsBlur"
        class="input tags-input"
      />
    </div>

    <div class="field">
      <select v-model="type" class="select">
        <option value="Локальная">Локальная</option>
        <option value="LDAP">LDAP</option>
      </select>
    </div>

    <div class="field" :class="{ 'login-wide': !isPasswordVisible }">
      <input
        v-model="login"
        type="text"
        placeholder="Значение"
        maxlength="100"
        @blur="handleLoginBlur"
        :class="['input', { 'input-error': errors.login }]"
      />
    </div>

    <div class="field password-field" v-if="isPasswordVisible">
      <input
        v-model="password"
        type="password"
        placeholder="Значение"
        maxlength="100"
        @blur="handlePasswordBlur"
        :class="['input', { 'input-error': errors.password }]"
      />
    </div>

    <div class="field delete-field">
      <button class="delete-button" @click="handleDelete" aria-label="Удалить запись">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <polyline points="3 6 5 6 21 6"/>
          <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>
        </svg>
      </button>
    </div>
  </div>
</template>

<style scoped>
.account-row {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr auto;
  gap: 12px;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid var(--border-color);
}

.field {
  position: relative;
}

.login-wide {
  grid-column: span 2;
}

.password-field {
  grid-column: span 1;
}

.input,
.select {
  width: 100%;
  padding: 10px 14px;
  font-size: 14px;
  font-family: inherit;
  border: 1px solid var(--input-border);
  border-radius: 6px;
  background: var(--input-bg);
  color: var(--text-color);
  transition: all 0.2s ease;
  outline: none;
}

.input:focus,
.select:focus {
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px var(--focus-ring);
}

.input-error {
  border-color: var(--error-color) !important;
}

.input-error:focus {
  box-shadow: 0 0 0 3px var(--error-ring) !important;
}

.select {
  cursor: pointer;
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg width='12' height='8' viewBox='0 0 12 8' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1.5L6 6.5L11 1.5' stroke='%23666' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 12px center;
  padding-right: 36px;
}

.delete-field {
  display: flex;
  align-items: center;
  justify-content: center;
}

.delete-button {
  background: none;
  border: none;
  cursor: pointer;
  padding: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--icon-color);
  transition: all 0.2s ease;
  border-radius: 6px;
}

.delete-button:hover {
  color: var(--error-color);
  background: var(--error-bg);
}

@media (max-width: 1024px) {
  .account-row {
    grid-template-columns: 1fr;
    gap: 8px;
  }
  
  .password-field {
    grid-column: span 1;
  }
}
</style>
