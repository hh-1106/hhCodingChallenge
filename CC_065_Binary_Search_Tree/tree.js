function Tree() {
  this.root = null

  this.addValue = function(val) {
    var n = new Node(val)
    if (this.root == null) {
      this.root = n
      this.root.x = width/2
      this.root.y = 16
      this.layer = 1
    } else {
      this.root.addNode(n)
    }
  }

  this.traverse = function(){
    this.root.visit(this.root)
  }

  this.search = function(val){
    var found = this.root.search(val)
    return found
  }

}
