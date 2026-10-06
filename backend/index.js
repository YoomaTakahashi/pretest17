require('dotenv').config({path:'.env'})
const express = require('express')
const cors = require('cors')
const path = require('path')
const app = express()
const fileUp =require('express-fileupload')

app.use(cors({
    origin:'http://localhost:3000',
    credentials: true
}))

app.use(fileUp())
app.use(express.json())
app.use('/uploads',express.static(path.join(__dirname,'./uploads')))

const auth = require('./routes/auth')
app.use('/api/auth',auth)

const dash = require('./routes/dash')
app.use('/api/dash',dash)

const profile = require('./routes/profile')
app.use('/api/profile',profile)


//eva api

const selfeva = require('./routes/Eva/selfeva')
app.use('/api/Eva/selfeva',selfeva)

const score_member = require('./routes/Eva/score_member')
app.use('/api/Eva/score_member',score_member)

const score_commit = require('./routes/Eva/score_commit')
app.use('/api/Eva/score_commit',score_commit)

//commit
const show_eva = require('./routes/Commit/show_eva')
app.use('/api/Commit/show_eva',show_eva)

const save_score = require('./routes/Commit/save_score')
app.use('/api/Commit/save_score',save_score)


app.use((req,res)=> res.status(404).json({message:'Route not found'}))
app.listen(3001,()=>{
    console.log("Server Running on Port 3001");
    
})