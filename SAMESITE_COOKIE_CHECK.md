# 302 Redirect - SameSite Cookie Kontrolü

## Sorun: Cookie SameSite=None Olmalı

Ekran görüntüsünde cookie'ler var ama `SameSite` değeri tam görünmüyor. Cross-origin iframe'lerde cookie gönderimi için `SameSite=None` olması kritik!

## Kontrol Adımları

1. **Superset'e giriş yapın:**
   ```
   https://devowlex.experilabs.online
   ```

2. **Ana sayfaya gidin:**
   ```
   https://devowlex.experilabs.online/home/
   ```

3. **F12 > Application > Cookies kontrolü:**
   - `session` cookie'sini bulun
   - **SameSite** kolonunu kontrol edin
   - ✅ **`None`** olmalı
   - ❌ Eğer `Lax` veya `Strict` ise → Cross-origin iframe'de çalışmaz!

## Network Tab Kontrolü (EN ÖNEMLİSİ)

1. **F12 > Network tab'ini açın**
2. **Dashboard URL'ini yükleyin**
3. **302 request'ini bulun**
4. **Request Headers** sekmesine gidin
5. **Cookie:** header'ını kontrol edin:
   - ❌ **YOKSA** → Cookie gönderilmiyor (SameSite sorunu!)
   - ✅ **VARSA** → Cookie gönderiliyor ama geçersiz

## Superset Config Kontrolü

Config dosyanızda şunu kontrol edin:

```python
SESSION_COOKIE_SAMESITE = "None"  # ✅ Mevcut görünüyor
SESSION_COOKIE_SECURE = True      # ✅ Mevcut
```

Ancak bazen Superset restart edilmesi gerekebilir!

## Çözüm

1. **Superset'e giriş yapın ve ana sayfaya gidin**
2. **Cookie'nin SameSite=None olduğunu kontrol edin**
3. **Eğer SameSite=Lax ise:**
   - Superset config'i kontrol edin
   - Superset'i restart edin
   - Tekrar giriş yapın
4. **Network tab'inde Cookie header'ının gönderildiğini kontrol edin**

## Test

Browser Console'da:

```javascript
// Cookie kontrolü
document.cookie.split(';').forEach(c => {
    if (c.includes('session')) {
        console.log('Session cookie:', c.trim());
    }
});

// Fetch testi
fetch('https://devowlex.experilabs.online/superset/dashboard/500/?standalone=1', {
    method: 'HEAD',
    credentials: 'include',
    mode: 'cors'
}).then(r => {
    console.log('Status:', r.status);
    console.log('Location:', r.headers.get('Location'));
});
```

Eğer status 302 ve Location `/login/` ise → Cookie gönderilmiyor veya geçersiz.

