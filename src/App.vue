<template>
  <div>
    <h1>Управление учетными записями</h1>
    <button @click="addAccount">+</button>
    <p>Подсказка для поля метка: Введите текстовые метки через ";" (максимум 50 символов всего).</p>
    <div class="headers">
      <span>Метка</span>
      <span>Тип записи</span>
      <span>Логин</span>
      <span>Пароль</span>
      <span>Действия</span>
    </div>
    <AccountItem v-for="acc in accounts" :key="acc.id" :account="acc" />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useAccountsStore } from '@/stores/accounts';
import AccountItem from '@/components/AccountItem.vue';

const store = useAccountsStore();
const accounts = computed(() => store.accounts);
const addAccount = () => store.addAccount();
</script>

<style>
.headers {
  display: flex;
  gap: 10px;
  font-weight: bold;
}
</style>