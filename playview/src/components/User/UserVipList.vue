<template>
<div>會員管理
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{path:'/home'}">首页</el-breadcrumb-item>
    <el-breadcrumb-item>會員列表</el-breadcrumb-item>
  </el-breadcrumb>
</div>
</template>

<script>
export default {
  name: "UserVipList.vue",
  data(){
    return{

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