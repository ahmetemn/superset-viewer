# Mixed Content Hatası - Owlex Config Düzeltmesi

## 🔴 SORUN: Config'de HTTP protokolü ayarlanmış

Config dosyanızda şu satır Mixed Content hatasına yol açıyor:

```python
SUPERSET_WEBSERVER_PROTOCOL = "http"  # ❌ YANLIŞ! (Satır ~200)
```

## ✅ ÇÖZÜM: HTTPS'e çevirin

Config dosyanızda şu değişikliği yapın:

```python
# HTTP yerine HTTPS kullan
SUPERSET_WEBSERVER_PROTOCOL = "https"  # ✅ DOĞRU
```

Veya environment variable olarak:

```python
SUPERSET_WEBSERVER_PROTOCOL = os.environ.get("SUPERSET_PROTOCOL", "https")
```

## 🔧 X-Frame-Options Düzeltmesi

Config dosyanızda şu satır var:

```python
OVERRIDE_HTTP_HEADERS = {
    "X-Frame-Options": "ALLOWALL"  # ❌ Geçersiz değer!
}
```

`ALLOWALL` geçerli bir değer değil. Şunlardan birini kullanın:

```python
# Seçenek 1: X-Frame-Options'ı tamamen kaldır (önerilen)
OVERRIDE_HTTP_HEADERS = {}

# Seçenek 2: Content-Security-Policy ile kontrol et (en modern yöntem)
OVERRIDE_HTTP_HEADERS = {
    "Content-Security-Policy": "frame-ancestors *;"
}
```

## ✅ Diğer Ayarlar (Zaten Doğru)

Config dosyanızda şu ayarlar zaten doğru:

✅ `SESSION_COOKIE_SAMESITE = "None"` - Cross-origin cookie için gerekli
✅ `SESSION_COOKIE_SECURE = True` - HTTPS için gerekli
✅ `ENABLE_CORS = True` - CORS için gerekli
✅ `CORS_OPTIONS` - `supports_credentials: True` var
✅ `ALLOW_DASHBOARD_DOMAIN_SHARING: True` - Feature flag'de var

## 📝 Yapılacaklar

### 1. Config Dosyasında Değişiklik

Config dosyanızda şu iki değişikliği yapın:

```python
# Değişiklik 1: HTTP'den HTTPS'e çevir
SUPERSET_WEBSERVER_PROTOCOL = "https"  # "http" yerine "https"

# Değişiklik 2: X-Frame-Options'ı düzelt
OVERRIDE_HTTP_HEADERS = {
    "Content-Security-Policy": "frame-ancestors *;"
}
```

### 2. Owlex'i Yeniden Başlatın

```bash
# Docker kullanıyorsanız
docker-compose restart

# Veya servis olarak çalışıyorsa
systemctl restart owlex
```

### 3. Test Edin

1. Owlex'e giriş yapın
2. Dashboard'u yükleyin
3. Mixed Content hatası çözülmüş olmalı

## 🔍 Proxy/Load Balancer Kontrolü

Eğer Owlex bir proxy/load balancer (nginx, Apache, etc.) arkasındaysa, proxy seviyesinde de HTTPS yönlendirmesi yapın:

### Nginx Örneği:

```nginx
server {
    listen 80;
    server_name devowlex.experilabs.online;
    
    # HTTP'den HTTPS'e yönlendir
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    server_name devowlex.experilabs.online;
    
    # SSL sertifikaları
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    # Proxy ayarları
    location / {
        proxy_pass http://localhost:8088;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;  # ✅ ÖNEMLİ!
    }
}
```

## ✅ Sonuç

Bu değişikliklerden sonra:
- ✅ Owlex HTTPS redirect döndürecek
- ✅ Mixed Content hatası çözülecek
- ✅ Iframe embed çalışacak
- ✅ Cross-origin cookie'ler çalışacak
