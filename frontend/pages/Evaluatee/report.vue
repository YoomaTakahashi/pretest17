<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form v-if="user.status_eva === 3">
                    <h1 class="text-h5 font-weight-bold">ผลการประเมินของผู้รับการประเมินผล</h1>
                    <v-card class="pa-2 py-2" :elevation="5" rounded="5">
                        <p>ผู้ใช้งาน : {{ user.fname }} {{ user.lname }}</p>
                        <p>รอบประเมินที่ : {{ user.round_sys }} ปี : {{ user.year_sys }}</p>
                    </v-card>
                    <v-row v-for="(topic,t) in topics" :key="topic.id_topic">
                        <v-col cols="12">
                            <h1 class="text-h5 font-weight-bold">{{ t+1 }}.{{ topic.name_topic }}</h1>
                            <v-table class="table">
                                <tr>
                                    <th class="border pa-1 bg-grey" style="width: 10%;">ตัวชี้วัด</th>
                                    <th class="border pa-1 bg-grey" style="width: 10%;">รายละเอียดตัวชี้วัด</th>
                                    <th class="border pa-1 bg-grey" style="width: 10%;">น้ำหนักคะแนน</th>
                                    <th class="border pa-1 bg-grey" style="width: 10%;">คะแนนเต็ม</th>
                                    <th class="border pa-1 bg-grey" style="width: 10%;">คะแนนที่ได้</th>
                                </tr>
                                <tr v-for="(indicate,i) in topic.indicates" :key="indicate.id_indicate">
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.name_indicate }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.detail_indicate }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.point_indicate }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.point_indicate*4 }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ (((scores[indicate.indicate]?. a ?? 0)+(scores[indicate.indicate]?. b ?? 0)+(scores[indicate.indicate]?. c ?? 0))/3).toFixed(2) }}</td>
                                </tr>
                            </v-table>
                        </v-col>
                    </v-row>
                    <div class="text-end pa-2 mt-3">
                        <v-card type="success" color="green" >คะแนนรวมสุทธิ : {{ ((user.totol_commit)/3).toFixed(2) }} คะแนน</v-card>
                    </div>
                    <div class="mt-2 pa-2">
                        <v-card class="pa-2">
                            <label for="">ข้อเสนอแนะของกรรมการ</label>
                            <v-row>
                                <v-col cols="12" v-for="commit,c in commits" :key="commit.id_commit">
                                <img :src="`http://localhost:3001/uploads/signature/${commit.signature}`" :alt="`รอ${commit.level_commit}ประเมิน`" width="20&"> <br>
                                (   {{ commit.fname }} {{ commit.lname }}) <br>
                                {{ commit.level_commit }}
                                </v-col>
                            </v-row>
                        </v-card>
                    </div>
                    <div class="mt-2 text-center">
                        <v-btn color="warning" class="no-p" @click="print">พิมพ์</v-btn>
                    </div>
                </v-form>
                <v-alert v-else-if="user.status_eva === 2" type="warning" variant="tonal">รอประเมินกรรมการประเมิน</v-alert>
                <v-alert v-else-if="user.status_eva === 1" type="warning" variant="tonal">ยังไม่ได้ประเมิน</v-alert>
                <v-alert v-else type="error" variant="tonal">ไม่มีแบบประเมิน</v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { eva } from '~/API/base';

const user = ref<any>({})
const topics = ref<any>([])
const commits = ref<any>([])
const scores = ref<any>([])

const print = ()=>{
    window.print()
}
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
const fecthCommit = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res =await axios.get(`${eva}/score_commit/commit`,{headers:{Authorization:`Bearer ${token}`}})
        commits.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPIC!',error)
    }
}
const fecthScore = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res =await axios.get(`${eva}/score_commit/score`,{headers:{Authorization:`Bearer ${token}`}})
        scores.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPIC!',error)
    }
}

onMounted(async()=>{
    await Promise.all([fecth(),fecthTopic(),fecthCommit(),fecthScore()])
})



</script>

<style scoped>
@media print {
    .v-app-bar,.v-btn.no-p{
        display: none !important;
        margin: 0 !important;
        margin-top: 0 !important;
        padding: 0 !important;
        width: 100% !important;
    }
}
</style>