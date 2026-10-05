import vuetify,{ transformAssetUrls } from "vite-plugin-vuetify"
export default defineNuxtConfig({
  build:{
    transpile:['vuetufy']
  },
  vite:{
    plugins:[
      vuetify({autoImport:true})
    ],
    vue:{
      template:{
        transformAssetUrls
      }
    }
  },
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true }
})
