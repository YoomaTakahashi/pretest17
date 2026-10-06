const express =require('express')
const db = require('../db')
const router = express.Router()

router.get('/',async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const [rows] = await db.query(`select * from tb_doc where id_doc`)
        res.json(rows[0])
    } catch (error) {
        console.error('error get USer',error)
        res.status(500).json({message:'error get USer'})
    }
})
module.exports = router