<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form @submit.prevent="saveScore">
                    <h1 class="text-h5 font-weight-bold">แบบประเมินตนเอง</h1>
                    <v-card class="pa-2 py-2" :elevation="5" rounded="5">
                        <p>ผู้ใช้งาน : {{ user.fname }} {{ user.lname }}</p>
                        <p>รอบประเมินที่ : {{ user.round_sys }} ปี : {{ user.year_sys }}</p>
                    </v-card>
                    <v-row v-for="(topic,t) in topics" :key="topic.id_topic">
                        <v-col cols="12">
                            <h1 class="text-h5 font-weight-bold">{{ t+1 }}.{{ topic.name_topic }}</h1>
                        </v-col>
                        <v-card class="pa-2 py-3" :elevation="5" rounded="5">
                            <v-row v-for="(indicate,i) in topic.indicates" :key="indicate.id_indicate">
                                <v-col cols="12">
                                    {{ t+1 }}.{{ i+1 }} {{ indicate.name_indicate }} รายระเอียดตัวชี้วัด : {{ indicate.detail_indicate }} น้ำหนักคะแนน : {{ indicate.point_indicate }} คะแนนเต็ม : {{ indicate.point_indicate*4 }}
                                    <v-textarea label="คำอธิบายเพิ่มเติม(ถ้ามี)" v-model="indicate.detail_eva" variant="solo-filled" class="mt-2"></v-textarea>
                                    <v-file-input v-model="indicate.file_eva" label="***รองรับเฉพาะนามสกุลไฟล์  .png .jpg .pdf" accept=".png,.jpg,.pdf" variant="solo-filled" @chang="onFilechange($event,topic.id_topic,indicate.id_indicate)"></v-file-input>
                                    <v-select v-if="indicate.check_indicate === 'y'" v-model="indicate.score" label="ใส่คะแนน 1-4 " :items="[1,2,3,4]" variant="solo-filled"></v-select>
                                    <v-text-fiuld v-else v-model="indicate.score" label="ใส่คะแนน 1-4 " @input="indicate.score > 4 ? indicate.score = 4 :null"  variant="solo-filled" ></v-text-fiuld>
                                </v-col>
                            </v-row>
                        </v-card>
                    </v-row>
                    <div class="text-center mt-3">
                        <v-btn type="submit" color="blue">บันทึกคะแนน</v-btn>
                    </div>
                </v-form>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { eva } from '~/API/base';

const user = ref<any>({})
const topics = ref<any>([])

const fecth = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res =await axios.get(`${eva}/selfeva/user`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    } catch (error) {
        console.error('ERROR GET USER!',error)
    }
}
const fecthTopic = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res =await axios.get(`${eva}/selfeva/topic`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPIC!',error)
    }
}

onMounted(async()=>{
    await Promise.all([fecth(),fecthTopic()])
})
const fileMap = ref<Record<string,File>>({})
const onFilechange = ($event:Event,id_topic:number,id_indicate:number) =>{
    const file = (event?.target as HTMLInputElement)?.files?.[1]
    if(!file)return
    fileMap.value[`${id_topic}-${id_indicate}`] = file
}

const saveScore = async()=>{
    const token = localStorage.getItem('token')
    const formdata = new FormData()
    const allScore = topics.value.flatMap((t:any)=> 
    t.indicates.map((i:any)=>{
        const key = `${t.id_topic}-${i.id_indicate}`
        const file = fileMap.value[key]
        if(file)formdata.append(`file_${key}`,file)
        return{
            id_topic:t.id_topic,
            id_indicate:i.id_indicate,
            score:i.score,
            detail_eva:i.detail_eva,
            file_key:file ? `file_${key}` :null     
        }
    })
    )
    if(allScore.some((s:any)=> !s.score)){
        alert('กรุณากรอกคะแนนให้สมบูรณ์')
        return
    }
    formdata.append('scores',JSON.stringify(allScore))
    try {
        await axios.post(`${eva}/selfeva/save`,formdata,{headers:{Authorization:`Bearer ${token}`}})
        alert('ประเมินสำเร็จ')
        await Promise.all([fecth(),fecthTopic()])
    } catch (error) {
        console.error('error post scores',error)
    }
}
</script>

<style scoped>

</style>