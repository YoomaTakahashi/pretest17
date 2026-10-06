<template>
    <v-container>
        <v-card>
            <v-sheet class="pa-5 text-center">
                <h1 class="text-h5 font-weight-bold">DashBoard - ฝ่ายบุคลากร</h1>
            </v-sheet>
            <v-card-text>
                <v-row>
                    <v-col md="4" v-for="b in box" :key="b" cols="12">
                        <v-card :elevation="5" rounded="5" class="pa-4">
                            <div class="text-h5 text-center">{{ b.title }}</div>
                            <div class="text-h5 text-center">{{ b.value }}</div>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col md="4" v-for="b in box2" :key="b" cols="12">
                        <v-card :elevation="5" rounded="5" class="pa-4">
                            <div class="text-h5 text-center">{{ b.title }}</div>
                            <div class="text-h5 text-center">{{ b.value }}</div>
                        </v-card>
                    </v-col>
                </v-row>
            </v-card-text>
        </v-card>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { api, eva } from '~/API/base';

const box = ref([])
const box2 = ref([])
const fecth = async()=>{
    const token = localStorage.getItem('token')
    try {
        const res = await axios.get(`${api}/dash/staff`,{headers:{Authorization:`Bearer ${token}`}})
        box.value = res.data.box
        box2.value = res.data.box2
    } catch (error) {
        console.error('ERROR GET USER!',error)
    }
}
onMounted(fecth)
</script>

<style scoped>

</style>