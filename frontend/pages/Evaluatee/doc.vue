<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="12" md="12">
                <v-card>
                    <v-card-title>
                        <h1 class="text-center text-h5">คู่มือการประเมินผล</h1>
                    </v-card-title>
                    <v-card-text class="bg-white">
                    
                        <v-table class="table mt-3">
                            <thead>
                                <tr>
                                    <th class="border text-center">ลำดับ</th>
                                    <th class="border text-center">ชื่อเอกสาร</th>
                                    <th class="border text-center">วันที่ออกเอกสาร</th>
                                    <th class="border text-center">ไฟล์</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(items,index) in result" :key="items.id_doc">
                                    <td class="border text-center">{{ index+1 }}</td>
                                    <td class="border text-center">{{ items.name_doc }}</td>
                                    <td class="border text-center">{{ formatDate(items.day_doc) }}</td>
                                    <td class="border text-center">
                                        <v-btn class="text-center text-white ma-2" color="info" prepend-icon="mdi-eye" @click="view(items.file)" size="small">เปิดดู</v-btn>
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
const file = ref<File | null>(null)
const dataResult = ref([])
const name_doc = ref('')
const search = ref('')
const result = ref([])





const token = import.meta.client ? localStorage.getItem('token'):null
const view = (file:string)=>{
    const url = new URL(`/uploads/document/${file}`,api).href
    window.open(url,'_blank')
}
const fetch = async()=>{
    try {
        const res = await axios.get(`${api}/doc/`,{headers:{Authorization:`Bearer ${token}`}})
        dataResult.value = res.data
    } catch (error) {
        console.error("Error get member",error);
        
    }
}

onMounted(fetch)


</script>

<style scoped>

</style>