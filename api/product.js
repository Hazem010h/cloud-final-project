const mongoose = require('mongoose');
var uniqueValidator = require('mongoose-unique-validator');

const productSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    quantity: {
        type: Number,
        required: true,
    },
    price:{
        type: Number,
        required: true,
    },
});
productSchema.plugin(uniqueValidator);

const Product = mongoose.model('Product', productSchema);
module.exports = Product;