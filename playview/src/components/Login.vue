<template>
	<div class="login_container">
		<!-- 登录块 -->
		<div class="login_box">
			<!-- logo头像 -->
			<div class="avatar_box">
				<img src="../assets/sportlogo.jpg" />
			</div>
			<!-- 表单区域 -->
			<el-form ref="loginFormRef" :rules="loginRules" :model="loginForm" label-width="0" class="login_form">
				<!-- 用户名 -->
				<el-form-item prop="username">
					<el-input v-model="loginForm.username" prefix-icon="iconfont icon-denglu"></el-input>
				</el-form-item>
				<!-- 密码 -->
				<el-form-item prop="password">
					<el-input v-model="loginForm.password" prefix-icon="iconfont icon-mima" type="password"></el-input>
				</el-form-item>
				<!-- 按钮 -->
				<el-form-item class="btns">
					<el-button type="primary" @click="login()">登录</el-button>
					<el-button type="info" @click="resetLoginForm()">重置</el-button>
				</el-form-item>
			</el-form>
		</div>
	</div>
</template>

<script>
	export default{
		data(){
			return{
				// 表单数据
				loginForm:{
					username:"admin",
					password:"123456"
				},
				// 验证对象
				loginRules:{
					// 校验
					username:[
						{required:true,message:"请输入用户名称",trigger:'blur'},//必须向验证
						{min: 3, max: 10,message: '长度在 3 到 10 个字符',trigger:'blur'}//长度验证
						],
					password:[
						{required:true,message:"用户密码必须填写",trigger:'blur'},//必须向验证
						{min: 6, max: 12,message: '长度在 6 到 12 个字符',trigger:'blur'}
					]
				},
			};
		},
		methods:{
			//重置表单内容
			resetLoginForm(){
				this.$refs.loginFormRef.resetFields();
			},
			// 登录方法
			login(){
				
				// 验证是否成功 成功(true) 失败(false)
				// this.$refs.loginFormRef.validate(valid =>{
				// 	console.log(valid);
				// })
				// 验证校验规则
				this.$refs.loginFormRef.validate(async valid =>{
					if(!valid) return;//验证失败
					const {data:res} = await this.$http.post("login",this.loginForm);//访问后台
					// console.log(res)
					if( res.flag == "ok"){
						this.$message.success("操作成功！！！");//信息提示
						await this.$router.push({path:"/home"});// 页面路由跳转
						window.sessionStorage.setItem("user",res.user);//存储user对象
					}else{
						this.$message.error("操作失败！！！");// 错误提示
					}
				})
			}
		}
		
	}
</script>

<style lang="less" scoped>
	.login_container{
		background-color: #2b4b6b;
		height: 100%;
	}
	.login_box{
		width: 450px;
		height: 300px;
		background-color: #fff;
		border-radius: 4px;
		position: absolute;
		left: 50%;
		top: 50%;
		transform: translate(-50%,-50%);
		.avatar_box{
			width: 130px;
			height: 130px;
			border: 1px solid #eee;
			border-radius: 50%;
			padding: 10px;
			box-shadow: 0 0 2px #ddd;
			position: absolute;
			left: 50%;
			transform: translate(-50%,-50%);
			background-color: #eee;
			img{
				width: 100%;
				height: 100%;
				border-radius: 50%;
				background-color: #eee;
			}
			
		}
	}
	.btns{
		display: flex;
		justify-content: flex-end;
	}
	.login_form{
		position: absolute;
		bottom: 0%;
		width: 100%;
		padding: 0 10px;
		box-sizing: border-box;
	}
</style>
