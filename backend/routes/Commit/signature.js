const express =require('express')
const db =require('../../db')
const path = require('path')
const fs = require('fs')
const uploadDir = path.join(__dirname,'../../uploads/signature')
const router = express.Router()
const bc = require('bcrypt')
const {verifyToken,requireRole} = requireRole('../../middleware/authmiddleware.js')

router.get('/:id_eva',verifyToken,requireRole('กรรมการประเมิน'),async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const id_eva = req.params.id_eva
        const [rows] = await db.query(`select * from tb_commit where id_eva=? and id_member=? `,[id_eva,id_member])
        res.json(rows[0])
    } catch (error) {
        console.error("Error Get",err)
        res.status(500).json({message:'Error Get'})
    }
})

router.post('/:id_eva',verifyToken,requireRole('กรรมการประเมิน'),async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const id_eva = req.params.id_eva
        const file = req.files?.file
        const filename = Date.now() + path.extname(file.name)
    } catch (error) {
        
    }
})