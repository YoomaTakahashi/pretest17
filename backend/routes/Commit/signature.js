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
        await file.mv(path.join(uploadDir,filename))
        await db.query(`update tb_commit set signature=? where id_eva=? and id_member=?`,[filename,id_eva,id_member])
        const [SumCommit] = await db.query(`select * from tb_commit where status_commit=? and signature!='${null}' and id_eva=?`,['y',id_eva])
        if(SumCommit.length === 3){
            await db.query(`update tb_eva set status_eva=? where id_eva=?`,[3,id_eva])
        }
        res.status(201).join({message:'UPLOAD SUCCESS!!!!'})
    } catch (error) {
        console.error("Error Upload",err)
        res.status(500).json({message:'Error Upload'})
    }
})

router.delete('/:id_eva',verifyToken,requireRole('กรรมการประเมิน'),async(req,res)=>{
    try {
        const id_member = req.user.id_member
        const id_eva = req.params.id_eva
        const [[d]] = await db.query(`select signature from tb_commit where id_eva=? and id_member=?`,[id_eva,id_member])
        res.status(201).join({message:'UPLOAD SUCCESS!!!!'})
        const fp = path.join(uploadDir,d.signature)
        if(fs.existsSync(fp)){
            fs.unlinkSync(fp)
        }
        await db.query(`update tb_commit set signature=? where id_eva=? and id_member=?`,[null,id_eva,id_member])
        res.json({message:'Delete Success!'})
    } catch (error) {
        console.error("Error del",err)
        res.status(500).json({message:'Error del'})
    }
})


module.exports = router