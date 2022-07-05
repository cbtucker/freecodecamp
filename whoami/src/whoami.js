const express = require('express');

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  const parsed = {ipaddress: req.ip, language: req.header("Accept-Language"), software: req.header("User-Agent")};
  res.json(parsed);
});

app.listen(PORT, () => {
  console.log(`API is listening on port ${PORT}`);
});
