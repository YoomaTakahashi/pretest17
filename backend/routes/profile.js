const express =require('express')
const db = require('')
const router = express.Router()
const {verifyToken} =require('../middleware/authmiddlware')

router.get('/',verifytoken,async (req,res) => {
    try {
        const id_member = req.user.id_member
        const [rows] = await db.query(`select * from tb_member where id_member=?`[id_member])
        res.json(rows[0])
    } catch (error) {
        console.error('error get user',error)
        res.status(500).json({message:'error get user'})
    }
})
module.exports = router