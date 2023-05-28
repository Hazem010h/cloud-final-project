const mongoose = require('mongoose');
var uniqueValidator = require('mongoose-unique-validator');

const productSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        unique:true,
    },
    quantity: {
        type: Number,
        required: true,
    },
    price:{
        type: Number,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    image:{
        type: String,
        required: true,
    },
});
productSchema.plugin(uniqueValidator);

const Product = mongoose.model('cart-product', productSchema);
module.exports = Product;