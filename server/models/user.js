const mongoose =require("mongoose");

const userSchema=mongoose.Schema({
	name:{
		type: String,
		require:true,
		trim:true,
	},
	email:{
		require:true,
		type:String,
		trim:true,
		validate: {
		validator:(value)=> {
			const regex=  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return regex.test(value);
		},
		message:'Please enter a valid email address',	
	}	
	},
	password: {
    type: String,
    required: true,
    trim: true, 
  validate: [
    {
      validator: (value) => value.length >= 8,
      message: "Password must be at least 8 characters long, chhota lund wale passwords nahi chalte 😤"
    },
    {
      validator: (value) => /[A-Z]/.test(value),
      message: "Password must contain at least one uppercase letter, bhai caps lock dabaa le thoda 😮‍💨"
    },
    {
      validator: (value) => /\d/.test(value),
      message: "Password must include at least one number, bina number ke kya hi security? 📉"
    },
    {
      validator: (value) => /[@$!%*?&]/.test(value),
      message: "Password must have one special character (@$!%*?&), warna hacker tumhari gand maar dega 🧠"
    }
  ]
},

	address:{
		type: String,
		default:''
	},
	type:{
		type:String,
		default:'user'
	}
});

// Virtual field for confirm password

const User = mongoose.model("User", userSchema);
module.exports=User;

