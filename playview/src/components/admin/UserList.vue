<template>
  <div>
    用户列表
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
      <el-breadcrumb-item>权限管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
<!--    用户列表主体（卡片）-->
    <el-card>
<!--      间隙属性-->
      <el-row :gutter="25">
        <!--      搜索区域-->
        <el-col :span="10">
<!--          搜索添加-->
          <el-input placeholder="请输入搜索内容" v-model="queryInfo.query" clearable @click="getUserList">
            <el-button slot="append" icon="el-icon-search" @click="search"></el-button>
          </el-input>
        </el-col>
        <el-col :span="4">
          <!--        搜索按钮-->
          <el-button type="primary" @click="insertUser = true">添加用户</el-button>
        </el-col>
      </el-row>
<!--      用户列表 border边框 Stripe隔行变色-->
      <el-table :data="userList" border stripe>
        <el-table-column label="索引" prop="id" align="center"></el-table-column><!--索引列-->
        <el-table-column label="用户名" prop="username" align="center"></el-table-column>
        <el-table-column label="密码" prop="password" align="center"></el-table-column>
        <el-table-column label="邮箱" prop="email" align="center"></el-table-column>
        <el-table-column label="角色" prop="role" align="center"></el-table-column>
        <el-table-column label="状态" prop="state" align="center">
<!--          作用域插槽 scope.row存储了当前行的信息-->
          <template slot-scope="scope">
<!--            每一行封存的数据-->
              <el-switch v-model = "scope.row.state" @change="StateChange(scope.row)"></el-switch>
          </template>
        </el-table-column>
<!--        自定义插槽-->
        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <!--修改-->
            <el-button type="primary" icon="el-icon-edit" size="mini" @click="showEditDialog(scope.row.id)">
            </el-button>
            <!--删除-->
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteUser(scope.row.id)">
            </el-button>
            <!--权限-->
            <el-tooltip effect="dark" content="分配权限" placement="top-start" :enterable="false">
              <el-button type="warning" icon="el-icon-setting" size="mini">
              </el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
<!--      分页组件 @size-change每页最大变化 @current-change 当前最大变化layout功能组件-->
      <div>
        <el-pagination
            @size-change="handleSizeChange"
            @current-change = "handleCurrentChange"
            :current-page="queryInfo.pageNum"
            :page-sizes="[5,10,15,50]"
            :page-size="queryInfo.pageSize"
            layout="total,sizes,prev,pager,next,jumper"
            :total="total">
        </el-pagination>
      </div>

<!-- 新增用户表单  -->
      <el-dialog title="添加用户" :visible.sync="insertUser" width="50%" @close="insertClosed">
        <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="80px">
          <el-form-item label="用户名：" prop="username">
            <el-input v-model="addForm.username"></el-input>
          </el-form-item>
          <el-form-item label="密码：" prop="password">
            <el-input v-model="addForm.password"></el-input>
          </el-form-item>
          <el-form-item label="邮箱：" prop="email">
            <el-input v-model="addForm.email"></el-input>
          </el-form-item>
          <el-form-item label="角色：" prop="roleId">
            <el-select v-model="addForm.roleId" clearable placeholder="请选择">
              <el-option
                  v-for="item in options"
                  :key="item.roleId"
                  :label="item.role"
                  :value="item.roleId">
              </el-option>
            </el-select>
          </el-form-item>

        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="insertUser = false">取 消</el-button>
            <el-button type="primary" @click="addUser">确 认</el-button>
          </span>
      </el-dialog>

<!--      修改用户对话框-->
      <el-dialog title="修改用户信息" :visible.sync="editDialogVisible" width="50%" @close="editClosed">
        <el-form :model="editForm" :rules="addFormRules" ref="editFormRef" label-width="80px">
          <el-form-item label="用户名：" prop="username">
            <el-input v-model="editForm.username" disabled></el-input>
          </el-form-item>
          <el-form-item label="密码：" prop="username">
            <el-input v-model="editForm.password"></el-input>
          </el-form-item>
          <el-form-item label="邮箱：" prop="username">
            <el-input v-model="editForm.email"></el-input>
          </el-form-item>
          <el-form-item label="角色：" prop="roleId">
            <el-select v-model="editForm.roleId" @click="selectRole">
              <el-option
                  v-for="item in options"
                  :key="item.roleId"
                  :label="item.role"
                  :value="item.roleId">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <!-- 内容底部区域    -->
        <span slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="editUserInfo">确 认</el-button>
          </span>
      </el-dialog>
    </el-card>
  </div>

</template>

<script>
export default {
  name: "UserList",
  data(){
    return{
      options: [{
        roleId: '',
        role: ''
      }],
      // 查询信息实体
      queryInfo:{
        query:"",//信息
        pageNum: 1,//当前页
        pageSize: 10,//每页最大数
      },
      userList:[],//用户列表
      total:0,//总记录数
      insertUser:false,//对话框状态

      //修改用户信息
      editForm:{},
      //显示、隐藏修改用户栏
      editDialogVisible:false,

      //新增表单信息
      addForm:{
        username:"",
        password:"",
        email:"",
        roleId:""
      },
      //表单校验
      addFormRules:{
        username:[
          {required: true,message:"请输入用户名",trigger:"blur"},
          {min: 3,max: 12,message:"长度在 3 到 12 个字符串",trigger:"blur"},
        ],
        password: [
          {required:true,message:"请输入密码",trigger:"blur"},
          {min:6,max:24,message:"长度在 6 到 24 个字符串",trigger:"blur"}
        ],
        email: [
          {required:true,message:"请输入邮箱",trigger:"blur"},
          {min:6,max:18,message:"请输入正确的邮箱地址",trigger:"blur"}
        ],
        roleId: [
          {required:true,message:"请選擇角色",trigger:"blur"},
        ]
      },

      //修改表单验证（看新增的）
    }
  },
  created() {
      this.getUserList();
      this.selectRole();
  },
  methods:{
    //角色下拉框
    async selectRole(){
      const {data:res} = await this.$http.get("/User/role")
      this.options = res.data;
    },


    //获取所有用户
    async getUserList(){
      const {data:res} = await
      this.$http.get("/User/list",{params:this.queryInfo})
      this.userList = res.data;//用户列表数据封装
      this.total = res.number;//总用户数封装
    },
    //搜索功能
    search(){
      this.getUserList();
    },
    //最大数
    handleSizeChange(newSize){
      this.queryInfo.pageSize = newSize;
      this.getUserList();
    },
    //pageNum的触发动作
    handleCurrentChange(newPage){
      this.queryInfo.pageNum = newPage;
      this.getUserList();
    },

    // 用户状态修改
    async StateChange(userInfo){
      const {data:res} = await this.$http.post(`/User/updateState?id=${userInfo.id}&state=${userInfo.state}`);
      if(res!="success"){
        userInfo.id = !userInfo.id;
        return this.$message.error("操作失败");
      }
      this.$message.success("操作成功");
    },
    // 监听添加用户
    insertClosed(){
      this.$refs.addFormRef.resetFields();
    },
    addUser(){
      this.$refs.addFormRef.validate(async valid =>{
        if(!valid) return;
        const {data:res} = await this.$http.post("/User/insertUser",this.addForm);
        if(res!="success"){
          return this.$message.error("添加失败！！！");
        }
        this.$message.success("添加成功！！！");
        this.insertUser = false;
        await this.getUserList();
      });

    },
    //根据主键删除用户
    async deleteUser(id){
     const confirmResult = await this.$confirm('是否确定删除？','提示',{
        confirmButtonText:"确定",
        cancelButtonText:"取消",
        type:'warning'
      }).catch(err => err)
      if(confirmResult!='confirm'){//取消
        return this.$message.info("已取消删除");
      }
     const {data:res} = await this.$http.post("/User/deleteUser?id=" + id);
      if(res != "success"){
        return this.$message.error("删除失败！");
      }
      this.$message.success("删除成功");
      await this.getUserList();
    },

   // 显示对话框
   async showEditDialog(id){
      const {data:res} = await this.$http.get("/User/userId?id="+id);
      this.editForm = res;//查询出用户信息反填回编辑表单
      this.editDialogVisible = true;//开启编辑对话框
    },
   // 关闭窗口
    editClosed(){
      this.$refs.editFormRef.resetFields();//重置信息
    },
   // 确认修改
    editUserInfo(){
      this.$refs.editFormRef.validate(async valid =>{
        if(!valid) return;
        //发起修改请求
       const {data:res} = await this.$http.post("/User/editUser",this.editForm);
       if(res != "success"){
         return this.$message.error("修改失败！！！");
       }
       this.$message.success("修改成功");
       //隐藏
        this.editDialogVisible = false;
       await this.getUserList();
      })
    }
  }
}
</script>

<style lang="less" scoped>
.el-breadcrumb{
  margin-bottom: 15px;
  font-size: 17px;
}

</style>