// function Tree() {
//   this.root = null
//
//   this.addValue = function(val) {
//     var n = new Node(val)
//     if (this.root == null) {
//       this.root = n
//       this.root.label = "根"
//       this.root.x = width/2
//       this.root.y = 16
//       this.layer = 1
//     } else {
//       this.root.addNode(n)
//     }
//   }
//
//   this.traverse = function(){
//     this.root.visit(this.root)
//   }
//
//   this.search = function(val){
//     var found = this.root.search(val)
//     return found
//   }
//
// }


var root = new Node("ROOT")

var nty = new Node("NYT")

// 初始化
root.left = nty
nty.father = root


// 第二个之后
// 搜索树是否出现过
// NO
var n1 = new Node("a")
n1.freq++
nty.right = n1
n1.father = nty

var nty2 = new Node("NTY")
nty.left = nty2
nty2.father = nty

nty.label = "TEMP"
nty = nty2

// 不用遍历 不用交换.....


// YES
n2.freq++
for
  // 广度遍历  从大到小
  // 遇到的第一个比他小的
  // 交换父亲
  // 把上面的父亲freq+1
  // 没有发生交换 退出循环
