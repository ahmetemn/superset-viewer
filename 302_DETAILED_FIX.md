# 302 Redirect Sorunu - Detaylı Çözüm

## Sorun: Cookie Gönderilmiyor

302 redirect hatası genellikle cookie'nin iframe'e gönderilmemesinden kaynaklanır.

## Kritik Kontrol: Network Tab

**F12 > Network Tab'inde kontrol edin:**

1. Dashboard URL'ini yükleyin
2. 302 request'ini bulun
3. **Request Headers** sekmesine gidin
4. **Cookie:** header'ını kontrol edin:
   - ❌ **YOKSA** → Cookie gönderilmiyor (cross-origin cookie sorunu)
   - ✅ **VARSA** → Cookie gönderiliyor ama geçersiz/expire olmuş

## Çözüm 1: Superset'e Giriş Yapın (ÖNERİLEN)

**En basit ve en güvenilir çözüm:**

1. **Yeni sekmede** Superset sunucusunu açın:
   ```
   https://devowlex.experilabs.online
   ```

2. **Normal şekilde giriş yapın**
   - Cookie otomatik oluşur
   - Cookie Superset domain'inde (`devowlex.experilabs.online`) kaydedilir

3. **Netlify sayfasına geri dönün:**
   ```
   https://owlex.netlify.app
   ```

4. **Dashboard yükleyin**
   - Cookie otomatik olarak iframe'e gönderilir
   - Cross-origin cookie gönderimi çalışır (SameSite=None; Secure)

## Çözüm 2: Superset Config Kontrolü

Config dosyanızda şunları kontrol edin:

```python
# Cookie ayarları
SESSION_COOKIE_SAMESITE = "None"  # ✅ Mevcut
SESSION_COOKIE_SECURE = True       # ✅ Mevcut
SESSION_COOKIE_HTTPONLY = True    # ✅ Mevcut

# CORS ayarları
ENABLE_CORS = True
CORS_OPTIONS = {
    "supports_credentials": True,  # ✅ Mevcut
    "allow_headers": ["*"],
    "resources": ["/*"],
    "origins": ["*"],  # veya ["https://owlex.netlify.app"]
}

# Iframe embedding
OVERRIDE_HTTP_HEADERS = {
    "X-Frame-Options": "ALLOWALL"  # ✅ Mevcut
}

# CSRF exemption (gerekirse)
WTF_CSRF_EXEMPT_LIST = [
    "superset.views.core.log",
    "superset.charts.api.data",
    # ... diğer mevcut entry'ler ...
]
```

## Çözüm 3: Browser Cookie Kontrolü

**F12 > Application > Cookies > https://devowlex.experilabs.online**

Kontrol edin:
- ✅ `session` cookie'si var mı?
- ✅ `SameSite` = `None` mi?
- ✅ `Secure` = ✓ (işaretli) mi?
- ✅ `Expires` geçerli bir tarih mi? (expire olmamış mı?)

## Test: Browser Console'da

Console'da şu komutu çalıştırın:

```javascript
fetch('https://devowlex.experilabs.online/superset/dashboard/500/?standalone=1', {
    method: 'HEAD',
    credentials: 'include',
    mode: 'cors'
}).then(r => {
    console.log('Status:', r.status);
    console.log('Headers:', [...r.headers.entries()]);
    if (r.status === 302) {
        console.warn('⚠️ 302 Redirect - Cookie gönderilmedi veya geçersiz!');
    }
});
```

**Sonuç:**
- Status 302 → Cookie gönderilmiyor veya geçersiz
- Status 200 → Cookie çalışıyor ✅

## Neden Çalışmıyor?

Cross-origin iframe'lerde cookie gönderimi için:

1. **Cookie'nin Superset domain'inde olması gerekir** (`devowlex.experilabs.online`)
2. **Cookie'nin `SameSite=None; Secure` olması gerekir**
3. **Her iki site de HTTPS olmalı** ✅ (ikisi de HTTPS)

## Son Çare: Superset Backend'de Düzeltme

Eğer yukarıdaki çözümler çalışmazsa, Superset backend'de şu kontrolü yapın:

```python
# Superset'in authentication middleware'i iframe'i engelliyor olabilir
# Bu durumda Superset kodunda bir değişiklik gerekebilir
```

Ancak genellikle sorun cookie gönderiminde. **En basit çözüm: Superset'e giriş yapın ve cookie otomatik oluşsun.**

