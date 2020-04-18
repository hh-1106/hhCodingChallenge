/*
 * This is a Quadtree System
 * Make sure your particle class extends UserData
 * should refactor the qtree when the userdata change
 * remember to insert nodes to the qtree
 * show to view the tree
 * have fun
 
 * Author: hh
 * after going through shiffman's Quadtree tutoriors
 */


///////////////////////////////////////////////////////////////////////////////
//public abstract class UserData {
//  public boolean intersects(UserData other) {
//    return false;
//  }

//  public abstract void move();
//  public abstract void show();
//}
///////////////////////////////////////////////////////////////////////////////

interface UserData {
  public boolean intersects(Particle other);
  public abstract void move();
  abstract void show();
}


class QTreeSystem {
  private Quadtree qtree;
  private Rectangle boundary;

  QTreeSystem() {
    this.boundary = new Rectangle(width*0.5, height*0.5, width, height);
    this.qtree = new Quadtree(boundary, 4);
  }

  private void refactor() {
    this.qtree = new Quadtree(boundary, 4);
  }

  private void insert(Node n) {
    this.qtree.insert(n);
  }

  public ArrayList<Node> query (Circle range, ArrayList<Node> found) {
    return this.qtree.query(range, found);
  }

  private void insert(ArrayList<Node> nodes) {
    for (Node n : nodes) {
      this.insert(n);
    }
  }

  private void show() {
    this.qtree.show();
  }
}


///////////////////////////////////////////////////////////////////////////////

class Node {
  float x;
  float y ;
  UserData userData;

  public Node (float x, float y, UserData userData) {
    this.x = x;
    this.y = y;
    this.userData = userData;
  }
}


///////////////////////////////////////////////////////////////////////////////
class Quadtree {
  Rectangle boundry;
  int capacity; // max no. of points, greater than 0
  ArrayList <Node> nodes ;
  boolean divided = false;
  Quadtree northeast;
  Quadtree northwest;
  Quadtree southeast;
  Quadtree southwest;

  public Quadtree (Rectangle rect, int cap) {
    this.boundry = rect;
    this.capacity = cap;
    nodes = new ArrayList<Node>();
  }

  public boolean insert (Node n) {
    if (!this.boundry.contains(n)) return false;

    if (this.nodes.size() < this.capacity ) {
      this. nodes.add(n);
      return true;
    } else {
      if (!this.divided)   subDivide();

      return (this.northeast.insert(n) ||
        this.northwest.insert(n) ||
        this.southeast.insert(n) ||
        this.southwest.insert(n)
        ) ? true :false;
    }
  }

  public void subDivide () {
    float x = this.boundry.x;
    float y = this.boundry.y;
    float w = this.boundry.w*0.5;
    float h = this.boundry.h*0.5;
    this.northeast = new Quadtree(new Rectangle (x+w, y-h, w, h), capacity);
    this.northwest = new Quadtree(new Rectangle (x-w, y-h, w, h), capacity);
    this.southeast = new Quadtree(new Rectangle (x+w, y+h, w, h), capacity);
    this.southwest = new Quadtree(new Rectangle (x-w, y+h, w, h), capacity);
    this.divided = true;
  }

  public ArrayList<Node> query (Circle range, ArrayList<Node> found) {
    if (found == null)  found = new ArrayList <Node>();

    if (!range.intersects(this.boundry))   return found;

    for (Node n : nodes) {
      if (range.contains(n))
        found.add(n);
    }

    if (this.divided) {
      this.northeast.query(range, found);
      this.northwest.query(range, found);
      this.southeast.query(range, found);
      this.southwest.query(range, found);
    }

    return found;
  }

  public void show () {
    stroke(255);
    strokeWeight(1);
    noFill();
    rect ((float)this.boundry.x, (float)this.boundry.y, (float)this.boundry.w *2, (float)this.boundry.h*2);
    if (this.divided) {
      this.northeast.show();
      this.northwest.show();
      this.southeast.show();
      this.southwest.show();
    }

    // (for showing nodes)
    for (Node n : nodes) {
      strokeWeight(1.5);
      stroke(255);
      point((float)n.x, (float) n.y);
    }
  }
}


///////////////////////////////////////////////////////////////////////////////
interface Shape {
  public abstract boolean intersects(Rectangle range);
  public abstract boolean contains(Node n);
}

class Rectangle implements Shape {
  float x, y, w, h;

  public Rectangle (float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public boolean intersects(Rectangle range) {
    return !(range.x - range.w> this.x + this.w ||
      range.x + range.w< this.x - this.w ||
      range.y - range.h> this.y + this.h ||
      range.y + range.h< this.y - this.h);
  }

  public boolean contains (Node n) {
    return  n.x <= this.x+this.w &&
      n.x >= this.x-this.w &&
      n.y <= this.y+this.h &&
      n.y >= this.y-this.h ;
  }
}

class Circle implements Shape {
  float x, y, r;

  public Circle (float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }

  public boolean intersects(Rectangle range) {
    float xDist = abs(range.x - this.x);
    float yDist = abs(range.y - this.y);

    float edges = dist(xDist-range.w, 0, yDist-range.h, 0);
    float w = range.w;
    float h = range.h;

    // no intersection
    if (xDist > this.r + w || yDist > this.r + h)  return false;
    // intersection within the circle
    if (xDist <= w || yDist <= h)  return true;
    // intersection on the edge of the circle
    return edges <= this.r;
  }

  public boolean contains (Node n) {
    float d = dist(n.x, n.y, this.x, this.y);
    return d <= this.r;
  }
}
