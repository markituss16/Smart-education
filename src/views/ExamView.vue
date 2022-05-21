<template>
  <div class="min-h-full bg-gray-100">
    <Disclosure as="nav" class="bg-gray-800">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          <div class="flex items-center">
            <div class="flex-shrink-0 cursor-pointer" @click="this.$router.push({ path: '/home' });">
              <img class="h-8 w-auto sm:h-10" src="../assets/logo_education.png" />
            </div>
            <div class="hidden md:block">
              <div class="ml-10 flex items-baseline space-x-4">
                <a v-for="item in navigation" :key="item.name" :href="item.href" :class="[item.current ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white', 'px-3 py-2 rounded-md text-sm font-medium']" :aria-current="item.current ? 'page' : undefined">{{ item.name }}</a>
              </div>
            </div>
          </div>
          <div class="hidden md:block">
            <div @click="doActionNav('log_out')" class="ml-4 flex items-center md:ml-6 cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
              </svg>
            </div>
          </div>
        </div>
      </div>
    </Disclosure>
    <div class="pb-5 border-b border-gray-200 sm:flex sm:items-center sm:justify-between max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
      <h1 class="text-3xl font-bold text-gray-900">{{this.$route.params.eName}}</h1>
      <div v-if="user_role && user_role === 'teacher'" class="mt-3 sm:mt-0 sm:ml-4">
        <button type="button" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500">Nou examen</button>
      </div>
    </div>
    <main>
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- Replace with your content -->
        <div v-for="(exam,idx) in exams" :key="idx">
          <div class="rounded-md bg-white p-10">
              <div class="">
                  <div class="ml-3">
                      <h2 class="text-lg font-medium text-center">{{ exam[0] }}</h2>
                  </div>
              </div>
          </div>
          <div class="mt-4 border-t border-b border-gray-200 divide-y divide-gray-200">
              <div class="relative flex items-start py-4">
                  <div class="min-w-0 flex-1 text-sm">
                      <label :for="`side-${exam[1].resposta}`" class="font-medium text-gray-700 select-none">{{ exam[1].resposta }}</label>
                  </div>
                  <div class="ml-3 flex items-center h-5">
                      <input :id="`side-${exam[1].resposta}`" name="plan" type="radio" :checked="exam[1].resposta === null" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300" />
                  </div>
              </div>
              <div class="relative flex items-start py-4">
                  <div class="min-w-0 flex-1 text-sm">
                      <label :for="`side-${exam[2].resposta}`" class="font-medium text-gray-700 select-none">{{ exam[2].resposta }}</label>
                  </div>
                  <div class="ml-3 flex items-center h-5">
                      <input :id="`side-${exam[2].resposta}`" name="plan" type="radio" :checked="exam[2].resposta === null" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300" />
                  </div>
              </div>
              <div class="relative flex items-start py-4">
                  <div class="min-w-0 flex-1 text-sm">
                      <label :for="`side-${exam[3].resposta}`" class="font-medium text-gray-700 select-none">{{ exam[3].resposta }}</label>
                  </div>
                  <div class="ml-3 flex items-center h-5">
                      <input :id="`side-${exam[3].resposta}`" name="plan" type="radio" :checked="exam[3].resposta === null" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300" />
                  </div>
              </div>
              <div class="relative flex items-start py-4">
                  <div class="min-w-0 flex-1 text-sm">
                      <label :for="`side-${exam[4].resposta}`" class="font-medium text-gray-700 select-none">{{ exam[4].resposta }}</label>
                  </div>
                  <div class="ml-3 flex items-center h-5">
                      <input :id="`side-${exam[4].resposta}`" name="plan" type="radio" :checked="exam[4].resposta === null" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300" />
                  </div>
              </div>
          </div>
        </div>
        
        <div class="border-t mt-10 border-gray-200 px-4 flex items-center justify-between sm:px-0">
            <div class="-mt-px w-0 flex-1 flex">
                <div @click="getExams(-1)" class="border-t-2 border-transparent pt-4 pr-1 inline-flex items-center text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                    <svg xmlns="http://www.w3.org/2000/svg" class="mr-3 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="#a1a1aa" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M7 16l-4-4m0 0l4-4m-4 4h18" />
                    </svg>
                    Anterior
                </div>
                </div>
                <!--<div class="hidden md:-mt-px md:flex">
                    <a href="#" class="border-emerald-500 text-emerald-600 border-t-2 pt-4 px-4 inline-flex items-center text-sm font-medium"> 1 </a>
                     Current: "border-indigo-500 text-indigo-600", Default: "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300" 
                    <a href="#" class="border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 border-t-2 pt-4 px-4 inline-flex items-center text-sm font-medium" aria-current="page"> 2 </a>
                    <a href="#" class="border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 border-t-2 pt-4 px-4 inline-flex items-center text-sm font-medium"> 3 </a>
                    <a href="#" class="border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 border-t-2 pt-4 px-4 inline-flex items-center text-sm font-medium"> 4 </a>
                </div>-->
                <div class="-mt-px w-0 flex-1 flex justify-end">
                <div @click="getExams(1)" class="border-t-2 border-transparent pt-4 pl-1 inline-flex items-center text-sm font-medium text-gray-500 hover:text-gray-700 hover:border-gray-300">
                    Següent
                    <svg xmlns="http://www.w3.org/2000/svg" class="ml-3 h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="#a1a1aa" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                    </svg>
                </div>
            </div>
        </div>
        <!-- /End replace -->
      </div>
    </main>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import { Disclosure } from '@headlessui/vue'
import firebase from 'firebase'

//Contract ABI 
//import Exam from '../assets/ABI/Exam.json';

const navigation = [
  { name: 'Inici', current: true },
  { name: 'Examens', current: false },
]

export default defineComponent({
    name: 'HomeView',
    components: {
        Disclosure,
    },
    setup() {
        return {
            navigation,
            db: ref(firebase.firestore()),
            user_role: ref(),
            exams: ref(new Array()),
            idx: ref()
        }
    },
    created() {
        this.getExams(1);
        console.log(this.exams)
    },
    methods: {
        doActionNav(navOption: string) {
            if(navOption == "log_out") {
                firebase.auth().signOut();
                this.user_role = "";
                sessionStorage.removeItem('user_role');
                this.$router.push({ path: "/" });
            }
        },
        getExams(index: any) {
            this.idx = index;
            this.db.collection("exams").doc(this.$route.params.eName.toString())
            .get()
            .then(queryResult => {
                this.exams.push(queryResult.data()?.pregunta1);
            })
            .catch((error) => {
                console.log("Error getting documents: ", error);
            });
        }
    }
});
</script>

