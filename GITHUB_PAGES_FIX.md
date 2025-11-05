# GitHub Pages Kurulum Rehberi

## Sorun: "There isn't a GitHub Pages site here" Hatası

Bu hata genellikle şu nedenlerden kaynaklanır:

### ✅ Çözüm Adımları:

1. **Repository'nin Public Olduğundan Emin Olun:**
   - https://github.com/ahmetemn/superset-viewer/settings adresine gidin
   - Aşağıya scroll yapın ve "Danger Zone" bölümünü bulun
   - Eğer repository "Private" ise, "Change visibility" ile "Public" yapın
   - ⚠️ ÖNEMLİ: Ücretsiz GitHub hesapları için GitHub Pages sadece Public repository'lerde çalışır!

2. **GitHub Pages Ayarlarını Yapın:**
   - https://github.com/ahmetemn/superset-viewer/settings/pages adresine gidin
   - "Source" bölümünde:
     - **Deploy from a branch** seçin
     - **Branch:** `main` seçin
     - **Folder:** `/ (root)` seçin
   - **Save** butonuna tıklayın

3. **Dosyaların Doğru Olduğundan Emin Olun:**
   - `index.html` dosyası repository'nin root'unda olmalı ✅ (mevcut)
   - Dosyalar `main` branch'inde olmalı ✅ (mevcut)

4. **Bekleyin:**
   - GitHub Pages'in aktif olması 1-5 dakika sürebilir
   - Sayfayı yenileyin ve tekrar kontrol edin

5. **URL'inizi Kontrol Edin:**
   - Deployment sonrası şu adreste olmalı:
   - `https://ahmetemn.github.io/superset-viewer/`

## 🔍 Hata Devam Ederse:

**Repository Private mı?**
- Eğer repository Private ise, GitHub Pages çalışmaz!
- Settings > General > Danger Zone > Change visibility > Make public

**Branch Doğru mu?**
- Settings > Pages > Source > Branch: `main` olmalı

**index.html Var mı?**
- Repository root'unda `index.html` dosyası olmalı ✅

**GitHub Actions Kontrolü:**
- Actions sekmesine gidin ve deployment loglarını kontrol edin
- Hata varsa orada görünecektir

## 🚀 Alternatif: Netlify (Daha Kolay)

GitHub Pages sorun yaşıyorsa, Netlify kullanabilirsiniz:

1. https://www.netlify.com/ adresine gidin (ücretsiz kayıt)
2. Dashboard > "Add new site" > "Deploy manually"
3. Tüm dosyaları sürükle-bırak yapın
4. ✅ Hazır! HTTPS otomatik aktif

Netlify'da repository private olabilir ve anında çalışır!

