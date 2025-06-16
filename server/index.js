
//IMPORTS FROM PACKAGES
const express= require('express')
const mongoose=require('mongoose')

//IMPORT FROM OTHER FILES 
const authRouter=require("./routes/auth")

//INIT
const PORT =process.env.PORT || 3000;
const app =express();//INITIALIZE
const DB="mongodb+srv://yash:5uvFm9W6akiOgw5G@cluster0.a9d3blk.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"


//MIDDLEWARE
app.use(express.json())//Returns middleware that only parses json and only looks at requests where the Content-Type header matches the type option.
app.use(authRouter);
//CLIENT ->MIDDLEWARE ->SERVER->CLIENT


mongoose.connect(DB).then(()=>{
	console.log("connection sucessful");

}).catch((e) => {
	console.log(e);
});




//get :- create a get reuest giving a json response with key 
//and value of your name 

//EXAMPLESSSSS
//  //creating an api 

// app.get("/",(require,res)=>{
// 	res.json({"name": "YASH",
// 		       "caste":"GN"

// 	})
// })

// //http/<ipaddress/hello-world> means path
// app.get("/hello-world",(req,res)=>{
// 	// res.send("do it ypur own");
// 	res.json({hi:"hello"})

// });
app.listen(PORT,"0.0.0.0",()=>{
	console.log(`connected at ${PORT}`)

})