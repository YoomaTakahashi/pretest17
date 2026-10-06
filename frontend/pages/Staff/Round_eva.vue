<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="12" md="12">
                <v-card>
                    <v-card-title>
                        <h1 class="text-center text-h5">จัดการรอบการประเมิน</h1>
                    </v-card-title>
                    <v-card-text>
                        <br>
                        <v-form @submit.prevent="saveMember">
                            <v-row>
                                <v-col cols="12" md="6">
                                    <v-text-field label="วันที่เปิดการประเมิน" v-model="form.day_open" :error-messages="error.day_open" type="date"></v-text-field>
                                </v-col>
                                <v-col cols="12" md="6">
                                    <v-text-field label="วันที่ปิดการประเมิน" v-model="form.day_out" :error-messages="error.day_out" type="date"></v-text-field>
                                </v-col>
                                <v-col cols="12" md="6">
                                    <v-text-field label="รอบการประเมิน" v-model="form.round_sys" :error-messages="error.round_sys" type="number"></v-text-field>
                                </v-col>
                                <v-col cols="12" md="6">
                                    <v-text-field label="ปีการประเมิน" v-model="form.year_sys" :error-messages="error.year_sys" type="number"></v-text-field>
                                </v-col>
                                <v-col cols="12" md="6">
                                    <v-select label="สถานะการประเมิน" v-model="form.status_sys" :error-messages="error.status_sys" :items="[{title:'เปิด',value:'y'},{title:'ปิด',value:'n'}]"></v-select>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col cols="12" md="12">
                                    <center>
                                        <v-btn class="ma-2 text-center" color="primary" type="submit">{{ form.id_sys ? 'อัปเดต':'บันทึก' }}</v-btn>
                                        <v-btn class="ma-2 text-center" color="error" @click="reset()">ยกเลิก</v-btn>
                                    </center>
                                </v-col>
                            </v-row>
                        </v-form>
                        <v-table class="table mt-3">
                            <thead>
                                <tr>
                                    <th class="border text-center">ลำดับ</th>
                                    <th class="border text-center">วันที่เปิดการประเมิน</th>
                                    <th class="border text-center">วันที่ปิดการประเมิน</th>
                                    <th class="border text-center">รอบการประเมิน</th>
                                    <th class="border text-center">ปีการประเมิน</th>
                                    <th class="border text-center">สถานะการประเมิน</th>
                                    <th class="border text-center">จัดการ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :key="items.id_sys">
                                    <td class="border text-center">{{ index+1 }}</td>
                                    <td class="border text-center">{{ formatDate(items.day_open) }}</td>
                                    <td class="border text-center">{{ formatDate(items.day_out) }}</td>
                                    <td class="border text-center">{{ items.round_sys }}</td>
                                    <td class="border text-center">{{ items.year_sys }}</td>
                                    <td class="border text-center">{{ items.status_sys === 'y' ? 'เปิด':'ปิด' }}</td>
                                    <td class="border text-center">
                                        <center>
                                            <v-btn class="text-center text-white ma-2" color="warning" @click="edit(items)" size="small">แก้ไข</v-btn>
                                            <v-btn class="text-center text-white ma-2" color="error" @click="del(items.id_sys)" size="small">ลบ</v-btn>
                                        </center>
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

const form = ref({
    id_sys:null,
    day_open:'',
    day_out:'',
    round_sys:'',
    year_sys:'',
    status_sys:''
})
const reset = ()=>{
    form.value = {
        id_sys:null,
        day_open:'',
        day_out:'',
        round_sys:'',
        year_sys:'',
        status_sys:''
    }
}
const result = ref([])
const search = ref('')

const emailRegex = /^[^\s]+@[^\s]+\.[^\s]{2,}$/i
function validateForm(){
    const f = form.value
    error.value = {}

    if(!f.day_open)error.value.day_open = 'กรุณาเลือกวันที่เปิดรอบการประเมิน'
    if(!f.day_out)error.value.day_out = 'กรุณาเลือกวันที่ปิดรอบการประเมิน'
    if(!f.round_sys)error.value.round_sys = 'กรุณากรอกรอบการประเมิน'
    if(!f.year_sys)error.value.year_sys = 'กรุณาปีการประเมิน'
    if(!f.status_sys)error.value.status_sys = 'กรุณาเลือกสถานะการประเมิน'

 
    return Object.keys(error.value).length === 0
}

const token = import.meta.client ? localStorage.getItem('token'):null
const saveMember = async()=>{
    if(!validateForm)return
    const f = form.value
    try {
        f.id_sys
        ? await axios.put(`${staff}/system/update/${f.id_sys}`,form.value,{headers:{Authorization:`Bearer ${token}`}})
        : await axios.post(`${staff}/system/save`,form.value,{headers:{Authorization:`Bearer ${token}`}})
        alert('ทำรายการสำเร็จ')
        await reset()
        await fetch()
    } catch (error) {
        console.error("error saveSystem",error);
        
    }
}

const fetch = async()=>{
    try {
        const res = await axios.get(`${staff}/system/show`,{headers:{Authorization:`Bearer ${token}`}})
        result.value = res.data
    } catch (error) {
        console.error("Error get system",error);
        
    }
}


const edit = (items:any)=>{
    form.value = {...items}
}

const del = async(id_sys:number)=>{
    if(!confirm('ต้องการลบข้อมูลชุดนี้ใฃ่หรือไม่'))return
    try {
        await axios.delete(`${staff}/system/delete/${id_sys}`,{headers:{Authorization:`Bearer ${token}`}})
        await fetch()
        await reset()
    } catch (error) {
        console.error("error delete system",error);
        
    }
}

const formatDate = (dateStr:string)=>{
    if(!dateStr)return '-'
    const date = new Date(dateStr)
    const day = String(date.getDate()).padStart(2,'0')
    const month = String(date.getMonth()).padStart(2,'0')
    const year = String(date.getFullYear())

    return `${day}/${month}/${year}`
}

onMounted(fetch)
</script>

<style scoped>

</style>