<template>
  <TransitionRoot as="template" :show="examFinished">
    <Dialog as="div" class="relative z-10" @close="examFinished = false">
      <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0" enter-to="opacity-100" leave="ease-in duration-200" leave-from="opacity-100" leave-to="opacity-0">
        <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" />
      </TransitionChild>
      <div class="fixed z-10 inset-0 overflow-y-auto">
        <div class="flex items-end sm:items-center justify-center min-h-full p-4 text-center sm:p-0">
          <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" enter-to="opacity-100 translate-y-0 sm:scale-100" leave="ease-in duration-200" leave-from="opacity-100 translate-y-0 sm:scale-100" leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
            <DialogPanel class="relative bg-white rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:max-w-sm sm:w-full sm:p-6">
              <div>
                <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="#16A34A" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                  </svg>
                </div>
                <div class="mt-3 text-center sm:mt-5">
                  <DialogTitle as="h3" class="text-lg leading-6 font-medium text-gray-900"> Examen acabat </DialogTitle>
                  <div class="mt-2">
                    <p class="text-sm text-gray-500">Has completat correctament un <b>50%</b> de l'examen</p>
                  </div>
                </div>
              </div>
              <div class="mt-5 sm:mt-6">
                <button @click="this.$router.push({ path: '/home' });" type="button" class="inline-flex justify-center w-full rounded-md border border-transparent shadow-sm px-4 py-2 bg-emerald-700 text-base font-medium text-white hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-700 sm:text-sm">Tornar a l'inici</button>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
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
    <div v-if="!examFinished" class="pb-5 border-b border-gray-200 sm:flex sm:items-center sm:justify-between max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
      <h1 class="text-3xl font-bold text-gray-900">{{this.$route.params.eName}}</h1>
      <div>
        Temps d'examen: {{ timerCount }} segons restants
      </div>
      <div v-if="user_role && user_role === 'teacher'" class="mt-3 sm:mt-0 sm:ml-4">
        <button type="button" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500">Nou examen</button>
      </div>
    </div>
    <main v-if="!examFinished">
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- Replace with your content -->
        <div v-for="(exam,idx) in exams" :key="idx">
          <div class="rounded-md bg-white p-10">
              <div class="">
                  <div class="ml-3">
                      <h2 class="text-lg font-medium text-center">{{ exam[2] }}</h2>
                  </div>
              </div>
          </div>
          <div class="mt-4 border-t border-b border-gray-200 divide-y divide-gray-200">
              <div class="relative flex items-start py-4">
                  <div class="min-w-0 flex-1 text-sm">
                      <label :for="`side-${exam[3]}`" class="font-medium text-gray-700 select-none">{{ exam[3] }}</label>
                  </div>
                  <div class="ml-3 flex items-center h-5">
                      <input :id="`side-${exam[3]}`" :name="`side-${exam[3]}`" type="radio" :checked="exam[3] === null" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300" />
                  </div>
              </div>
              <div class="relative flex items-start py-4">
                  <div class="min-w-0 flex-1 text-sm">
                      <label :for="`side-${exam[4]}`" class="font-medium text-gray-700 select-none">{{ exam[4] }}</label>
                  </div>
                  <div class="ml-3 flex items-center h-5">
                      <input :id="`side-${exam[4]}`" :name="`side-${exam[4]}`" type="radio" :checked="exam[4] === null" class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300" />
                  </div>
              </div>
          </div>
        </div>
        
        <div class="border-t mt-10 border-gray-200 px-4 flex items-center justify-between sm:px-0">
            <div class="mt-3 flex ">
                <button @click="endExam" type="button" class="flex items-right items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500">Finalitzar</button>
            </div>
        </div>
        <!-- /End replace -->
      </div>
    </main>
    <div v-if="examFinished">
      
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import { Disclosure } from '@headlessui/vue'
import firebase from 'firebase'
import { ethers } from 'ethers';
import ExamContract from '../../artifacts/contracts/Exam.sol/ExamContract.json';
import { Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot } from '@headlessui/vue'

const navigation = [
  { name: 'Inici', current: true },
  { name: 'Examens', current: false },
]

export default defineComponent({
    name: 'HomeView',
    components: {
        Disclosure,
        Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot
    },
    setup() {
        return {
            navigation,
            db: ref(firebase.firestore()),
            user_role: ref(),
            numABIExam: ref(ExamContract),
            numContractExam: ref("0xc60D594d73326824d14Cf55c79D6a114EAea3977"),
            exams: ref(new Array()),
            idx: ref(),
            examFinished: ref(false),
            timerCount: ref(60)
        }
    },
    created() {
      this.getExams();
    },
    watch: {
      timerCount: {
        handler(value) {
          if (value > 0) {
              setTimeout(() => {
                  this.timerCount--;
              }, 1000);
          } else {
            this.examFinished = true;
          }
        },
        immediate: true // This ensures the watcher is triggered upon creation
      }
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
        async getExams() {
            const provider = new ethers.providers.Web3Provider((window as any).ethereum);
            const numberContract = new ethers.Contract(this.numContractExam, this.numABIExam, provider.getSigner())

            const aa = await numberContract.totalExams()      
            if (aa.toNumber() > 0) {
                for (var i=1; i<=aa.toNumber(); i++) {
                    numberContract.getExamById(i).then((response: any) => {
                        this.exams.push(response)
                        console.log(this.exams)
                    })
                } // end for
            } // end if
        },
        endExam() {
          this.examFinished = true;
        }
    }
});
</script>

