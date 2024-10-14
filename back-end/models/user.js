const mongoose = require('mongoose');
const joi = require('joi');
const jwt = require('jsonwebtoken');
require('dotenv').config();

//user model
const mongoSchema = mongoose.Schema({
    firstName: {
        type:String,
        required:true,
    },
    lastNAme: {
        type:String,
        required:true,
    },
    email: {
        type:String,
        required:true,
    },
    password: {
        type:String,
        required:true,
    },
    memos: [
        {
            timeStamp: {
                type:Date,
            },
            content: {
                type:String,
                required:true,
            }
        }
    ]
});

mongoSchema.methods.generateAuthToken = function() {
    const token = jwt.sign({_id: this._id},process.env.JWT_PRIVATE_KEY);
}

const User = mongoose.model('User',mongoSchema);

//REST validation
function validateUser(user) {
    const Schema = Joi.object({
        firstName: Joi.string().required(),
        lastName: Joi.string().required(),
        email: Joi.string().email().required(),
        password: Joi.string().required(),
    });
    return Schema.validate(user);
}

//exports
module.exports = {
    User,
    validateUser,
}