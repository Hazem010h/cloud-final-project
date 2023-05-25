const express = require("express");
const cors = require("cors");
const connectDB = require("./db");
const User = require("./user");
const Product = require("./cart-product");

const app = express();

connectDB();

const post = 7700;
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

app.delete("/accounts/delete/:email", async (req, res) => { //done
    try {
        const user = await User.findOneAndDelete({
            email: req.params.email,
        });
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

//checkout cart
app.post("/accounts/checkout", async (req, res) => {
    try{
        const {userId}=req.body;
        const user=await User.findOne({_id:userId});
        if (!user) throw new Error("User not found");
        user.cart=[];
        await User.findOneAndUpdate(
            { _id: userId},
            user,
            { new: true },
        );
        res.json({user:user,message:"remove from cart success"}).status(200);
    }
    catch (error) {
        res.json({ message: error.toString("ascii") }).status(500);
    }
}); //done