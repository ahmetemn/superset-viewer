# Superset Viewer - Deployment Guide

Bu proje Superset Chart ve Dashboard'ları iframe içinde görüntülemek için bir HTML viewer uygulamasıdır.

## 🚀 Ücretsiz HTTPS Deployment Seçenekleri

### Seçenek 1: GitHub Pages (Önerilen)

**Adımlar:**

1. **GitHub'da yeni bir repository oluşturun:**
   - GitHub.com'a gidin
   - "New repository" butonuna tıklayın
   - Repository adı: `superset-viewer` (veya istediğiniz isim)
   - Public olarak ayarlayın
   - "Create repository" butonuna tıklayın

2. **Projeyi GitHub'a yükleyin:**

```bash
cd /home/ahmet/Desktop/superset-viewer
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/KULLANICI_ADINIZ/superset-viewer.git
git push -u origin main
```

3. **GitHub Pages'i etkinleştirin:**
   - Repository sayfasında **Settings** sekmesine gidin
   - Sol menüden **Pages** seçeneğine tıklayın
   - **Source** altında **Deploy from a branch** seçin
   - Branch: `main`, Folder: `/ (root)` seçin
   - **Save** butonuna tıklayın

4. **URL'inizi alın:**
   - Birkaç dakika sonra sayfanız şu adreste olacak:
   - `https://KULLANICI_ADINIZ.github.io/superset-viewer/`

### Seçenek 2: Netlify Drop (En Kolay)

**Adımlar:**

1. **Netlify.com'a gidin ve ücretsiz hesap oluşturun**

2. **Netlify Drop kullanın:**
   - Netlify Dashboard'da **Sites** sekmesine gidin
   - **Add new site** > **Deploy manually** seçin
   - Tüm dosyaları (`index.html` ve diğer HTML dosyaları) sürükle-bırak yapın

3. **URL otomatik oluşturulur:**
   - `https://rastgele-isim.netlify.app` formatında bir URL alırsınız
   - Ayarlardan özel domain ekleyebilirsiniz

### Seçenek 3: Vercel

**Adımlar:**

1. **Vercel.com'a gidin ve ücretsiz hesap oluşturun**

2. **CLI ile deploy:**
```bash
npm i -g vercel
cd /home/ahmet/Desktop/superset-viewer
vercel
```

3. **Veya web interface:**
   - Vercel Dashboard'da **Add New Project** seçin
   - GitHub repository'nizi bağlayın veya dosyaları yükleyin

### Seçenek 4: Cloudflare Pages

**Adımlar:**

1. **Cloudflare Dashboard'a gidin**
2. **Pages** sekmesine gidin
3. **Create a project** > **Upload assets** seçin
4. Dosyalarınızı yükleyin

## 📝 Notlar

- Tüm bu servisler **ücretsiz HTTPS** sağlar
- GitHub Pages en popüler ve güvenilir seçenektir
- Netlify Drop en hızlı deployment yöntemidir (kod yazmadan)
- Deployment sonrası URL'iniz HTTPS ile çalışacaktır

## 🔧 Kullanım

1. Deployment sonrası URL'inizi açın
2. Superset sunucu URL'inizi girin
3. Chart veya Dashboard ID'nizi girin
4. "Yükle" butonuna tıklayın

## ⚠️ Cookie Notu

Superset'e giriş yaptıktan sonra, cookie otomatik olarak iframe içinde çalışır. HTTPS üzerinden açıldığı için cookie ayarlama sorunsuz çalışacaktır.

