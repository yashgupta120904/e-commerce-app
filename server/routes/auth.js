const express =require("express");
const User = require("../models/user");
const bcryptjs=require("bcryptjs");
const authRouter=express.Router();
const jwt =require("jsonwebtoken")
//Get the data from user
authRouter.post("/api/signup",async (req,res)=>{
 try {
	const {name,email,password,confirmpassword}=req.body;

 const existingUser= await User.findOne({email});
 //statuscode =400 is for client side error
 if(existingUser) {
	return res.status(400).json({msg:"User with same email already exists"})
 };

 const passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;
    if (!passwordRegex.test(password)) {
      return res.status(400).json({
        msg: "Password must be at least 8 chars, 1 uppercase, 1 number, 1 special character. Bhai hacker se dosti karwaani hai kya? 🔓"
      });
    }

//  if (password !== confirmpassword) {
//   return res.status(400).json({ msg: "Password and Confirm Password do not match" });
// }

 const hashpassword =await bcryptjs.hash(password,8)

let user=new User({
	email, 
	password: hashpassword,
	name,
	confirmpassword


 });

 user=await user.save();
 res.json(user);
 } catch(e) {
	res.status(500).json({error:e.message})
 }
});


authRouter.post("/api/signin", async (req,res)=>{
	try {
		const {email,password}=req.body;
		const user =await User.findOne({email});
		if(!user) {
			return res.status(400).json({msg:"User with this email does not exist!!!"});
		}
		const isMatch=await bcryptjs.compare(password,user.password);
		if(!isMatch){
			return res.status(400).json({msg:"Incorrect password."});
		}

		const token=jwt.sign({id:user._id},"passwordKey");//auth person
		res.json({token,...user._doc});
		//{means of user._doc
		//token:""
		//name:
		//email:
		//}


	}catch(e) {
		res.status(500).json({error:e.message})
	}
});

authRouter.post("/tokenIsValid",async(req,res)=>{
	try{
		const token =req.header(x-auth-token);
		if(!token) return res.json(false);
		const verified= jwt.verify(token,"passwordKey");
		if(!verified) return res.json(false);

		const user= await User.findById(verified.id);
		if(!user) return res.json(false);
		res.json(true);

	}catch(e){
		res.status(500).json({error: e.message})
	}

	//get user data
	authRouter.get('/',auth,async(req,res)=>{
		const user=await User.findById(req.user);
		res.json({...user>_doc,token :req.token});
	});

})
module.exports=authRouter;
//also will make objects
//module.exports={authRouter:authRouter,name:"yash"};