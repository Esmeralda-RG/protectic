const express = require('express');
const cors = require('cors'); // 👈 importa cors
const authRoutes = require('./routes/authRoutes');
require('dotenv').config();

const app = express();

const allowedOrigin = 'http://localhost:33855'; 

app.use(cors({
  origin: allowedOrigin,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type'],
}));

app.use(express.json());

app.use('/', authRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`✅ Backend ProtecTIC escuchando en http://localhost:${PORT}`);
});
