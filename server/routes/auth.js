const express =require("express");
const User = require("../models/user");
const bcrypt=require("bcryptjs");

const authRouter=express.Router();
//Get the data from user
authRouter.post("/api/signup",async (req,res)=>{
 try {
	const {name,email,password}=req.body;

 const existingUser= await User.findOne({email});
 //statuscode =400 is for client side error
 if(existingUser) {
	return res.status(400).json({msg:"User with same email already exists"})
 };

//  if (password !== confirmPassword) {
//   return res.status(401).json({ msg: "Password and Confirm Password do not match" });
// }

 const hashpassword =await bcrypt.hash(password,8)

let user=new User({
	email, 
	password: hashpassword,
	name,


 });

 user=await user.save();
 res.json(user);
 } catch(e) {
	res.status(500).json({error:e.message})
 }
});
module.exports=authRouter;
//also will make objects
//module.exports={authRouter:authRouter,name:"yash"};