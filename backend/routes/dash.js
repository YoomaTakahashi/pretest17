const express = require('express')
const db = require('../db')
const router = express.Router()
const {verifyToken,requireRole} = require('../middleware/authmiddleware')

router.get('/eva',verifyToken,requireRole('ผู้รับการประเมินผล'),async(req,res)=>{
    try {
        const id_member = req.user.id_member
    } catch (error) {
        console.error('error get USer',error)
        res.status(500).json({message:'error get USer'})
    }
})