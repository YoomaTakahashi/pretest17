<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="12" md="12">
                <v-card>
                    <v-card-title>
                        <h1 class="text-center text-h5">จัดการหัวข้อการประเมิน</h1>
                    </v-card-title>
                    <v-card-text>
                        <br>
                        <v-form @submit.prevent="saveMember">
                            <v-row>
                                <v-col cols="12" md="12">
                                    <v-text-field label="ชื่อหัวข้อการประเมิน" v-model="form.name_topic" :error-messages="error.name_topic"></v-text-field>
                                </v-col>

                            </v-row>
                            <v-row>
                                <v-col cols="12" md="12">
                                    <center>
                                        <v-btn class="ma-2 text-center" color="primary" type="submit">{{ form.id_topic ? 'อัปเดต':'บันทึก' }}</v-btn>
                                        <v-btn class="ma-2 text-center" color="error" @click="reset()">ยกเลิก</v-btn>
                                    </center>
                                </v-col>
                            </v-row>
                        </v-form>
                        <v-text-field class="mt-3" v-model="search" label="ค้นหา" prepend-inner-icon="mdi-magnify"></v-text-field>
                        <v-table class="table mt-3">
                            <thead>
                                <tr>
                                    <th class="border text-center">ลำดับ</th>
                                    <th class="border text-center">ชื่อหัวข้อการประเมิน</th>
                                    <th class="border text-center">จัดการ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :key="items.id_topic">
                                    <td class="border text-center">{{ index+1 }}</td>
                                    <td class="border text-center">{{ items.name_topic }}</td>
                                    <td class="border text-center">
                                        <center>
                                            <v-btn class="text-center text-white ma-2" color="warning" @click="edit(items)" size="small">แก้ไข</v-btn>
                                            <v-btn class="text-center text-white ma-2" color="error" @click="del(items.id_topic)" size="small">ลบ</v-btn>
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
    id_topic:null,
    name_topic:''
})
const reset = ()=>{
    form.value = {
        id_topic:null,
        name_topic:''
    }
}
const dataResult = ref([])
const search = ref('')

const emailRegex = /^[^\s]+@[^\s]+\.[^\s]{2,}$/i
function validateForm(){
    const f = form.value
    error.value = {}

    if(!f.name_topic.trim())error.value.name_topic = 'กรุณากรอกชื่อหัวข้อการประเมิน'

    return Object.keys(error.value).length === 0
}

const token = import.meta.client ? localStorage.getItem('token'):null
const saveMember = async()=>{
    if(!validateForm())return
    const f = form.value
    try {
        f.id_topic
        ? await axios.put(`${staff}/topic/update/${f.id_topic}`,form.value,{headers:{Authorization:`Bearer ${token}`}})
        : await axios.post(`${staff}/topic/save`,form.value,{headers:{Authorization:`Bearer ${token}`}})
        alert('ทำรายการสำเร็จ')
        await reset()
        await fetch()
    } catch (error) {
        console.error("error saveTopic",error);
        
    }
}

const fetch = async()=>{
    try {
        const res = await axios.get(`${staff}/topic/show`,{headers:{Authorization:`Bearer ${token}`}})
        dataResult.value = res.data
    } catch (error) {
        console.error("Error get topic",error);
        
    }
}

const result = computed(()=>{
    if(!search.value)return dataResult.value
    const s = search.value.toLowerCase()

    return dataResult.value.filter((items:any)=>{
        return(
            items.name_topic?.toLowerCase().includes(s)
        )
    })
})

const edit = (items:any)=>{
    form.value = {...items}
}

const del = async(id_topic:number)=>{
    if(!confirm('ต้องการลบข้อมูลชุดนี้ใฃ่หรือไม่'))return
    try {
        await axios.delete(`${staff}/topic/delete/${id_topic}`,{headers:{Authorization:`Bearer ${token}`}})
        await fetch()
        await reset()
    } catch (error) {
        console.error("error delete topic",error);
        
    }
}

onMounted(fetch)
</script>

<style scoped>

</style>