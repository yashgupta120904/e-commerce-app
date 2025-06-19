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
    require: true,
    trim: true,
   
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

