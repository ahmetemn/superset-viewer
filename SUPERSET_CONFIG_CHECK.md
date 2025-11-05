# Superset Config - 302 Redirect Çözümü İçin Ek Kontroller

Config dosyanızda şu ayarları kontrol edin:

## 1. CSRF Ayarları (ÖNEMLİ!)

```python
# CSRF korumasını iframe için devre dışı bırak
WTF_CSRF_ENABLED = True  # Genel olarak açık kalabilir
WTF_CSRF_EXEMPT_LIST = [
    "superset.views.core.log",
    "superset.charts.api.data",
    "superset.datasets.api.refresh_ods_layer",
    "superset.datasets.api.run_report_to_dataframe",
    "superset.databases.api.upload",
    # Iframe embedding için eklenmeli:
    "superset.views.dashboard.Dashboard",
    "superset.views.chart.Chart",
]
```

## 2. Authentication Middleware Kontrolü

Superset'in authentication middleware'i iframe request'lerini engelliyor olabilir. 
Config'de şu kontrolü yapın:

```python
# Eğer varsa, iframe request'lerini allow et
# Bu genellikle Superset'in kendi middleware'inde ayarlanır
```

## 3. Session Cookie Ayarları (Zaten Mevcut ✅)

```python
SESSION_COOKIE_SAMESITE = "None"  # ✅ Mevcut
SESSION_COOKIE_SECURE = True      # ✅ Mevcut
SESSION_COOKIE_HTTPONLY = True    # ✅ Mevcut
```

## 4. CORS Ayarları (Zaten Mevcut ✅)

```python
ENABLE_CORS = True
CORS_OPTIONS = {
    "supports_credentials": True,
    "allow_headers": ["*"],
    "resources": ["/*"],
    "origins": ["*"],  # veya ["https://owlex.netlify.app"]
}
```

## 5. X-Frame-Options (Zaten Mevcut ✅)

```python
OVERRIDE_HTTP_HEADERS = {
    "X-Frame-Options": "ALLOWALL"
}
```

## Debug için Test

Browser Console'da şu komutu çalıştırın:

```javascript
// Cookie gönderimini test et
fetch('https://devowlex.experilabs.online/superset/dashboard/500/?standalone=1', {
    method: 'HEAD',
    credentials: 'include',
    mode: 'cors'
}).then(r => console.log('Status:', r.status, 'Headers:', [...r.headers.entries()]))
```

Eğer status 302 ise ve Response Headers'da `Location: /login/` varsa → Cookie gönderilmiyor veya geçersiz.

Eğer status 200 ise → Cookie gönderiliyor ve çalışıyor demektir.

