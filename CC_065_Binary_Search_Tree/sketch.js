/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


var tree

function setup() {
  createCanvas(800, 1000)
  background(51)
  textAlign(CENTER,CENTER)

  tree = new Tree()

  for (var i = 0; i < 30; i++) {
    tree.addValue(floor(random(100)))
  }

  tree.traverse()
}

function draw() {
  // background(0)
}
