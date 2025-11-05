# Cookie Gönderiliyor Ama 302 Redirect Devam Ediyor

## Sorun Tespiti

✅ **Cookie gönderiliyor!** Request Headers'da `cookie: session=...` var.
❌ **Ama hala 302 redirect alıyorsunuz** → Cookie geçersiz veya Superset config sorunu

## Olası Nedenler

1. **Cookie geçersiz/expire olmuş** (en olası)
2. **Superset'in CSRF koruması** iframe'i engelliyor
3. **Standalone mod düzgün çalışmıyor**
4. **Superset'in authentication middleware'i** cookie'yi reddediyor

## Çözümler

### 1. Yeni Cookie Alın (EN ÖNEMLİSİ)

Cookie gönderiliyor ama geçersiz olabilir:

1. **Superset'e tekrar giriş yapın:**
   ```
   https://devowlex.experilabs.online
   ```

2. **Ana sayfaya gidin:**
   ```
   https://devowlex.experilabs.online/home/
   ```

3. **Eski cookie'leri temizleyin:**
   - F12 > Application > Cookies > `https://devowlex.experilabs.online`
   - Tüm cookie'leri silin
   - Tekrar giriş yapın
   - Yeni cookie oluşacaktır

4. **Netlify sayfasına geri dönün ve tekrar deneyin**

### 2. Superset Config Kontrolü

Config dosyanızda şunları kontrol edin:

```python
# CSRF exemption (iframe için)
WTF_CSRF_EXEMPT_LIST = [
    "superset.views.core.log",
    "superset.charts.api.data",
    # Dashboard view'larını ekleyin:
    "superset.views.dashboard.Dashboard",
    "superset.views.chart.Chart",
]

# Standalone mod için
# Config'de standalone mod aktif olmalı
```

### 3. URL Parametreleri

Standalone mod için ek parametreler ekleyin:

```
?standalone=1&embedded=true
```

Bu parametreler Superset'e iframe içinde olduğunu bildirir.

### 4. Superset Log Kontrolü

Superset sunucusunun loglarını kontrol edin:
- Cookie doğrulama başarısız mı?
- CSRF token kontrolü başarısız mı?
- Authentication middleware ne diyor?

## Test

Browser Console'da yeni cookie ile test edin:

```javascript
// Yeni cookie ile test
fetch('https://devowlex.experilabs.online/superset/dashboard/500/?standalone=1&embedded=true', {
    method: 'HEAD',
    credentials: 'include',
    mode: 'cors'
}).then(r => {
    console.log('Status:', r.status);
    console.log('Location:', r.headers.get('Location'));
});
```

**Eğer hala 302 ise:**
- Superset backend'de bir sorun var
- Config'de CSRF exemption eksik olabilir
- Superset loglarını kontrol edin

## Not

Cookie gönderiliyor ✅ ama Superset cookie'yi reddediyor ❌

Bu genellikle:
- Cookie expire olmuş
- CSRF koruması
- Superset config sorunu

Çözüm: **Yeni cookie alın ve Superset config'i kontrol edin.**

