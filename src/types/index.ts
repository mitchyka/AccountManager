export type AccountType = 'LDAP' | 'Локальная';

export interface TagItem {
  text: string;
}

export interface Account {
  id: string;
  tags: TagItem[];
  type: AccountType;
  login: string;
  password: string | null;
}

export interface ValidationErrors {
  login?: boolean;
  password?: boolean;
}
