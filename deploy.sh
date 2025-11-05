#!/bin/bash

echo "🚀 Superset Viewer Deployment Script"
echo "===================================="
echo ""
echo "Bu script projenizi GitHub'a yükler ve GitHub Pages'i aktif eder."
echo ""
read -p "GitHub kullanıcı adınızı girin: " GITHUB_USERNAME
read -p "Repository adını girin (varsayılan: superset-viewer): " REPO_NAME
REPO_NAME=${REPO_NAME:-superset-viewer}

echo ""
echo "📦 Proje hazırlanıyor..."

# Git repository başlat
if [ ! -d ".git" ]; then
    git init
fi

# Dosyaları ekle
git add .
git commit -m "Deploy to GitHub Pages" || echo "No changes to commit"

# GitHub repository oluştur
echo ""
echo "🔗 GitHub repository bağlantısı..."
echo "Lütfen GitHub'da şu adımları takip edin:"
echo "1. https://github.com/new adresine gidin"
echo "2. Repository adı: $REPO_NAME"
echo "3. Public olarak ayarlayın"
echo "4. 'Create repository' butonuna tıklayın"
echo ""
read -p "Repository'yi oluşturduktan sonra ENTER'a basın..."

# Remote ekle
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# Push yap
echo ""
echo "📤 GitHub'a yükleniyor..."
git branch -M main
git push -u origin main

echo ""
echo "✅ Dosyalar GitHub'a yüklendi!"
echo ""
echo "🔧 GitHub Pages'i aktifleştirmek için:"
echo "1. https://github.com/$GITHUB_USERNAME/$REPO_NAME/settings/pages adresine gidin"
echo "2. Source: Deploy from a branch seçin"
echo "3. Branch: main, Folder: / (root) seçin"
echo "4. Save butonuna tıklayın"
echo ""
echo "🌐 Birkaç dakika sonra siteniz şu adreste olacak:"
echo "   https://$GITHUB_USERNAME.github.io/$REPO_NAME/"
echo ""

