require('dotenv').config();

const express = require('express');
const dns = require('dns');
const bodyParser = require('body-parser');
const app = express();

// Configure mongoose
const mongoose = require('mongoose');
mongoose.connect(process.env.MONGO_URI, {useNewUrlParser: true, useUnifiedTopology: true});
const urlSchema = new mongoose.Schema({
  url: {
    type: String,
    required: true,
    unique: true
  }
});
const URLModel = mongoose.model('URL', urlSchema);

// Configure initial API handling
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log("App is listening");
});

// Sends landing page
app.get("/", (req, res) => {
  res.sendFile(process.cwd() + "/html/index.html");
});

// Check db for short url and redirect to website
app.get("/api/shorturl/:input", (req, res) => {
  const urlIndex = mongoose.Types.ObjectId(req.params.input);
  URLModel.findById(urlIndex, (err, doc) => {
    if (err) {
      res.send("Not found");
    } else {
      res.redirect(doc.url);
    }
  });
});

// Put new URL into db and return JSON with short url key
app.use("/api/shorturl/", bodyParser.urlencoded({extended: false}));
app.post("/api/shorturl/", (req, res) => {

  const originalURL = req.body.url;
  try {
    const urlObject = new URL(originalURL);
  } catch (err) {
    res.json({error: "Invalid URL"});
  }

  dns.lookup(urlObject.hostname, (err, add, fam) => {
      if (err) {
	res.json({error: "Invalid URL"});
      } else {
	  const msg = new URLModel({
	    url: originalURL
	  });
	  msg.save()
	    .then(doc => {
	      res.json({
		original_url: doc.url,
		short_url: doc._id
	      });
	    })
	    .catch(err => {
	      if (err.name === 'MongoError' && err.code === 11000) {
		//url already exists in database
		URLModel.find({url: originalURL})
		  .then(doc => {
		    res.json({
		      original_url: doc.url,
		      short_url: doc._id
		    });
		  })
		  .catch(err => console.log(err));
	      } else {
		  console.log(err);
	      }
	  });
      }
    });
});
