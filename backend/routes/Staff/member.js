const express = require('express')
const bc = require('bcrypt')
const router = express.Router()
const db = require('../../db')
const {verifyToken,requireRole} = require('../../middleware/authmiddleware')

router.post('/save',verifyToken,requireRole('ฝ่ายบุคลากร'),async(req,res)=>{
    try {
        const {fname,lname,email,username,password,role} = req.body
        
        const hash = await bc.hash(password,10)
        const [rows] = await db.query(`insert into tb_member(fname,lname,email,username,password,role) values(?,?,?,?,?,?)`,[fname,lname,email,username,hash,role])
        res.json(rows,{message:"saveMember"})
    } catch (error) {
        console.error("error saveMember",error);
        res.status(500).json({messge:"Error saveMember"})
        
    }
})

router.put('/update/:id_member',verifyToken,requireRole('ฝ่ายบุคลากร'),async(req,res)=>{
    try {
        const {id_member} = req.params
        const {fname,lname,email,username,password,role} = req.body
        if(password && password.trim()){
            const hash = await bc.hash(password,10)
            const [rows] = await db.query(`update tb_member set fname=?,lname=?,email=?,username=?,password=?,role=? where id_member = ? `,[fname,lname,email,username,hash,role,id_member])
            res.json(rows,{message:"update"})
        }else{
           const [rows] = await db.query(`update tb_member set fname=?,lname=?,email=?,username=?,role=? where id_member = ? `,[fname,lname,email,username,role,id_member])
            res.json(rows,{message:"update"}) 
        }
        
    } catch (error) {
        console.error("error update",error);
        res.status(500).json({messge:"Error update"})
        
    }
})

router.delete('/delete/:id_member',verifyToken,requireRole('ฝ่ายบุคลากร'),async(req,res)=>{
    try {
        const {id_member} = req.params
        
        const [rows] = await db.query(`delete from tb_member where id_member=?`,[id_member])
        res.json(rows,{message:"delete"}) 

    } catch (error) {
        console.error("error delete",error);
        res.status(500).json({messge:"Error delete"})
        
    }
})

router.get('/showE',verifyToken,requireRole('ฝ่ายบุคลากร'),async(req,res)=>{
    try {
        
        const [rows] = await db.query(`select * from tb_member where role='ผู้รับการประเมินผล' order by id_member desc`)
        res.json(rows,{message:"show"}) 

    } catch (error) {
        console.error("error show",error);
        res.status(500).json({messge:"Error show"})
        
    }
})

router.get('/showC',verifyToken,requireRole('ฝ่ายบุคลากร'),async(req,res)=>{
    try {
        
        const [rows] = await db.query(`select * from tb_member where role='กรรมการประเมิน' order by id_member desc`)
        res.json(rows,{message:"show"}) 

    } catch (error) {
        console.error("error show",error);
        res.status(500).json({messge:"Error show"})
        
    }
})

module.exports = router