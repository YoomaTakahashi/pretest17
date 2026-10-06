const express =require('express')
const db = require('../db')
const router = express.Router()

router.get('/',async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const [rows] = await db.query(`select * from tb_doc where`)
    } catch (error) {
        
    }
})