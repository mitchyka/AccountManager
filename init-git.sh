#!/bin/bash

# Инициализация Git репозитория для проекта Account Manager
# Этот скрипт создает начальную структуру коммитов

echo "Инициализация Git репозитория..."

# Инициализация репозитория
git init

# Добавление файлов по этапам для создания осмысленной истории коммитов

echo "Коммит 1: Начальная настройка проекта"
git add package.json tsconfig.json tsconfig.node.json vite.config.ts .gitignore
git commit -m "feat: initial project setup with Vite, Vue 3, TypeScript, Pinia

- Configure Vite build tool
- Set up TypeScript configuration
- Add project dependencies (Vue 3, Pinia)
- Create .gitignore for node_modules and build artifacts"

echo "Коммит 2: Добавление TypeScript типов"
git add src/types/
git commit -m "feat: add TypeScript types for Account entity

- Define Account interface with all required fields
- Add AccountType union type (LDAP | Локальная)
- Create TagItem interface for tags structure
- Add ValidationErrors interface for form validation"

echo "Коммит 3: Создание Pinia store"
git add src/stores/
git commit -m "feat: implement Pinia store for account management

- Create accountStore with state, getters, and actions
- Add localStorage integration for data persistence
- Implement CRUD operations (add, update, delete)
- Add helper methods for tags parsing and formatting
- Include auto-save functionality"

echo "Коммит 4: Создание компонента AccountRow"
git add src/components/
git commit -m "feat: create AccountRow component for account editing

- Implement form fields with two-way binding
- Add real-time validation on blur/change events
- Support for password visibility toggle
- Handle LDAP/Local type switching with password field visibility
- Implement delete functionality
- Add error state visualization with red borders"

echo "Коммит 5: Создание главного компонента App"
git add src/App.vue
git commit -m "feat: implement main App component and layout

- Create header with title and add button
- Add informational hint for tags usage
- Implement accounts table with column headers
- Add empty state placeholder
- Include responsive grid layout
- Apply dark theme styling with CSS variables"

echo "Коммит 6: Точка входа и HTML шаблон"
git add src/main.ts src/vite-env.d.ts index.html
git commit -m "feat: add application entry point and HTML template

- Set up Vue app initialization in main.ts
- Configure Pinia integration
- Create HTML template with proper meta tags
- Add TypeScript declarations for Vue components"

echo "Коммит 7: Документация"
git add README.md SETUP.md
git commit -m "docs: add comprehensive documentation

- Create detailed README with project overview
- Document all features and functionality
- Add setup and installation instructions
- Include data structure examples
- Provide troubleshooting guide in SETUP.md"

echo "Коммит 8: Финальные улучшения"
git add init-git.sh
git commit -m "chore: add git initialization script

- Create automated script for repository setup
- Include meaningful commit history creation
- Document development workflow"

echo ""
echo "✅ Git репозиторий успешно инициализирован!"
echo "📝 Создано 8 коммитов с осмысленной историей разработки"
echo ""
echo "Для просмотра истории используйте:"
echo "  git log --oneline"
echo "  git log --graph --all --decorate"
echo ""
echo "Для загрузки в удаленный репозиторий:"
echo "  git remote add origin <repository-url>"
echo "  git branch -M main"
echo "  git push -u origin main"
