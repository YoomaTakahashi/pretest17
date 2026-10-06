<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="12" md="12">
                <v-card>
                    <v-card-title>
                        <h1 class="text-center text-h5">สถานะการประเมินของผู้รับการประเมินผล</h1>
                    </v-card-title>
                    <v-card-text>
                        <br>
                        <v-table class="table mt-3">
                            <thead>
                                <tr>
                                    <th class="border text-center">ลำดับ</th>
                                    <th class="border text-center">ผู้รับการประเมินผล</th>
                                    <th class="border text-center">รอบการประเมิน</th>
                                    <th class="border text-center">วันที่ออกแบบการประเมิน</th>
                                    <th class="border text-center">สถานะ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :key="items.id_eva">
                                    <td class="border text-center">{{ index+1 }}</td>
                                    <td class="border text-center">{{ items.fname }} {{ items.lname }}</td>
                                    <td class="border text-center">รอบการประเมินที่:{{ items.round_sys }} ปีการประเมิน:{{ items.year_sys }}</td>
                                    <td class="border text-center">{{ formatDate(items.day_eva) }}</td>
                                    <td class="border text-center">
                                        <v-btn class="text-center text-white ma-2" :color="bg(items.status_eva)" size="small">{{ items.status_eva === 1 ? 'รอการประเมินตนเอง':items.status_eva === 2 ? 'รอกรรมการประเมิน':'ประเมินสำเร็จ' }}</v-btn>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center text-red" colspan="12" v-if="result.length === 0">ไม่พบข้อมูล</td>
                                </tr>
                            </tbody>
                        </v-table>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios'
import { api,staff } from '../../API/base'

const error = ref<Record<string,string>>({})
const eva = ref([])
const round = ref([])

const form = ref({
    id_eva:null,
    id_member:'',
    id_sys:'',
    day_eva:''
})
const reset = ()=>{
    form.value = {
        id_eva:null,
        id_member:'',
        id_sys:'',
        day_eva:''
    }
}
const dataResult = ref([])
const search = ref('')
const result = computed(()=>{
    if(!search.value)return dataResult.value
    const s = search.value.toLowerCase()

    return dataResult.value.filter((items:any)=>{
        return(
            items.fname?.toLowerCase().includes(s)
        )
    })
})
function validateForm(){
    const f = form.value
    error.value = {}

    if(!f.id_member)error.value.id_member = 'กรุณาเลือกผู้รับการประเมิน'
    if(!f.id_sys)error.value.id_sys = 'กรุณาเลือกรอบการประเมิน'
    if(!f.day_eva)error.value.day_eva = 'กรุณาเลือกวันที่ออกแบบการประเมิน'

    return Object.keys(error.value).length === 0
}

const token = import.meta.client ? localStorage.getItem('token'):null
const saveMember = async()=>{
    if(!validateForm())return
    const f = form.value
    try {
        f.id_eva
        ? await axios.put(`${staff}/eva/update/${f.id_eva}`,form.value,{headers:{Authorization:`Bearer ${token}`}})
        : await axios.post(`${staff}/eva/save`,form.value,{headers:{Authorization:`Bearer ${token}`}})
        alert('ทำรายการสำเร็จ')
        await reset()
        await fetch()
    } catch (error) {
        console.error("error saveEva",error);
        
    }
}

const fetch = async()=>{
    try {
        const res = await axios.get(`${staff}/eva/show`,{headers:{Authorization:`Bearer ${token}`}})
        dataResult.value = res.data
        const evaluatee = await axios.get(`${staff}/member/showE`,{headers:{Authorization:`Bearer ${token}`}})
        eva.value = evaluatee.data
        const system = await axios.get(`${staff}/system/show`,{headers:{Authorization:`Bearer ${token}`}})
        round.value = system.data
    } catch (error) {
        console.error("Error get eva",error);
        
    }
}


const edit = (items:any)=>{
    form.value = {...items}
}

const del = async(id_eva:number)=>{
    if(!confirm('ต้องการลบข้อมูลชุดนี้ใฃ่หรือไม่'))return
    try {
        await axios.delete(`${staff}/eva/delete/${id_eva}`,{headers:{Authorization:`Bearer ${token}`}})
        await fetch()
        await reset()
    } catch (error) {
        console.error("error delete eva",error);
        
    }
}

const formatDate = (dateStr:string)=>{
    if(!dateStr)return '-'
    const date = new Date(dateStr)
    const day = String(date.getDate()).padStart(2,'0')
    const month = String(date.getMonth()+1).padStart(2,'0')
    const year = String(date.getFullYear())

    return `${day}/${month}/${year}`
}

const go = (id_eva:number)=>{
    navigateTo({path:`/Staff/score_member-${id_eva}`})
}

onMounted(fetch)
</script>

<style scoped>

</style>