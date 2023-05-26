const express = require("express");
const cors = require("cors");
const { default: axios } = require("axios");


const app = express();

const post = 3000;
app.use(
    express.json(),
    cors({
        origin: "*",
        methods: ["GET", "POST", "DELETE", "UPDATE", "PUT", "PATCH"],
        credentials: true,
        accesscontrolalloworigin: "*",
    })
);
app.listen(post, () => {
    console.log(`Auth Server is running on port ${post}`);
});

const accountsUrl = "http://users-api:7700/accounts";
const productsUrl = "http://products-api:7555/products";


app.post("/accounts/signin", async (req, res) => {
    fetch(`${accountsUrl}/signin`, {
        method: "POST",
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(req.body),
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.get("/accounts/get/:id", async (req, res) => {
    fetch(`${accountsUrl}/get/${req.params.id}`)
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.post("/accounts/signup", async (req, res) => {
    fetch(`${accountsUrl}/signup`, {
        method: "POST",
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(req.body),
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.put("/accounts/update/:email", async (req, res) => {
    fetch(`${accountsUrl}/update/${req.params.email}`, {
        method: "PUT",
        body: JSON.stringify(req.body),
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.delete("/accounts/delete/:email", async (req, res) => {
    fetch(`${accountsUrl}/delete/${req.params.email}`, {
        method: "DELETE",
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.post("/accounts/addtocart", async (req, res) => {
    fetch(`${accountsUrl}/addtocart`, {
        method: "POST",
        body: JSON.stringify(req.body),
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.post("/accounts/removefromcart", async (req, res) => {
    fetch(`${accountsUrl}/removefromcart`, {
        method: "POST",
        body: JSON.stringify(req.body),
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.post("/accounts/checkout", async (req, res) => {
    fetch(`${accountsUrl}/checkout`, {
        method: "POST",
        body: JSON.stringify(req.body),
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

//----------------------------------------------------------------------------------------------------

app.post("/products/add", async (req, res) => {
    fetch(`${productsUrl}/add`, {
        method: "POST",
        body: JSON.stringify(req.body),
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.get("/products/get", async (req, res) => {
    fetch(`${productsUrl}/get`)
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.post("/products/search", async (req, res) => {
    fetch(`${productsUrl}/search`, {
        method: "POST",
        body: JSON.stringify(req.body),
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.post("/products/filter", async (req, res) => {
    fetch(`${productsUrl}/filter`, {
        method: "POST",
        body: JSON.stringify(req.body),
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.put("/products/update/:name", async (req, res) => {
    fetch(`${productsUrl}/update/${req.params.name}`, {
        method: "PUT",
        body: JSON.stringify(req.body),
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

app.delete("/products/delete/:name", async (req, res) => {
    fetch(`${productsUrl}/delete/${req.params.name}`, {
        method: "DELETE",
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
    })
        .then(response => response.json())
        .then(data => res.json(data))
        .catch(error => res.json({ message: error.toString("ascii") }).status(500));
});

