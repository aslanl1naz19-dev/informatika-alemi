# İnformatika aləmi

Bu repo sənin göndərdiyin mövcud İnformatika aləmi HTML interfeysini qoruyur və statik sayt kimi yayımlanmaq üçün hazırlanıb.

## Fayllar
- index.html — əsas interfeys, sinif tapşırıqları, laboratoriya, faktlar və müəllim paneli.
- config.js — Supabase Project URL, publishable/anon key və müəllim UUID-si.
- supabase-setup.sql — cədvəllər, Storage bucket və RLS təhlükəsizlik qaydaları.
- netlify.toml — Netlify yayımlama parametrləri.

## 1. Supabase qoşulması
1. https://supabase.com/ saytında layihə yarat.
2. Authentication → Users bölməsində müəllim üçün e-poçt/şifrə hesabı yarat.
3. İstifadəçinin UUID dəyərini kopyala.
4. SQL Editor aç, supabase-setup.sql mətnini köçür.
5. SQL-dəki bütün PASTE_TEACHER_UID_HERE yazılarını həmin UUID ilə əvəz et və sorğunu icra et.
6. Project Settings → API bölməsindən Project URL və publishable/anon key götür.
7. config.js faylında url, anonKey və teacherUid dəyərlərini doldur.

## 2. Netlify-də yayımla
1. https://app.netlify.com/ aç.
2. Add new site → Import an existing project → GitHub seç.
3. aslanl1naz19-dev/informatika-alemi repozitoriyasını seç.
4. Build command boş, publish directory isə . olsun.
5. Deploy et. GitHub-a yeni commit ediləndə Netlify avtomatik yeniləyəcək.

## 3. İstifadə
- Şagirdlər giriş etmədən paylaşılan dərs materiallarını açıb endirə bilər.
- Müəllim düyməsi giriş pəncərəsini açır.
- Yalnız Supabase-də yaradılmış və UID-si config.js və RLS siyasətlərində uyğun gələn hesab müəllim panelindən istifadə edə bilər.
- Müəllim material yükləyə/silə və sinif tapşırıqlarını idarə edə bilər.
- Ortaq tapşırıqlar site_content cədvəlində, material faylları materials Storage bucket-ində saxlanır.

## Təhlükəsizlik
- Brauzer koduna service_role və ya secret key əlavə etmə.
- RLS siyasətlərini aktiv saxla və müəllim UUID-sini düzgün yaz.
- Materials bucket public olduğuna görə dərs faylları linki olan hər kəsə açıqdır; gizli sənədləri ora yükləmə.
- GitHub kodu saxlayır; Supabase məlumatları və faylları cihazlar arasında paylaşır.
