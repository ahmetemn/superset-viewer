# 302 Redirect - Ana Sayfaya Yönlendirme Sorunu

## Sorun

Dashboard URL'ini gönderdiğinizde ana sayfaya (`/home/`) yönlendiriliyorsunuz. Bu 302 redirect'in sonucu.

## Neden Oluyor?

1. **Cookie gönderilmiyor** (en olası neden)
2. **Cookie geçersiz/expire olmuş**
3. **Superset'in authentication middleware'i iframe'i engelliyor**

## Kritik Kontrol: Network Tab

**F12 > Network Tab'inde kontrol edin:**

1. Dashboard URL'ini yükleyin
2. **302 request'ini bulun**
3. **Request Headers** sekmesine gidin
4. **Cookie:** header'ını kontrol edin:
   - ❌ **YOKSA** → Cookie gönderilmiyor (cross-origin cookie sorunu)
   - ✅ **VARSA** → Cookie gönderiliyor ama geçersiz/expire olmuş

## Response Headers Kontrolü

302 request'inin **Response Headers** sekmesinde:
- **Location:** header'ına bakın
- Eğer `Location: /home/` veya `/login/` ise → Authentication başarısız

## Çözüm Adımları

### 1. Network Tab Kontrolü (ÖNCE BUNU YAPIN!)

1. F12 > Network tab'ini açın
2. Dashboard URL'ini yükleyin
3. 302 request'ini bulun
4. Request Headers'da **Cookie:** header'ının olup olmadığını kontrol edin

**Eğer Cookie header YOKSA:**
- Cookie gönderilmiyor demektir
- Cross-origin cookie sorunu var
- Superset'e normal şekilde giriş yapın

**Eğer Cookie header VARSA:**
- Cookie gönderiliyor ama geçersiz
- Superset'e tekrar giriş yapın
- Yeni cookie oluşacaktır

### 2. Superset'e Giriş Yapın

1. Yeni sekmede: `https://devowlex.experilabs.online`
2. Normal şekilde giriş yapın
3. Ana sayfaya gidin: `https://devowlex.experilabs.online/home/`
4. Cookie otomatik oluşur

### 3. Cookie Kontrolü

1. F12 > Application > Cookies > `https://devowlex.experilabs.online`
2. `session` cookie'sini kontrol edin:
   - ✅ Name: `session`
   - ✅ Secure: ✓
   - ✅ HttpOnly: ✓
   - ⚠️ **SameSite: None** (kritik!)

### 4. Tekrar Deneyin

1. Netlify sayfasına geri dönün
2. Dashboard yükleyin
3. Network tab'inde Cookie header'ının gönderildiğini kontrol edin

## Superset Config Kontrolü

Config dosyanızda şunları kontrol edin:

```python
# Cookie ayarları
SESSION_COOKIE_SAMESITE = "None"  # ✅ Mevcut
SESSION_COOKIE_SECURE = True      # ✅ Mevcut

# Iframe embedding
OVERRIDE_HTTP_HEADERS = {
    "X-Frame-Options": "ALLOWALL"  # ✅ Mevcut
}

# CORS
ENABLE_CORS = True
CORS_OPTIONS = {
    "supports_credentials": True,  # ✅ Mevcut
    "origins": ["*"],
}
```

## Test: Browser Console'da

Console'da şu komutu çalıştırın:

```javascript
fetch('https://devowlex.experilabs.online/superset/dashboard/500/?standalone=1', {
    method: 'HEAD',
    credentials: 'include',
    mode: 'cors'
}).then(r => {
    console.log('Status:', r.status);
    console.log('Location:', r.headers.get('Location'));
    console.log('Set-Cookie:', r.headers.get('Set-Cookie'));
});
```

**Sonuç:**
- Status 302 ve Location `/home/` → Cookie gönderilmiyor veya geçersiz
- Status 200 → Cookie çalışıyor ✅

## En Önemli Kontrol

**Network tab'inde Request Headers'da Cookie header'ının olup olmadığını kontrol edin!**

Bu bilgi olmadan sorunu çözemeyiz. Lütfen Network tab'inde Cookie header'ını kontrol edin ve sonucu paylaşın.

