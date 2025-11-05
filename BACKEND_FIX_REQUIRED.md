# X-Frame-Options ve Mixed Content Hataları - Çözüm

## 🔴 HATA 1: X-Frame-Options Çakışması

```
Refused to display 'https://devowlex.experilabs.online/' in a frame because 
it set multiple 'X-Frame-Options' headers with conflicting values 
('ALLOWALL, SAMEORIGIN'). Falling back to 'deny'.
```

### Sorun:
Owlex config dosyasında şu satır var:
```python
OVERRIDE_HTTP_HEADERS = {
    "X-Frame-Options": "ALLOWALL"  # ❌ Geçersiz değer!
}
```

Backend ayrıca `SAMEORIGIN` da gönderiyor, bu yüzden çakışma oluyor.

### ✅ ÇÖZÜM:

Config dosyanızda şu değişikliği yapın:

```python
# ÖNCE (yanlış):
OVERRIDE_HTTP_HEADERS = {
    "X-Frame-Options": "ALLOWALL"
}

# SONRA (doğru - Seçenek 1: Header'ı tamamen kaldır):
OVERRIDE_HTTP_HEADERS = {}

# VEYA (Seçenek 2: Content-Security-Policy kullan):
OVERRIDE_HTTP_HEADERS = {
    "Content-Security-Policy": "frame-ancestors *;"
}
```

## 🔴 HATA 2: Mixed Content

```
Mixed Content: The page at 'https://owlex.netlify.app/' was loaded over HTTPS, 
but requested an insecure frame 'http://devowlex.experilabs.online/home'.
```

### Sorun:
Owlex backend'i HTTP redirect döndürüyor (`http://devowlex.experilabs.online/home`).

### ✅ ÇÖZÜM:

Config dosyanızda şu değişikliği yapın:

```python
# ÖNCE (yanlış):
SUPERSET_WEBSERVER_PROTOCOL = "http"

# SONRA (doğru):
SUPERSET_WEBSERVER_PROTOCOL = "https"
```

## 📝 Yapılacaklar

### 1. Config Dosyasında Değişiklikler:

```python
# Değişiklik 1: HTTP'den HTTPS'e çevir
SUPERSET_WEBSERVER_PROTOCOL = "https"  # "http" yerine "https"

# Değişiklik 2: X-Frame-Options'ı düzelt
OVERRIDE_HTTP_HEADERS = {
    "Content-Security-Policy": "frame-ancestors *;"
}
```

### 2. Owlex'i Yeniden Başlatın:

```bash
# Docker kullanıyorsanız
docker-compose restart

# Veya servis olarak çalışıyorsa
systemctl restart owlex
```

### 3. Test Edin:

1. Owlex'e giriş yapın
2. Dashboard'u yükleyin
3. Her iki hata da çözülmüş olmalı

## 🔍 Hata Kontrolü

### X-Frame-Options hatası için:
- F12 > Network tab > Dashboard request'i bulun
- Response Headers'da `X-Frame-Options` header'ını kontrol edin
- Sadece bir tane `X-Frame-Options` header'ı olmalı ve değeri `SAMEORIGIN` veya `ALLOWALL` olmamalı

### Mixed Content hatası için:
- F12 > Network tab > Dashboard request'i bulun
- Response Headers'da `Location` header'ını kontrol edin
- `Location` header'ı `https://` ile başlamalı, `http://` ile değil

## ✅ Sonuç

Bu değişikliklerden sonra:
- ✅ X-Frame-Options çakışması çözülecek
- ✅ Mixed Content hatası çözülecek
- ✅ Iframe embed çalışacak
- ✅ Cross-origin cookie'ler çalışacak

## ⚠️ Not

Frontend'de bu sorunları tamamen çözemeyiz çünkü:
- X-Frame-Options header'ı backend tarafından gönderiliyor
- HTTP redirect backend tarafından yapılıyor

**Kalıcı çözüm için backend config düzeltmesi zorunludur.**

