const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');

const PORT = process.env.PORT || 3000;

const app = express();
const Db = "mongodb+srv://ashutoshkapoor8965:GxGEqxeiptwlZCmh@cluster0.v5714d6.mongodb.net/?retryWrites=true&w=majority"

mongoose.connect(Db)
.then((result) => console.log("Connected to DB")).catch((err) => console.log(err));

app.use(express.json());
app.use(authRouter);

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server is running on port ${PORT}.`);
})

// GxGEqxeiptwlZCmh