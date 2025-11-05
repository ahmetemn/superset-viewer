# Netlify Deployment için Hazır Dosyalar

Bu klasördeki tüm dosyaları Netlify'a yükleyin:

## Yüklenecek Dosyalar:

1. ✅ `index.html` - Ana sayfa
2. ✅ `owlex_embed_viewer.html` - Owlex viewer
3. ✅ `superset_embed_viewer.html` - Superset viewer
4. ✅ `netlify.toml` - Netlify yapılandırması (otomatik redirect için)

## Netlify Deployment:

### Yöntem 1: Manuel Upload (En Kolay)
1. https://app.netlify.com/drop adresine gidin
2. Tüm HTML dosyalarını sürükle-bırak yapın
3. ✅ Hazır!

### Yöntem 2: GitHub ile (Otomatik Deploy)
1. Netlify Dashboard > "Add new site" > "Import from Git"
2. GitHub'ı bağlayın ve `ahmetemn/superset-viewer` seçin
3. Build settings otomatik algılanacak
4. "Deploy site" butonuna tıklayın

## Notlar:

- `netlify.toml` dosyası tüm istekleri `index.html`'e yönlendirir
- HTTPS otomatik olarak aktif olur
- Private repository'lerde de çalışır
- Her GitHub push'unda otomatik deploy yapılır

