<template>
    <div class="min-h-full flex flex-col justify-center py-12 sm:px-6 lg:px-8 ">
        <div class="sm:mx-auto sm:w-full sm:max-w-md">
            <img class="h-12 w-13 w-auto mx-auto" src="../assets/logo_education.png" />
            <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">Registra't com a estudiant</h2>
        </div>
        <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
            <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
                <div v-if="!firstInfoFilled" class="w-full max-w-lg">
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-first-name">
                            Nom
                        </label>
                        <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-first-name" v-model="name" type="text" placeholder="Marc">
                        </div>
                        <div class="w-full md:w-1/2 px-3">
                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-last-name">
                            Cognom
                        </label>
                        <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-last-name" v-model="surname" type="text" placeholder="Palma">
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-course">
                            Assignatura
                        </label>
                        <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-course" v-model="course" type="text" placeholder="2n DAM">
                        </div>
                        <div class="w-full md:w-1/2 px-3">
                        <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-phone">
                            Telèfon
                        </label>
                        <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-phone" v-model="phone" type="tel" placeholder="675842596">
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-2">
                        <div class="w-full px-3">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-account_address">
                                Adreça del compte
                            </label>
                            <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-address" v-model="address" type="text" placeholder="marc@example.com">
                        </div>
                    </div>
                    <div class="flex flex-wrap -mx-3 mb-4">
                        <div class="w-full px-3 mb-2">
                            <input class="focus:outline-none" id="student" v-model="role" value="student" type="radio">
                            <label class="uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="student">
                                Estudiant
                            </label>
                        </div>
                        <div class="w-full px-3">
                            <input class="focus:outline-none" id="teacher" v-model="role" value="teacher" type="radio">
                            <label class="uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="teacher">
                                Professor
                            </label>
                        </div>
                    </div>
                    <div>
                        <button @click="firstInfoFilled = true" :class="[name === '' && surname === '' && course === '' && phone === '' && address === '' ? 'opacity-50' : 'opacity-100', 'w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-700']">Continuar</button>
                    </div>
                </div>
                <div class="w-full max-w-lg" v-if="firstInfoFilled">
                    <div class="flex flex-wrap -mx-3 mb-6">
                        <div class="w-full px-3">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-username">
                                Nom d'usuari
                            </label>
                            <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-username" v-model="username" type="text" placeholder="markituss">
                        </div>
                        <div class="w-full px-3">
                            <label class="block uppercase tracking-wide text-gray-700 text-xs font-bold mb-2" for="grid-password">
                                Contrasenya
                            </label>
                            <input class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 mb-3 leading-tight focus:outline-none focus:bg-white focus:border-gray-500" id="grid-password" v-model="password" type="password" placeholder="*********">
                        </div>
                    </div>
                    <div v-if="cannotRegister" class="rounded-md bg-red-50 p-4 mb-4">
                        <div class="flex">
                            <div class="flex-shrink-0">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="#F87171" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                            </div>
                            <div class="ml-3">
                                <h3 class="text-sm font-medium text-red-800">Hi han errors a les teves dades</h3>
                                <div class="mt-2 text-sm text-red-700">
                                    <p>Revisa que hagis emplenat totes les dades requerides per a realitzar el registre.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <button @click="createAccount" :disabled="username === '' && password === ''" :class="[(username === '' && password === '') ? 'opacity-50' : 'opacity-100', 'w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-700']">Registrar-me</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import firebase from 'firebase';

export default defineComponent({
    name: "LoginView",
    setup() {
        return {
            name: ref(''),
            surname: ref(''),
            course: ref(''),
            phone: ref(''),
            address: ref(''),
            firstInfoFilled: ref(false),
            username: ref(''),
            password: ref(''),
            role: ref(),
            cannotRegister: ref(false),
            db: ref(firebase.firestore()),
            uid: ref()
        }
    },
    methods: {
        createAccount() {
            firebase.auth().createUserWithEmailAndPassword(this.address, this.password)
            .then(() => {
                firebase.auth().onAuthStateChanged((user) => { if (user) {this.addUserDatabase(user.uid)}});            
            })
            .catch(error => {
                console.log(error.code)
                this.cannotRegister = true;
            });
        },
        addUserDatabase(uid: any) {
            this.db.collection("users").doc(uid)
            .set({name: this.name, surname: this.surname, course: this.course, phone: this.phone, emailAddress: this.address, username: this.username, role: this.role})
            .then(() => {
                this.$router.push({ path: "/login" });
            })
            .catch((error) => {
                console.error("Error writing document: ", error);
            });
        }
    },
});
</script>