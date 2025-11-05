# Mixed Content Hatası - Owlex Backend Çözümü

## Sorun

Mixed Content hatası devam ediyor çünkü **Owlex backend'i HTTP redirect döndürüyor**.

Frontend'de tam çözüm mümkün değil çünkü tarayıcı güvenlik politikaları Mixed Content'i engelliyor.

## Çözüm: Owlex Backend'de Düzeltme

Owlex config dosyanızda şunu kontrol edin:

```python
# Owlex config'de
SUPERSET_WEBSERVER_PROTOCOL = "https"  # HTTP yerine HTTPS

# Veya environment variable olarak
SUPERSET_WEBSERVER_PROTOCOL = os.environ.get("SUPERSET_PROTOCOL", "https")
```

## Proxy/Load Balancer Seviyesinde Çözüm

Eğer Owlex bir proxy/load balancer (nginx, Apache, etc.) arkasındaysa:

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
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Frontend'de Yapılanlar

Frontend'de şunlar yapıldı:
1. ✅ URL'ler otomatik HTTPS'e çevriliyor
2. ✅ Iframe onload event'inde HTTP URL kontrolü yapılıyor
3. ✅ HTTP URL algılandığında HTTPS'e çevriliyor
4. ✅ Mixed Content hataları için error handling eklendi

**Ancak bu yeterli değil** çünkü tarayıcı iframe içinde HTTP URL yüklenmesini engelliyor.

## Sonuç

**Kalıcı çözüm:** Owlex backend'inde redirect'in HTTPS olmasını sağlamak.

Frontend'de yapılanlar kısmi çözüm sağlar ama tam çözüm için backend düzeltmesi gereklidir.

