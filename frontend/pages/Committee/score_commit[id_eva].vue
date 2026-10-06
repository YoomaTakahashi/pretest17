<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form v-if="user.status_commit === 'y'">
                    <h1 class="text-h5 font-weight-bold">คะแนนประเมินของกรรมการประเมิน</h1>
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
                                    <th class="border pa-1 bg-grey" style="width: 10%;">รายละเอียด</th>
                                    <th class="border pa-1 bg-grey" style="width: 10%;">คะแนนที่ได้</th>
                                </tr>
                                <tr v-for="(indicate,i) in topic.indicates" :key="indicate.id_indicate">
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.name_indicate }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.detail_indicate }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.point_indicate }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.point_indicate*4 }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.detail_eva }}</td>
                                    <td class="boder pa-1 text-center" style="width: 10%;">{{ indicate.score_member*indicate.point_indicate }}</td>
                                </tr>
                            </v-table>
                        </v-col>
                    </v-row>
                    <div class="text-end pa-2 mt-3">
                        <v-card type="success" color="green" >คะแนนรวมสุทธิ : {{ user.total_eva }} คะแนน</v-card>
                    </div>
                </v-form>
                <v-alert v-else-if="user.status_commit === 'n'" type="warning" variant="tonal">ยังไม่ได้ประเมิน</v-alert>
                <v-alert v-else type="error" variant="tonal">ไม่มีแบบประเมิน</v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { commit, eva } from '~/API/base';

const user = ref<any>({})
const topics = ref<any>([])

const fecth = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res =await axios.get(`${commit}/score_commit/user`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    } catch (error) {
        console.error('ERROR GET USER!',error)
    }
}
const fecthTopic = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res =await axios.get(`${commit}/score_commit/topic`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    } catch (error) {
        console.error('ERROR GET TOPIC!',error)
    }
}

onMounted(async()=>{
    await Promise.all([fecth(),fecthTopic()])
})



</script>

<style scoped>

</style>