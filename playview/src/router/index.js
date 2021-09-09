import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../components/Login.vue'
import Home from '../components/Home.vue'
import Welcome from "../components/Welcome.vue"
import UserList from "../components/admin/UserList.vue"


Vue.use(VueRouter)

const routes = [
	{
		path:"/",
		redirect:'/login'
	},
	{
		path:"/login",
		component: Login
	},
	{
		path:"/home",
		component:Home,
		redirect: "/welcome",
		children:[
			{
				path:"/welcome",
				component: Welcome,
			},
			{
				path:"/user",
				component: UserList,
			},
		]

	},
]

const router = new VueRouter({
  routes
})

//出现问题时使用
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location, onResolve,onReject){
	if(onResolve || onReject) return originalPush.call(this,location,onResolve,onReject)
	return originalPush.call(this,location).catch(err => err)
}


// 挂载路由导航守卫
// router.beforeEach((to, from, next) => {
//   // to:将要访问的路径
//   // from:从哪里访问的路径
//   // next:之后要做的任务，是一个函数
//   //    next（）放行， next（'/URL'）强制跳转的路径。
//   if (to.path == '/login') return next();// 访问路径为登录
//   // 获取user
//   const userflag = window.sessionStorage.getItem("user");// 取出当前用户
//   if (!userflag) return next('/login');// 没登录去登录
//   next();//符合要求 放行
// })

export default router// 暴露出去
