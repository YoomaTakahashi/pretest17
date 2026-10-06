const express =require('express')
const db =require('../../db')
const router = express.Router()
const {verifyToken,requireRole} = require('../../middleware/authmiddleware')
const path = require('path')
const uploadDir = path.join(uploadDir,'../../uploads/file_eva')

router.get('/user',verifyToken,requierRole('ผู้รับการประเมินผล'),async (req,res) {
    try {
        const id_member = req.user.id_member
        const [rows] = await db.query(`selec * from tb_member m,tb_eva e,tb_system s where e.id_member=? and e.id_member=m.id_member and e.id_sys=s.id_sys order by e.id_eva desc`,[id_member])
        res.json(rows[0])
    } catch (error) {
        console.error('error get user',error)
        res.status(500).json({message:'error get user'})
    }
})

router.get('/topic',verifyToken,requireRole('ผู้รับการประเมินผล'),async (req,res) => {
    try {
        const id_member = req.user.id_member 
        const [topics]= await db.query(`select * from tb_topic`)
        const [indicates] = await db.query(`select * from tb_indicate`)
        const result = topics.map(t=>({
            ...t, indicates:indicates.filter((i)=> i.id_topic === t.id_topic)
        }))
        res.json(result)
    } catch (error) {
        console.error('error get topics',error)
        res.status(500).json({message:'error get topics'})
    }
    
})
module.exports = router
