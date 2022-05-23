<template>
  <div class="min-h-full">
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
      <h1 class="text-3xl font-bold text-gray-900">Inici</h1>
      <div @click="this.$router.push({ path: '/teacher' });" v-if="user_role && user_role === 'teacher'" class="mt-3 sm:mt-0 sm:ml-4">
        <button type="button" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500">Àrea del professor/a</button>
      </div>
    </div>
    <main>
      <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <!-- Replace with your content -->
        <div v-if="!isLoggedIn" class="px-4 py-6 sm:px-0">
          <div v-if="isMetaMaskSupported">
            <div class="rounded-lg bg-gray-200 overflow-hidden shadow divide-y divide-gray-200 sm:divide-y-0 sm:grid sm:grid-cols-2 sm:gap-px">
              <div @click="connectWallet(exam[1])" v-for="exam in exams" :key="exam.exam_title" class="relative group bg-white p-6 focus-within:ring-2 focus-within:ring-inset focus-within:ring-indigo-500">
                <div class="mt-8">
                  <h3 class="text-lg font-medium">
                    <a class="focus:outline-none">
                      <!-- Extend touch target to entire panel -->
                      <span class="absolute inset-0" aria-hidden="true" />
                      {{exam[1]}}
                    </a>
                  </h3>                  
                </div>
                <span class="pointer-events-none absolute top-6 right-6 text-gray-300 group-hover:text-gray-400" aria-hidden="true">
                  <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M20 4h1a1 1 0 00-1-1v1zm-1 12a1 1 0 102 0h-2zM8 3a1 1 0 000 2V3zM3.293 19.293a1 1 0 101.414 1.414l-1.414-1.414zM19 4v12h2V4h-2zm1-1H8v2h12V3zm-.707.293l-16 16 1.414 1.414 16-16-1.414-1.414z" />
                  </svg>
                </span>
              </div>
            </div>
          </div>
          <div v-else>
            <p>Instala l'extensió de Metamask</p>
          </div> 
        </div>
        <div v-else>{{computedAddress}}</div>
        <!-- /End replace -->
      </div>
    </main>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import { Disclosure } from '@headlessui/vue'
import firebase from 'firebase'
import { ethers } from 'ethers';
import ExamContract from '../../artifacts/contracts/Exam.sol/ExamContract.json';

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
      isMetaMaskSupported: ref(false),
      address: ref(""),
      db: ref(firebase.firestore()),
      isLoggedIn: ref(false),
      user_role: ref(),
      exams: ref(new Array()),
      numABIExam: ref(ExamContract),
      numContractExam: ref("0xc60D594d73326824d14Cf55c79D6a114EAea3977"),    
    }
  },
  created() {
    this.user_role = sessionStorage.getItem('user_role') ? sessionStorage.getItem('user_role') : null
    this.getExams();
  },
  mounted() {
    this.isMetaMaskSupported = typeof (window as any).ethereum !== 'undefined';
    this.checkExistingAccount();
  },
  computed: {
    computedAddress(): string {
      return this.address.substring(0,4) + '....';
    }
  },
  methods: {
    doActionNav(navOption: string) {
      if(navOption == "log_out") {
        firebase.auth().signOut();
        this.user_role = ""
        sessionStorage.removeItem('user_role');
        this.$router.push({ path: "/" });
      }
    },
    async connectWallet(examID: any) {      
      const accounts = await (window as any).ethereum.request({ method: 'eth_requestAccounts' })
      this.address = accounts[0];
      this.$router.push({name:'exam', params:{eName:examID}});
    },
    async checkExistingAccount() {
      if(!(window as any).ethereum) {
        alert("Comprova que tens l'extensió de Metamask instalada!");
      } else {
        console.log("Objecte ethereum existeix", (window as any).ethereum);
      }
      const accounts = await (window as any).ethereum.request({ method: 'eth_accounts' });
      this.address = accounts[0];
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
    /*getExams() {
      this.db.collection("exams")
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          this.exams.push({
            examTitle: doc.id,   
            examDescription: doc.data().description           
          });
        });
      })
      .catch((error) => {
        console.log("Error getting documents: ", error);
      });
    },*/
  }
});
</script>
