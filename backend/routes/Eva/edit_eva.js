const express =require('express')
const db =require('../../db')
const router = express.Router()
const {verifyToken,requireRole} = require('../../middleware/authmiddleware')
const bc = require('bcrypt')

router.get('/',verifyToken,requireRole('ผู้รับการประเมินผล'),async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const [rows] = await db.query(`select fname,lname,username,email,role from tb_member where id_member=?`,[id_member])
        res.json(rows[0])
    } catch (error) {
        console.error('error get USer',error)
        res.status(500).json({message:'error get USer'})
    }
})

router.put('/',verifyToken,requireRole('ผู้รับการประเมินผล'),async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const {fname,lname,username,password,email,role} = req.body
        if(password && password.trim()){
            const hash = await bc.hash(password,10)
            await db.query(`update tb_member set fname=?,lname=?,username=?,password=?,email=?,role=? where id_member=?`,[fname,lname,username,hash,email,role,id_member])
        }else{
            await db.query(`update tb_member set fname=?,lname=?,username=?,email=?,role=? where id_member=?`,[fname,lname,username,email,role,id_member])
        }
        res.json({message:'SUCCESS PUT MEMBER!!!'})
    } catch (error) {
        console.error('error put USer',error)
        res.status(500).json({message:'error put USer'})
    }
})

module.exports = router