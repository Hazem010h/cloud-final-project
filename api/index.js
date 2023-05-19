const express = require("express");
const cors = require("cors");
const connectDB = require("./db");
const User = require("./user");

const app = express();

connectDB();

const post = 3000;
app.use(
    express.json(),
    cors({
        origin: "*",
        methods: ["GET", "POST", "DELETE", "UPDATE", "PUT", "PATCH"],
        credentials:true,
        accesscontrolalloworigin: "*",
    })
);
app.listen(post, () => {
    console.log(`Auth Server is running on port ${post}`);
});


app.post("/accounts/signin", async (req, res) => {
    try {
        const user = await User.findOne({ email: req.body.email, password: req.body.password });
        if (!user) throw new Error("User not found");
        res.json({message: "login success",user: user}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.get("/accounts/get", async (req, res) => {
    try {
        const user = await User.findById(req.body.id);
        if (!user) throw new Error("User not found");
        res.json(user).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.post("/accounts/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const user = new User({ name, email, password });
        if (!user) throw new Error("sign up failed");
        await user.save();
        res.json({user:user,message:"sign up success"}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.put("/accounts/update/:email", async (req, res) => {
    try {
        const user = await User.findOneAndUpdate(
            { email: req.params.email},
            req.body,
            { new: true }
        );
        if (!user) throw new Error("User not found");
        res.json({user:user,message:"update success"}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.delete("/accounts/delete", async (req, res) => {
    try {
        const user = await User.findOneAndDelete(req.body.id);
        if (!user) throw new Error("User not found");
        res.json(user).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});