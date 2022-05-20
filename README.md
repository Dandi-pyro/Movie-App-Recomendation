# Cineminfo: Movie-App-Recomendation

Untuk menggunakan API_KEY TMDB milikmu bisa di masukkan di /model/api/services_api.dart lalu ganti pada bagian apiKey = "your_api_key"
![](screenshots/Service_Api.png)

Dibagian Login/SignIn jika belum punya akun bisa ke bagian SignUp
![](screenshots/Login_Screen.png)
![](screenshots/SignUp_Screen.png)

Jika sudah maka kamu akan dipindahkan ke Movie Screen seperti ini:
![](screenshots/Movie_Screen.png)

Disitu ada beberapa fitur yang digunakan seperti mengklik movie yang ada jika diklik maka akan menampilkan detail dari movie tersebut, seperti ini:
![](screenshots/Detail_Movie_Screen.png)
Dibagian detail movie kamu bisa mengklik tombol play untuk memutar trailer dari movie tersebut

Selain itu ada fitur search movie dibagian kanan atas movie screen jika diklik dan mengisi textfieldnya akan muncul seperti berikut:
![](screenshots/Search_Movie.png)

Lalu ada bagian drawer dipojok kiri movie screen jika diklik akan menampilkan UI seperti berikut:
![](screenshots/Drawer_Screen.png)
Di bagian drawer akan memunculkan nama dan email yang telah kamu daftarkan dan ada beberapa fitur seperti profile, movie, watchlist dan log out

Di profile screen akan memunculkan UI seperti berikut:
![](screenshots/Profile_Screen.png)
Di sana ada beberapa fitur seperti edit profile dan change password

Di edit profile akan menampilkan dua buah textfield untuk mengganti nama dan email
![](screenshots/Edit_Screen.png)

Di change password akan menampilkan juga dua buah texxtfield untuk mengganti password dan konfirmasi password
![](screenshots/Change_Password_Screen.png)

Lalu untuk dibagian watchlist screen akan menampilkan tiga buah tab yaitu watchlist, droplist dan finishlist
![](screenshots/Watchlist_Screen.png)
![](screenshots/Droplist_Screen.png)
![](screenshots/Finishlist_Screen.png)
Watchlist untuk menampilkan movie yang sedang atau mau kamu tonton
Droplist untuk menampilkan movie yang kamu tidak selesai ditonton dan menurutmu itu movie yang kurang bagus buatmu
Finishlist untuk menampilkan movie yang sudah selesai kamu tonton

Dan untuk logout maka kamu akan dikembalikan ke login/sigIn Screen
satu fitur terakhir adalah reset password, reset password ini digunakan untuk mereset password menggunakan email.
Lalu nani akan dikirimkan reset passwordnya ke email yang kamu masukkan
![](screenshots/Reset_Password_Screen.png)

Untuk melakukan test unit dan widget bisa terlebih dahulu ke bagian service_api.dart lalu hapus semua static yang ada pada file tersebut lalu save.
Setelah itu dibagian unit_test Uncomment seluruh coding terlebih dahulu lalu save.
![](screenshots/Unit_Test.png)
![](screenshots/Widget_Test.png)
Pada terminal lakukan flutter test untuk ngetest unit dan widget yang sudah di coding.
![](screenshots/Flutter_Test.png)
