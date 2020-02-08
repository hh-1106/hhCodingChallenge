function Node(label) {
  this.label = label  // 标签
  this.freq = 0

  this.parent = null
  this.left = null
  this.right = null

  this.x = 0
  this.y = 0
  this.layer = 0


  this.addNode = function(n) {
    if (n.value < this.value) {
      if (this.left == null) {
        this.left = n
        this.left.layer = this.layer + 1
        this.left.x = this.x - 150 / this.left.layer
        this.left.y = this.y + 50
      } else
        this.left.addNode(n)
    } else if (n.value > this.value) {
      if (this.right == null) {
        this.right = n
        this.right.layer = this.layer + 1
        this.right.x = this.x + 150 / this.right.layer
        this.right.y = this.y + 50
      } else
        this.right.addNode(n)
    }
  }

  this.visit = function(parent) {
    if (this.left != null)
      this.left.visit(this)

    fill(200, 50, 200)
    noStroke()
    text(this.value, this.x, this.y)
    stroke(255)
    noFill()
    ellipse(this.x, this.y, 20)
    line(parent.x, parent.y, this.x, this.y)

    if (this.right != null)
      this.right.visit(this)
  }

  this.search = function(val) {
    if (this.value == val)
      return this

    else if (val < this.value && this.left != null)
      return this.left.search(val)
    else if (val > this.value && this.right != null)
      return this.right.search(val)

    return null
  }
}
