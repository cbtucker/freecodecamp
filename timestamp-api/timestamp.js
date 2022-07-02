const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

//testing
app.get("/", (req, res) => {
  res.send("<h2>It's working!</h2>");
})

app.listen(PORT, () => {
  console.log(`API is listening on ${PORT}`);
})

//timestamp api
const unixRegex = /^\d+$/;

app.get("/api", (req, res) => {
  const time = new Date();
  response = {unix: time.getTime(), utc: time};
  res.json(response);
});

app.get("/api/:date", (req, res) => {
  let time = (unixRegex.test(req.params.date)) ?
    new Date(Number.parseInt(req.params.date)) :
    new Date(req.params.date);

  let response = (time == "Invalid Date") ?
    {error: "Invalid Date"} :
    {unix: time.getTime(), utc: time.toUTCString()};

  res.json(response);
});
