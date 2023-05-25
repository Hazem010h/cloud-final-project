const express = require("express");
const cors = require("cors");
const connectDB = require("./db");
const Product = require('./product');

const app = express();

connectDB();

const post = 7555;
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

app.post("/products/search", async (req, res) => { 
    try {
        const products = await Product.find({name:{$regex:req.body.name,$options:'i'}});
        if (!products) throw new Error("products not found");
        res.json({message: "search success",products: products}).status(200);
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

app.delete("/products/delete/:name", async (req, res) => { //done
    try {
        const product = await Product.findOneAndDelete({
            name: req.params.name,
        });
        if (!product) throw new Error("product not found");
        res.json(product).status(200);
    }
    catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
});