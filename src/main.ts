import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import firebase from 'firebase';
import 'jquery';
import './index.css'

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyCxcX8YzeqbaoWqoX_Ci_pA2RHv5Bl86_w",
  authDomain: "smart-education-b7c0f.firebaseapp.com",
  projectId: "smart-education-b7c0f",
  storageBucket: "smart-education-b7c0f.appspot.com",
  messagingSenderId: "473614834172",
  appId: "1:473614834172:web:b713aea8c533cdc849ba79"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

createApp(App).use(store).use(router).mount('#app')
