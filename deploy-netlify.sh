#!/bin/bash

# Netlify Deploy Script
# Bu script Netlify'da deploy için gerekli kontrolleri yapar

echo "🚀 Netlify Deploy Hazırlığı..."
echo ""

# 1. Git durumunu kontrol et
echo "📦 Git durumu kontrol ediliyor..."
if ! git status &> /dev/null; then
    echo "❌ Git repository bulunamadı!"
    exit 1
fi

# 2. Değişiklikleri kontrol et
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Değişiklikler var, commit ediliyor..."
    git add .
    git commit -m "Deploy to Netlify - $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 3. GitHub'a push
echo "📤 GitHub'a push ediliyor..."
git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Başarıyla GitHub'a push edildi!"
    echo ""
    echo "📋 Netlify Deploy Bilgileri:"
    echo "   - Repository: https://github.com/ahmetemn/superset-viewer"
    echo "   - Build Command: (boş - static site)"
    echo "   - Publish Directory: . (root)"
    echo ""
    echo "🔗 Netlify Dashboard:"
    echo "   https://app.netlify.com/sites/owlex/deploys"
    echo ""
    echo "🌐 Live Site:"
    echo "   https://owlex.netlify.app/"
    echo ""
    echo "✨ Netlify otomatik deploy yapacak (1-2 dakika sürebilir)"
else
    echo "❌ GitHub push başarısız!"
    exit 1
fi
