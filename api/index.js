const express = require("express");
const cors = require("cors");
const connectDB = require("./db");
const User = require("./user");
const Product = require('./product');

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


app.post("/accounts/signin", async (req, res) => { //done
    try {
        const user = await User.findOne({ email: req.body.email, password: req.body.password });
        if (!user) throw new Error("User not found");
        res.json({message: "login success",user: user}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.get("/accounts/get/:id", async (req, res) => { //done
    try {
        const user = await User.findById(req.params.id);
        if (!user) throw new Error("User not found");
        res.json(user).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.post("/accounts/signup", async (req, res) => { // done
    try {
        const { name, email, password,admin } = req.body;
        const user = new User({ name, email, password, admin });
        if (!user) throw new Error("sign up failed");
        await user.save();
        res.json({user:user,message:"sign up success"}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.put("/accounts/update/:email", async (req, res) => { //done
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

app.delete("/accounts/delete", async (req, res) => { //done
    try {
        const user = await User.findOneAndDelete(req.body.id);
        if (!user) throw new Error("User not found");
        res.json(user).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.post("/accounts/addtocart", async (req, res) => { //done
    try{
        const { name, quantity, price,description, id } = req.body;
        const product = new Product({ name, quantity, price,description });
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

app.post("/accounts/removefromcart", async (req, res) => { //done
    try{
        const {userId,productId}=req.body;
        const user=await User.findOne({_id:userId});
        if (!user) throw new Error("User not found");
        const cart=user.cart;
        const newCart=cart.filter((product)=>product._id!=productId);
        user.cart=newCart;
        const newUser=await User.findOneAndUpdate(
            { _id: userId},
            user,
            { new: true },
        );
        res.json({user:user,message:"remove from cart success"}).status(200);
    }
    catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.post("/products/add", async (req, res) => { //done
    try {
        const { name, quantity, price,description } = req.body;
        const product = new Product({ name, quantity, price,description });
        if (!product) throw new Error("add product failed");
        await product.save();
        res.json({product:product,message:"add product success"}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.get("/products/get", async (req, res) => { //done
    try {
        const product = await Product.find();
        if (!product) throw new Error("product not found");
        res.json(product).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.get("/products/get/:name", async (req, res) => { //done
    try {
        const product = await Product.findOne({ name: req.params.name});
        if (!product) throw new Error("product not found");
        res.json(product).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.post("/products/filter", async (req, res) => { //done
    try {
        const products = await Product.find({price:{$gte:req.body.min,$lte:req.body.max}});
        if (!products) throw new Error("products not found");
        res.json({message: "search success",products: products}).status(200);
    } catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});

app.put("/products/update/:name", async (req, res) => { //done
    try {
        const product = await Product.findOneAndUpdate(
            { name: req.params.name},
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

app.delete("/products/delete", async (req, res) => { //done
    try {
        const product = await Product.findOneAndDelete(req.body.id);
        if (!product) throw new Error("product not found");
        res.json(product).status(200);
    }
    catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});