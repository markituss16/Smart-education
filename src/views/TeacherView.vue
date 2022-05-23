<template>
	<div v-if="user_role && user_role === 'teacher'" class="min-h-full">
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
        <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
            <div class="px-4 sm:px-6 lg:px-8">
                <div class="sm:flex sm:items-center">
                    <div class="sm:flex-auto">
                        <h1 class="text-xl font-semibold text-gray-900">Usuaris del curs</h1>
                        <p class="mt-2 text-sm text-gray-700">Una llista amb la informació principal dels mateixos</p>
                    </div>
                </div>
                <div class="mt-8 flex flex-col">
                    <div class="-my-2 -mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8">
                        <div class="inline-block min-w-full py-2 align-middle md:px-6 lg:px-8">
                        <div class="overflow-hidden shadow ring-1 ring-black ring-opacity-5 md:rounded-lg">
                            <table class="min-w-full divide-y divide-gray-300">
                                <thead class="bg-gray-50">
                                    <tr>
                                    <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6">ID</th>
                                    <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6">Adreça</th>
                                    <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-6">Nom</th>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Assignatura</th>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Rol</th>
                                    <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Creat el</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-200 bg-white">
                                    <tr v-for="user in users" :key="user">
                                        <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">{{ user[0].toNumber() }}</td>
                                        <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">{{ user[1] }}</td>
                                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">{{ user[2] }} {{user[3]}}</td>
                                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">{{ user[4] }}</td>
                                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">{{ user[6] }}</td>
                                        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">{{ new Date(user[7].toNumber().toString() * 1000) }}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--exams creation-->
            <div class="px-4 sm:px-6 lg:px-8">
                <div class="pt-8 space-y-6 sm:pt-10 sm:space-y-5">
                    <div>
                        <h1 class="text-lg leading-6 font-medium text-gray-900">Crea un examen</h1>
                        <p class="mt-1 max-w-2xl text-sm text-gray-500">Afegeix preguntes fent clic al botó.</p>
                    </div>
                    <div class="space-y-6 sm:space-y-5">
                        <div class="relative z-0 w-full mb-6 group">
                            <input type="text" v-model="subject" name="subject" class="block outline-0 py-2.5 px-0 w-100 text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none peer" placeholder=" " required />
                            <label for="subject" class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Assignatura</label>
                        </div>
                        <div class="grid xl:grid-cols-2 xl:gap-6">
                            <div class="relative z-0 w-full mb-6 group">
                                <input type="text" v-model="quest1" name="floating_first_name" id="floating_first_name" class="block outline-0 py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none peer" placeholder=" " required />
                                <label for="floating_first_name" class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Pregunta</label>
                            </div>
                            <div class="relative z-0 w-full mb-6 group">
                                <input type="text" v-model="answer1" name="floating_last_name" id="floating_last_name" class="block outline-0 py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none peer" placeholder=" " required />
                                <label for="floating_last_name" class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Resposta 1</label>
                            </div>
                            <div class="relative z-0 w-full mb-6 group">
                                <input type="text" v-model="answer2" name="floating_last_name" id="floating_last_name" class="block outline-0 py-2.5 px-0 w-full text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none peer" placeholder=" " required />
                                <label for="floating_last_name" class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Resposta 2</label>
                            </div>
                            <div class="relative z-0 w-full mb-6 group">
                                <input type="text" v-model="correctAnswer" name="correctAnswer" class="block outline-0 py-2.5 px-0 w-100 text-sm text-gray-900 bg-transparent border-0 border-b-2 border-gray-300 appearance-none peer" placeholder=" " required />
                                <label for="correctAnswer" class="peer-focus:font-medium absolute text-sm text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Resposta correcta</label>
                            </div>
                        </div>                   
                        <div v-if="user_role && user_role === 'teacher'" class="mt-3 justify-between">
                            <button type="button" @click="performSubmit" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500">Crear examen</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import { Disclosure } from '@headlessui/vue'
import { ethers } from 'ethers';
import firebase from 'firebase'
import UserContract from '../../artifacts/contracts/User.sol/UserContract.json';
import ExamContract from '../../artifacts/contracts/Exam.sol/ExamContract.json';

const navigation = [
  { name: 'Inici', current: true },
  { name: 'Examens', current: false },
]

export default defineComponent({
    name: 'TeacherView',
    components: {
        Disclosure,
    },
    setup() {
        return {
            navigation,
            users: ref(new Array),
            exams: ref(new Array),
            user_role: ref(),
            numABI: ref(UserContract),
            numContract: ref("0xdeB972c5e7826bBeF4277a18A726ef6a8E1Edd10"),
            numABIExam: ref(ExamContract),
            numContractExam: ref("0xc60D594d73326824d14Cf55c79D6a114EAea3977"),
            subject: ref(""),
            quest1: ref(""),
            answer1: ref(""),
            answer2: ref(""),
            correctAnswer: ref(""),
            address: ref()
        }
    },
    created() {
        this.user_role = sessionStorage.getItem('user_role') ? sessionStorage.getItem('user_role') : null;
        this.callUsersContract();
        this.getExams();
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
        async callUsersContract() {
            const provider = new ethers.providers.Web3Provider((window as any).ethereum);
            const numberContract = new ethers.Contract(this.numContract, this.numABI, provider.getSigner())

            const num = await numberContract.number()
            console.log(num)

            const aa = await numberContract.totalUsers()      
            if (aa.toNumber() > 0) {
                for (var i=1; i<=aa.toNumber(); i++) {
                    numberContract.getUserById(i).then((response: any) => {
                        this.users.push(response)
                        console.log(this.users)
                    })
                } // end for
            } // end if
        },
        async performSubmit() {
            const accounts = await (window as any).ethereum.request({ method: 'eth_requestAccounts' })
            this.address = accounts[0];

            this.performExamRegistration(this.address)
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

        async performExamRegistration(address: any) {
            const provider = new ethers.providers.Web3Provider((window as any).ethereum);
            const numberContract = new ethers.Contract(this.numContractExam, this.numABIExam, provider.getSigner())

            try {
                const transaction = await numberContract.registerExam(this.subject, this.quest1, this.answer1, this.answer2, this.correctAnswer,
                    {
                        from: address,
                        gasLimit: 800000
                    },
                );

                console.log('transaction :>> ', transaction);
                // wait for the transaction to actually settle in the blockchain
                await transaction.wait();
                this.subject = '';
                this.quest1 = '';
                this.answer1 = '';
                this.answer2 = '';
                this.correctAnswer = '';

                this.getExams();

                //this.getMessages();
            } catch (error) {
                console.error(error);
               // trxInProgress.value = false;
            }
        }
    }
})

</script>