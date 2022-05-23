<template>
    <div class="min-h-full flex flex-col justify-center py-12 sm:px-6 lg:px-8 ">
        <div class="sm:mx-auto sm:w-full sm:max-w-md">
            <img class="h-12 w-13 w-auto mx-auto" src="../assets/logo_education.png" />
            <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">Inicia sessió al teu compte</h2>
        </div>

        <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
            <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700"> Adreça de correu </label>
                    <div class="mt-1">
                        <input v-model="accountAddress" id="accountAddress" name="accountAddress" type="text" autocomplete="accountAddress" required="" class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                    </div>
                </div>
                <div class="mt-4">
                    <label for="password" class="block text-sm font-medium text-gray-700"> Contrasenya </label>
                    <div class="mt-1">
                        <input v-model="password" id="password" name="password" type="password" autocomplete="current-password" required="" class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" />
                    </div>
                </div>
                <div v-if="cannotLog" class="rounded-md bg-red-50 p-4 my-4">
                    <div class="flex">
                        <div class="flex-shrink-0">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="#F87171" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                        </div>
                        <div class="ml-3">
                            <h3 class="text-sm font-medium text-red-800">{{errMsg}}</h3>
                            <div class="mt-2 text-sm text-red-700">
                                <p>Revisa l'error descrit i contacta si no ho aconsegueixes solucionar.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="flex items-right mt-4">
                    <div @click="goRegister" class="text-sm cursor-pointer">
                        <p class="font-medium"> No tens compte? </p>
                    </div>
                </div>
                <div class="mt-4">
                    <button @click="logIn" :class="[accountAddress === '' && password === '' ? 'opacity-50' : 'opacity-100', 'w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-emerald-700 hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-700']">Iniciar sessió</button>
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
            accountAddress: ref(''),
            password: ref(''),
            errMsg: ref(""),
            cannotLog: ref(false),
            uid: ref(),
            db: ref(firebase.firestore()),
        }
    },
    methods: {
        goRegister() {
            this.$router.push({ path: "/signin" });
        },
        logIn() {
            firebase.auth().signInWithEmailAndPassword(this.accountAddress, this.password)
            .then(() => {
                firebase.auth().onAuthStateChanged((user) => { if (user) { this.getUserRoleByUID(user.uid);}});               
            })
            .catch(error => {
                this.cannotLog = true;
                switch (error.code) {
                    case 'auth/invalid-email':
                        this.errMsg = 'Email no vàlid'
                        break
                    case 'auth/user-not-found':
                        this.errMsg = 'No hi ha un compte amb aquest correu'
                        break
                    case 'auth/wrong-password':
                        this.errMsg = 'Contrasenya incorrecta'
                        break
                    default:
                        this.errMsg = 'Email o contrasenya incorrecta'
                        break
                }
            });
        },
        getUserRoleByUID(uid: any) {
            this.db.collection("users").where(firebase.firestore.FieldPath.documentId(), '==', uid).get()
            .then((querySnapshot) => {
                querySnapshot.forEach((doc) => {
                    let user_role = doc.data().role;
                    console.log(user_role)
                    sessionStorage.setItem('user_role', user_role);
                    this.$router.push({ path: "/home" });
                });
            })
            .catch((error) => {
                console.log("Error getting documents: ", error);
            });
        }
    },
});
</script>