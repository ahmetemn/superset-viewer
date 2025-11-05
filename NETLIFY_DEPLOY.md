# Netlify Deploy Rehberi

## ✅ Otomatik Deploy (Önerilen)

Netlify GitHub repo'nuzu izliyorsa, her push'ta otomatik deploy yapar:

1. **Değişiklikleri GitHub'a push edin:**
   ```bash
   git add .
   git commit -m "Update for Netlify"
   git push
   ```

2. **Netlify otomatik deploy yapacak (1-2 dakika)**

3. **Deploy durumunu kontrol edin:**
   - Netlify Dashboard: https://app.netlify.com/sites/owlex/deploys
   - Live Site: https://owlex.netlify.app/

## 🚀 Manuel Deploy Script

Hızlı deploy için script kullanın:

```bash
./deploy-netlify.sh
```

## 📋 Netlify Ayarları

### Build Settings:
- **Build command:** (boş - static site)
- **Publish directory:** `.` (root)

### Environment Variables:
Gerekirse Netlify dashboard'dan ekleyin:
- `NODE_VERSION` (opsiyonel)

### Custom Domain:
Netlify dashboard > Site settings > Domain management'dan özel domain ekleyebilirsiniz.

## 🔍 Deploy Kontrolü

Deploy sonrası kontrol edin:

1. ✅ Site yükleniyor mu: https://owlex.netlify.app/
2. ✅ Console'da hata var mı: F12 > Console
3. ✅ Mixed Content hatası var mı: Network tab'inde kontrol edin

## 🐛 Sorun Giderme

### Deploy başarısız olursa:
1. Netlify dashboard'dan build loglarını kontrol edin
2. `netlify.toml` dosyasını kontrol edin
3. GitHub repo'nun public olduğundan emin olun

### Site güncellenmiyorsa:
1. Netlify dashboard > Deploys > "Trigger deploy" > "Clear cache and deploy site"
2. Browser cache'i temizleyin (Ctrl+Shift+R)

## 📝 Notlar

- Netlify otomatik olarak HTTPS sağlar
- Her push otomatik deploy tetikler
- Build logları Netlify dashboard'da görülebilir
