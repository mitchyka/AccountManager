<template>
  <div class="account-item">
    <div class="field">
      <input
        v-model="local.labelsStr"
        placeholder="Метка (опционально, через ;)"
        maxlength="50"
        @blur="validateAndSave"
      />
      <span v-if="errorLabels" class="error-msg">{{ errorLabels }}</span>
    </div>
    <select v-model="local.type" @change="onTypeChange">
      <option value="LDAP">LDAP</option>
      <option value="Local">Локальная</option>
    </select>
    <div class="field">
      <input
        v-model="local.login"
        placeholder="Логин (обязательно)"
        maxlength="100"
        @blur="validateAndSave"
        :class="{ error: !!errorLogin }"
      />
      <span v-if="errorLogin" class="error-msg">{{ errorLogin }}</span>
    </div>
    <div class="field" v-if="local.type === 'Local'">
      <input
        v-model="local.password"
        type="password"
        placeholder="Пароль (обязательно)"
        maxlength="100"
        @blur="validateAndSave"
        :class="{ error: !!errorPassword }"
      />
      <span v-if="errorPassword" class="error-msg">{{ errorPassword }}</span>
    </div>
    <button @click="deleteAcc">Удалить</button>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { useAccountsStore } from '@/stores/accounts';
import type { Account } from '@/stores/accounts';

const props = defineProps<{ account: Account }>();
const store = useAccountsStore();

const local = ref({
  ...props.account,
  labelsStr: props.account.labels.map(l => l.text).join(';')
});

watch(() => props.account, (newAcc) => {
  local.value = {
    ...newAcc,
    labelsStr: newAcc.labels.map(l => l.text).join(';')
  };
}, { deep: true });

const errorLabels = ref('');
const errorLogin = ref('');
const errorPassword = ref('');

const validateAndSave = () => {
  errorLabels.value = local.value.labelsStr.length > 50 ? 'Максимум 50 символов' : '';
  errorLogin.value = !local.value.login.trim() ? 'Логин обязателен' : '';
  errorPassword.value = '';
  if (local.value.type === 'Local') {
    errorPassword.value = !local.value.password?.trim() ? 'Пароль обязателен' : '';
  } else {
    local.value.password = null;
  }

  if (!errorLabels.value && !errorLogin.value && !errorPassword.value) {
    const labels = local.value.labelsStr
      .split(';')
      .map(s => s.trim())
      .filter(s => s)
      .map(text => ({ text }));
    const toSave: Account = { ...local.value, labels };
    store.updateAccount(toSave);
  }
};

const onTypeChange = () => {
  if (local.value.type === 'LDAP') {
    local.value.password = null;
  }
  validateAndSave();
};

const deleteAcc = () => {
  store.removeAccount(local.value.id);
};
</script>

<style>
.error {
  border: 1px solid red;
}
.error-msg {
  color: red;
  font-size: 12px;
}
.account-item {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
}
.field {
  display: flex;
  flex-direction: column;
}
</style>