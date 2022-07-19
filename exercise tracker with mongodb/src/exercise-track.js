require('dotenv').config();

const express = require('express');
const dns = require('dns');
const bodyParser = require('body-parser');
const app = express();

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log("App is listening");
});

// Configure mongoose
const mongoose = require('mongoose');
mongoose.connect(process.env.MONGO_URI, {useNewUrlParser: true, useUnifiedTopology: true});

// Create mongoose schemas
const exerciseSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Types.ObjectId,
    required: true
  },
  description: {
    type: String,
    required: true,
  },
  duration: {
    type: Number,
    required: true
  },
  date: {
    type: Date,
    required: true
  }
});

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true
  }
});

// Create mongoose models from schemas
const exerciseModel = mongoose.model('exercise', exerciseSchema);
const userModel = mongoose.model('user', userSchema);

// Create express routes
app.get("/", (req, res) => {
  res.sendFile(process.cwd() + "/html/index.html");
});

// Create log request function
app.get("/api/users/:_id/logs", (req, res) => {
  //need to learn javascript asynch handling better to pull this out into a function
  const userId = mongoose.Types.ObjectId(req.params._id);
  let username;
  userModel.findById(userId)
    .then(doc => username = doc.username)
    .catch(err => console.error(err));

  let query = {userId: userId};
  if (req.query.hasOwnProperty('from') || req.query.hasOwnProperty('to')) {
    query.date = {};
  }
  if (req.query.hasOwnProperty('from')) {
    query.date.$gte = new Date(req.query.from);
  }
  if (req.query.hasOwnProperty('to')) {
    query.date.$lte = new Date(req.query.to);
  }

  exerciseModel.find(query)
	       .limit(req.query.limit)
	       .then(logs => {
		 res.json({username: username,
			   count: logs.length,
			   _id: userId,
			   log: logs.map(record => {

			     const dateString = record.date.toISOString().split('T')[0].replace(/-/g, '\/');
			     return Object.assign({}, record, {date: new Date(dateString).toDateString()});
			   })
		 });
	       })
	       .catch(err => console.error(err));
});

// Create list users function
app.get("/api/users", (req, res) => {
  userModel.find()
    .then(doc => {
      res.json(doc);
    })
    .catch(err => console.error(err));
});

// Use bodyParser for parsing POST requests
app.use("/api/users/", bodyParser.urlencoded({extended: false}));

// Create user function
app.post("/api/users/", (req, res) => {
  const username = req.body.username;

  const msg = new userModel({
    username: username
  });
  msg.save()
    .then(newUser => {
      res.json({
	username: newUser.username,
	_id: newUser._id
      });
    })
    .catch(err => {
      console.log(err.name + ": " + err.code);
      if (err.code === 11000) {
	userModel.find({username: username})
	  .select({__v: 0})
	  .then(existingUser => {
	    console.log(existingUser);
	    res.json(existingUser);
	  })
	  .catch(err => console.error(err));
      }
    });
});

// Create add exercise function
app.post("/api/users/:_id/exercises/", (req, res) => {
  const userId = mongoose.Types.ObjectId(req.params._id);
  let username;
  userModel.findById(userId)
    .then(doc => {
      username = doc.username;
    })
    .catch(err => console.error(err));

  let exerciseDate;
  try {
    exerciseDate = new Date(req.body.date.replace(/-/g, '\/'));
  } catch {
    exerciseDate = new Date;
  }

  const msg = new exerciseModel({
    userId: userId,
    description: req.body.description,
    date: exerciseDate,
    duration: req.body.duration
  });
  msg.save()
    .then(doc => {
      res.json({
	username: username,
	description: doc.description,
	duration: Number(doc.duration),
	date: doc.date.toDateString(),
	_id: req.params._id
      });
    })
    .catch(err => console.error(err));
});
