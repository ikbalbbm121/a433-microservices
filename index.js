// Memuat konfigurasi dari file .env agar dapat diakses melalui process.env
require('dotenv').config();

// Mengimpor framework Express untuk menyediakan layanan server web
const express = require("express");
// Inisialisasi aplikasi Express
const app = express();

// Mengimpor library body-parser untuk memproses data dari body request (opsional untuk consumer)
const bp = require("body-parser");

// Mengimpor library amqplib yang merupakan client RabbitMQ untuk Node.js
const amqp = require("amqplib");

// Mengambil URL server RabbitMQ dari environment variable (contoh: amqp://guest:guest@rabbitmq:5672)
const amqpServer = process.env.AMQP_URL;

// Deklarasi variabel global untuk menyimpan koneksi dan channel RabbitMQ
var channel, connection;

// Memanggil fungsi utama untuk menghubungkan service ke antrean RabbitMQ
connectToQueue();

/**
 * Fungsi asinkronus untuk membangun koneksi ke broker pesan dan mulai mengonsumsi pesan
 */
async function connectToQueue() {
    try {
        // Membuka koneksi ke server RabbitMQ berdasarkan URL yang disediakan
        connection = await amqp.connect(amqpServer);
        
        // Membuat channel komunikasi di dalam koneksi tersebut
        channel = await connection.createChannel();
        
        // Memastikan antrean bernama "order" sudah tersedia (assertQueue bersifat idempoten)
        await channel.assertQueue("order");
        
        // Menentukan cara aplikasi menangani setiap pesan yang masuk ke antrean "order"
        channel.consume("order", data => {
            // Mengubah konten pesan dari format Buffer kembali menjadi teks/objek
            console.log(`Order received: ${Buffer.from(data.content)}`);
            
            // Log simulasi proses pengiriman barang
            console.log("** Will be shipped soon! **\n")
            
            // Mengirimkan tanda 'Acknowledge' (ack) ke RabbitMQ bahwa pesan sukses diproses
            // Hal ini penting agar RabbitMQ menghapus pesan tersebut dari antrean
            channel.ack(data);
        });
        
        console.log("Shipping Service sukses terhubung ke RabbitMQ");
    } catch (ex) {
        // Menangkap dan menampilkan error jika koneksi ke RabbitMQ gagal
        console.error("Gagal menyambung ke RabbitMQ:", ex);
    }
}

// Menjalankan server pada port yang ditentukan di file .env (biasanya 3001)
app.listen(process.env.PORT, () => {
    // Memberikan informasi di terminal bahwa server sudah aktif
    console.log(`Server running at ${process.env.PORT}`);
});