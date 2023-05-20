const mongoose = require('mongoose');
var uniqueValidator = require('mongoose-unique-validator');

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    email:{
        type: String,
        required: true,
        unique:true,
    },
    password:{
        type: String,
        required: true,
    },
    cart:{
        type: Array,
        required: false,
    },
});
userSchema.plugin(uniqueValidator);

const User = mongoose.model('User', userSchema);
module.exports = User;