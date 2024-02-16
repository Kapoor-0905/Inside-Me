const express = require('express');
const authRouter = express.Router();
const bcryptjs = require('bcryptjs');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth'); 
// sign up route
authRouter.post("/api/signup", async (req, res) => {
    try { 
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: "User already exists" }); // 400 = Bad Request
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            email, password: hashedPassword, name,
        })
        user = await user.save();
        res.json(user);
    }
    catch (err) {
        res.status(500).json({ error: err.message }); // 500 = Internal Server Error
     }
});

// sign in route

authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (!existingUser) {
            return res.status(400).json({ message: "User does not exist" }); // 400 = Bad Request
        }
        const isPasswordCorrect = await bcryptjs.compare(password, existingUser.password);
        if (!isPasswordCorrect) {
            return res.status(400).json({ message: "Invalid credentials" }); // 400 = Bad Request
        }

        const token = jwt.sign({
            id: existingUser._id
        }, "passwordKey");

        res.json({token, ...existingUser._doc})

        // res.json({ message: "Sign in successful" });
    }
    catch (err) {
        res.status(500).json({ error: err.message }); // 500 = Internal Server Error
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);
        res.json(true);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
 });

// get user data
authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token})
});

module.exports = authRouter;