const express = require('express')
const db = require('../db')
const router = express.Router()
const {verifyToken,requireRole} = require('../middleware/authmiddleware')

router.get('/eva',verifyToken,requireRole('ผู้รับการประเมินผล'),async(req,res)=>{
    try {
        const [[evaCount]] = await db.query(`select count(*)as total from tb_eva`)
        const [[y]] = await db.query(`select count(*)as total from tb_eva  where status_eva=3`)
        const [[n]] = await db.query(`select count(*)as total from tb_eva  where status_eva!=3`)
        res.json({
            box:[
                {title:'จำนวนฝ่ายบุคลากร',value:staff.total || 0},
                {title:'จำนวนผู้รับการประเมินผล',value:eva.total || 0},
                {title:'จำนวนกรรมการประเมิน',value:commit.total || 0},
            ],
            box2:[
                {title:'แบบประเมินทั้งหมด',value:evaCount.total || 0},
                {title:'แบบประเมินที่ประเมินผลแล้ว',value:evaCount.total > 0 ? `${(y.total*100/evaCount.total).toFixed(2)}%` : '00:00%'},
                {title:'แบบประเมินที่ยังไม่ได้ประเมิน',value:evaCount.total > 0 ? `${(n.total*100/evaCount.total).toFixed(2)}%` : '00:00%'},
            ]
        })
    } catch (error) {
        console.error('error get USer',error)
        res.status(500).json({message:'error get USer'})
    }
})

router.get('/staff',verifyToken,requireRole('ฝ่ายบุคลากร'),async(req,res)=>{
    try {
        const [[staff]] = await db.query(`select count(*)as total from tb_member where role ='ฝ่ายบุคลากร'`)
        const [[eva]] = await db.query(`select count(*)as total from tb_member where role ='ผู้รับการประเมินผล'`)
        const [[commit]] = await db.query(`select count(*)as total from tb_member where role ='กรรมการประเมิน'`)
        const [[evaCount]] = await db.query(`select count(*)as total from tb_eva`)
        const [[y]] = await db.query(`select count(*)as total from tb_eva  where status_eva=3`)
        const [[n]] = await db.query(`select count(*)as total from tb_eva  where status_eva!=3`)
        res.json({
            box:[
                {title:'จำนวนฝ่ายบุคลากร',value:staff.total || 0},
                {title:'จำนวนผู้รับการประเมินผล',value:eva.total || 0},
                {title:'จำนวนกรรมการประเมิน',value:commit.total || 0},
            ],
            box2:[
                {title:'แบบประเมินทั้งหมด',value:evaCount.total || 0},
                {title:'แบบประเมินที่ประเมินผลแล้ว',value:evaCount.total > 0 ? `${(y.total*100/evaCount.total).toFixed(2)}%` : '00:00%'},
                {title:'แบบประเมินที่ยังไม่ได้ประเมิน',value:evaCount.total > 0 ? `${(n.total*100/evaCount.total).toFixed(2)}%` : '00:00%'},
            ]
        })
    } catch (error) {
        console.error('error get USer',error)
        res.status(500).json({message:'error get USer'})
    }
})

module.exports = router