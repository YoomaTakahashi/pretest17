<template>
    <v-app>
        <v-app-bar>
            <v-app-bar-nav-icon @click="drawer = !drawer" />
            <v-toolbar-title class="font-weight-bold">NTC EVALUATION SYSTEM</v-toolbar-title>
            <v-spacer></v-spacer>

            <p class="text-center">คุณ : {{ user.fname }} {{ user.lname }} <br> ตำแหน่ง : {{ user.role }}</p>
            <v-btn icon="mdi-logout" @click="logout" variant="text"></v-btn>
        </v-app-bar>

        <client-only>
            <v-navigation-drawer app color="#404040" width="260" :temporary="isMobile" :permanent="!isMobile" v-model="drawer">
                <v-list density="comfortable">
                    <v-list-item v-for="item in navitem" :key="item.title" :to="item.to">
                        <v-list-item-title>
                            {{ item.title }}
                        </v-list-item-title>
                    </v-list-item>
                </v-list>
            </v-navigation-drawer>
        </client-only>

        <v-main>
            <v-container class="py-2" fluid>
                <slot/>
            </v-container>
            <v-footer class="text-caption justify-center">© 2026 NTC EVALUATION SYSTEM</v-footer>
        </v-main>
    </v-app>
</template>

<script setup lang="ts">
import axios from 'axios'
import { useDisplay } from 'vuetify/lib/composables/display.mjs';
import { api } from '~/API/base';

const drawer = ref(false)
const user =ref<any>(false)
const {mdAndDown} = useDisplay()
const isMobile = computed(()=> mdAndDown.value)

const roles = [
    //staff nav
    {title:'หน้าหลัก',to:'/Staff/',role:'ฝ่ายบุคลากร'},
    {title:'จัดการผู้รับการประเมินผล',to:'/Staff/Manage_eva',role:'ฝ่ายบุคลากร'},
    {title:'จัดการผู้รับการกรรมการประเมิน',to:'/Staff/Manage_commit',role:'ฝ่ายบุคลากร'},
    {title:'จัดการหัวข้อการประเมิน',to:'/Staff/Topic',role:'ฝ่ายบุคลากร'},
    {title:'จัดการตัวชี้วัดการประเมิน',to:'/Staff/Indicate',role:'ฝ่ายบุคลากร'},
    {title:'จัดการรอบการประเมิน',to:'/Staff/Round',role:'ฝ่ายบุคลากร'},
    {title:'จัดการแบบประเมิน',to:'/Staff/Eva',role:'ฝ่ายบุคลากร'},
    {title:'ผลสรุปคะแนนประเมินของผู้รับการประเมินผล',to:'/Staff/Score_evaList',role:'ฝ่ายบุคลากร'},
    {title:'ผลสรุปคะแนนประเมินของกรรมการประเมิน',to:'/Staff/Score_commitList',role:'ฝ่ายบุคลากร'},
    {title:'สถานะการประเมินของผู้รับการประเมินผล',to:'/Staff/Status_eva',role:'ฝ่ายบุคลากร'},
    {title:'สถานะการประเมินของกรรมการประเมินผล',to:'/Staff/Status_commit',role:'ฝ่ายบุคลากร'},
    {title:'เอกสารและคู่มือการประเมินผล',to:'/Staff/Document',role:'ฝ่ายบุคลากร'},
    {title:'รายงาน',to:'/Staff/report',role:'ฝ่ายบุคลากร'},
    {title:'การสำรองข้อมูล',to:'/Staff/backup',role:'ฝ่ายบุคลากร'},

    //eva nav
    {title:'หน้าหลัก',to:'/Evaluatee',role:'ผู้รับการประเมินผล'},
    {title:'แก้ไขข้อมูลส่วนตัว',to:'/Evaluatee/edit_eva',role:'ผู้รับการประเมินผล'},
    {title:'แบบประเมินตนเอง',to:'/Evaluatee/selfeva',role:'ผู้รับการประเมินผล'},
    {title:'ตรวจสอบผลการประเมิน',to:'/Evaluatee/check_score',role:'ผู้รับการประเมินผล'},
    {title:'รายงานผล',to:'/Evaluatee/report',role:'ผู้รับการประเมินผล'},
    {title:'คู่มือการประเมินผล',to:'/Evaluatee/doc',role:'ผู้รับการประเมินผล'},

    //commit nav
    {title:'รายชื่อผู้รับการประเมินผล',to:'/Committee',role:'กรรมการประเมิน'},
    {title:'ดำเนินการประเมิน',to:'/Committee/show_eva',role:'กรรมการประเมิน'},
    {title:'ตรวจสอบผลและยืนยัน',to:'/Committee/check_comfirm',role:'กรรมการประเมิน'},
    {title:'คู่มือการประเมินผล',to:'/Committee/doc',role:'กรรมการประเมิน'},

]

const navitem = computed(()=> roles.filter((item)=> item.role.includes(user.value.role)))

const logout = ()=>{
    if(!confirm('ท่านต้องการออกจากระบบใช่หรือไม่'))return
    localStorage.removeItem('token')
    navigateTo('/',{replace:true})
}

const fecth = async()=>{
    const token = localStorage.getItem('token')
    if(!token){
        return localStorage.removeItem('token')
    }
    try {
        const res = await axios.get(`${api}/profile`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    } catch (error) {
        console.error('ERROR GET PROFILE!',error)
        localStorage.removeItem('token')
        navigateTo('/',{replace:true})
    }
}
onMounted(fecth)

const bg = (role:string)=>{
    if(role === 'ฝ่ายบุคลากร')return '#687647'
    if(role === 'กรรมการประเม')return '#007FFF'
    if(role === 'ผู้รับการประเมินผล')return '#7d0c14'
}
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