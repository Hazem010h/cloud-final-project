const express = require("express");
const cors = require("cors");
const connectDB = require("./db");
const User = require("./user");
const Product = require('./product');

const app = express();

connectDB();

const post = 5000;
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

app.get("/accounts/get/:id", async (req, res) => {
    try {
        const user = await User.findById(req.params.id);
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

app.post("/accounts/addtocart", async (req, res) => {
    try{
        const { name, quantity, price, id } = req.body;
        const product = new Product({ name, quantity, price });
        if (!product) throw new Error("add product failed");
        const user=await User.findOneAndUpdate(
            { _id: id},
            {$push:{cart:product}},
            { new: true }
        );
        if (!user) throw new Error("User not found");
        res.json({user:user,message:"add to cart success"}).status(200);
    }
    catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.post("/accounts/removefromcart", async (req, res) => {
    try{
        const {userId,productId}=req.body;
        const user=await User.findOneAndUpdate(
            { _id: userId},
            {$pop:{cart:{_id:productId}}},
            { new: true }
        );
        if (!user) throw new Error("User not found");
        res.json({user:user,message:"remove from cart success"}).status(200);
    }
    catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.post("/products/add", async (req, res) => {
    try {
        const { name, quantity, price } = req.body;
        const product = new Product({ name, quantity, price });
        if (!product) throw new Error("add product failed");
        await product.save();
        res.json({product:product,message:"add product success"}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.get("/products/get", async (req, res) => {
    try {
        const product = await Product.find();
        if (!product) throw new Error("product not found");
        res.json(product).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.get("/products/get/:id", async (req, res) => {
    try {
        const product = await Product.findById(req.params.id);
        if (!product) throw new Error("product not found");
        res.json(product).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.post("/products/filter", async (req, res) => {
    try {
        const products = await Product.findOne({_id:req.body.id, price:{$gte:req.body.min,$lte:req.body.max}});
        if (!products) throw new Error("products not found");
        res.json({message: "search success",products: products}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.put("/products/update/:id", async (req, res) => {
    try {
        const product = await Product.findOneAndUpdate(
            { _id: req.params.id},
            req.body,
            { new: true }
        );
        if (!product) throw new Error("product not found");
        res.json({product:product,message:"update success"}).status(200);
    }
    catch (error) { 
        res.json({ message: error.toString("ascii") }).status(500);
    }
});