import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import StartView from '../views/StartView.vue'
import RegisterView from '../views/RegisterView.vue'
import ExamView from '../views/ExamView.vue';
import TeacherView from '../views/TeacherView.vue';

const routes = [
  {
    path: '/',
    name: 'start',
    component: StartView
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView
  },
  {
    path: '/signin',
    name: 'sign_in',
    component: RegisterView
  },
  {
    path: '/home',
    name: 'home',
    component: HomeView
  },
  {
    path: '/exam/:eName',
    name: 'exam',
    component: ExamView
  },
  {
    path: '/teacher',
    name: 'teacher',
    component: TeacherView
  },

]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
