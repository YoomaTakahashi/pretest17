<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="12" md="12">
                <v-card>
                    <v-card-title>
                        <h1 class="text-center text-h5">ยืนยันผลการประเมิน</h1>
                    </v-card-title>
                    <v-card-text class="bg-white">
                        <br>
                        <v-form v-if="!result.signature" @submit.prevent="saveMember">
                            <v-row>
                                <v-col cols="12" md="6">
                                    <v-text-field label="ชื่อเอกสาร" v-model="name_doc" :error-messages="error.name_doc" prepend-inner-icon="mdi-file-edit"></v-text-field>
                                </v-col>
                                <v-col cols="12" md="6">
                                    <v-file-input label="เอกสาร" v-model="file" :error-messages="error.file" accept=".pdf" hint="รองรับเฉพาะไฟล์ PDF ขนาด 10MB" persistent-hint></v-file-input>
                                </v-col> 

                            </v-row>
                            <v-row>
                                <v-col cols="12" md="12">
                                    <center>
                                        <v-btn class="ma-2 text-center" color="primary" type="submit">บันทึก</v-btn>
                                        <v-btn class="ma-2 text-center" color="error" type="reset">ยกเลิก</v-btn>
                                    </center>
                                </v-col>
                            </v-row>
                        </v-form>
                        
                        <v-table class="table mt-3">
                            <thead>
                                <tr>
                                    <th class="border text-center">ลำดับ</th>
                                    <th class="border text-center">ไฟล์</th>
                                    <th class="border text-center">จัดการ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :key="items.id_doc">
                                    <td class="border text-center">{{ index+1 }}</td>
                                    <td class="border text-center">{{ items.name_doc }}</td>
                                    <td class="border text-center">
                                        <v-btn class="text-center text-white ma-2" color="info" prepend-icon="mdi-eye" @click="view(items.file)" size="small">เปิดดู</v-btn>
                                        <v-btn class="text-center text-white ma-2" color="error" @click="del(items.id_doc)" size="small">ลบ</v-btn>
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
import { api,commit,staff } from '../../API/base'


const error = ref<Record<string,string>>({})
const file = ref<File | null>(null)
const result = ref([])
const name_doc = ref('')
const search = ref('')
const id_eva = useRoute().params.id_eva

const saveMember = async()=>{
    if(!name_doc.value && !file.value)return alert('กรอกข้อมูลให้ครบถ้วน')
    const maxSize = 10 *1024 * 1024
    if(file.value.size > maxSize){
        alert("ไฟล์มีขนาดเกิน 10MB")
    }
    const formdata = new FormData
    formdata.append('file',file.value!)
    formdata.append('name_doc',name_doc.value)
    try {
        await axios.post(`${commit}/signature/${id_eva}`,formdata,{headers:{Authorization:`Bearer ${token}`}})
        alert('ทำรายการสำเร็จ')
        await fetch()
        file.value = null
        name_doc.value = ''
    } catch (error) {
        console.error("error doc",error);
        
    }
}


const token = import.meta.client ? localStorage.getItem('token'):null
const view = (file:string)=>{
    const url = new URL(`/uploads/signature/${file}`,commit).href
    window.open(url,'_blank')
}
const fetch = async()=>{
    try {
        const res = await axios.get(`${commit}/doc/show`,{headers:{Authorization:`Bearer ${token}`}})
        result.value = res.data
    } catch (error) {
        console.error("Error get member",error);
        
    }
}






const del = async(id_doc:number)=>{
    if(!confirm('ต้องการลบข้อมูลชุดนี้ใฃ่หรือไม่'))return
    try {
        await axios.delete(`${commit}/signature/${id_eva}`,{headers:{Authorization:`Bearer ${token}`}})
        await fetch()
    } catch (error) {
        console.error("error delete doc",error);
        
    }
}
</script>

<style scoped>

</style>