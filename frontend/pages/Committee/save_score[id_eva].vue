<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-alert v-if="user.status_eva === 1 "></v-alert>
                <v-form v-else-if="user.status_commit === 'n'" @submit.prevent="saveScore">
                    <h1 class="text-h5 font-weight-bold">แบบประเมินตนเอง</h1>
                    <v-card class="pa-2 py-2" :elevation="5" rounded="5">
                        <p>ผู้ใช้งาน : {{ user.fname }} {{ user.lname }}</p>
                        <p>รอบประเมินที่ : {{ user.round_sys }} ปี : {{ user.year_sys }}</p>
                    </v-card>
                    <v-row v-for="(topic,t) in topics" :key="topic.id_topic">
                        <v-col cols="12">
                            <h1 class="text-h5 font-weight-bold">{{ t+1 }}.{{ topic.name_topic }}</h1>
                            <v-card class="pa-2 py-3" :elevation="5" rounded="5">
                            <v-row v-for="(indicate,i) in topic.indicates" :key="indicate.id_indicate">
                                <v-col cols="12">
                                    {{ t+1 }}.{{ i+1 }} {{ indicate.name_indicate }} รายระเอียดตัวชี้วัด : {{ indicate.detail_indicate }} น้ำหนักคะแนน : {{ indicate.point_indicate }} คะแนนเต็ม : {{ indicate.point_indicate*4 }}
                                    <p class="mt-2">รายละเอียด : {{ indicate.detail_eva || '-' }}</p>
                                    <p class="mt-2"> file : <v class="btn" v-if="indicate.file_eva" size="smail" @click="viweFile(indicate.file_eva)" color="blue"></v><span v-else>ไม่มีไฟล์</span> </p>
                                    <v-select v-if="indicate.check_indicate === 'y'" v-model="indicate.score" label="ใส่คะแนน 1-4 " :items="[1,2,3,4]" variant="solo-filled"></v-select>
                                    <v-text-field type="number" min="0" v-else-if="indicate.check_indicate === 'n'" v-model="indicate.score" label="ใส่คะแนน 1-4 " @input="indicate.score > 4 ? indicate.score = 4 :null"  variant="solo-filled" ></v-text-field>
                                </v-col>
                            </v-row>
                        </v-card>
                        </v-col>
                    </v-row>
                    <div class="mt-4">
                        <v-card class="pa-2">
                            <label for="">ข้อเสนอแนะ</label>
                            <v-textarea label="ถ้ามี" v-model="detail_commit" row="2"></v-textarea>
                        </v-card>
                    </div>
                    <div class="text-center mt-3">
                        <v-btn type="submit" color="blue">บันทึกคะแนน</v-btn>
                    </div>
                </v-form>
                <v-alert v-else-if="user.status_eva === 2 || user.status_eva === 3" type="success" variant="tonal">ประเมินสำเร็จ</v-alert>
                <v-alert v-else type="error" variant="tonal">ไม่มีแบบประเมิน</v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import {commit} from '../../API/base';

const topics = ref<any>([])
const user = ref<any>({})
const detail_commit = ref('')
const id_eva = useRoute().params.id_eva

const viweFile = (filename:string) =>{
    const url = `http://localhost:3001/uploads/evadetail/${filename}`
    window.open(url,'_blank')
}

const fetchUser = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res = await axios.get(`${commit}/save_score/user/${id_eva}`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    } catch (error) {
        console.error('ERROR GET USER  ',error)
    }
}
const fetchTopics = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res = await axios.get(`${commit}/save_score/topic/${id_eva}`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPICS  ',error)
    }
}

onMounted(async()=>{
    Promise.all([fetchUser(),fetchTopics()])
})

const saveScore = async()=>{
    const token = localStorage.getItem('token')
    const formData = new FormData()
    const allScore = topics.value.flatMap((t:any) =>
        t.indicates.map((i:any) => {
            return{
                id_topic:t.id_topic,
                id_indicate:i.id_indicate,
                score:i.score,
        
            }
        })
    )
    if(allScore.some((s:any)=> !s.score)){
        alert('กรุณากรอกคะแนนให้สมบูรณ์')
        return
    }
    formData.append('scores',JSON.stringify(allScore))
    const detail_commitTo = ref('')
    if(detail_commit.value = detail_commit.value.trim()){
        detail_commitTo.value = detail_commit.value
    }else{
        detail_commitTo.value = 'ไม่มี'
    }
    formData.append('detail_commit',detail_commitTo.value)
    try {
        await axios.post(`${commit}/save_score/save/${id_eva}`,formData,{headers:{Authorization:`Bearer ${token}`}})
        alert('ประเมินสำเร็จ')
        await Promise.all([fetchTopics(),fetchUser()])
        navigateTo('/Commitee/check_confirm',{replace:true})
    } catch (error) {
        console.error('Error POST Score!',error)
    }
}
</script>

<style scoped>

</style>