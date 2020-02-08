float season = 80;
float winter = -0;

float season_rate = 0.01;
float winter_rate = 0.01;

void seasonChange() { 
  season = map(sin(frameCount*season_rate), -1, 1, 80, 100);
  winter = map(cos(frameCount*winter_rate), -1, 1, 0, -100);
}

void subDivide(Branch branch) {
  ArrayList<Branch> newBranches = new ArrayList<Branch>();

  int newBranchCount = (int)random(1.4, 4);

  float minLength = 0.7;
  float maxLength = 0.85;

  //switch(newBranchCount) {
  //case 2:
  //  newBranches.add(branch.newBranch(random(-45.0, -10.0), random(minLength, maxLength)));
  //  newBranches.add(branch.newBranch(random(10.0, 45.0), random(minLength, maxLength)));
  //  break;
  //case 3:
  //  newBranches.add(branch.newBranch(random(-45.0, -15.0), random(minLength, maxLength)));
  //  newBranches.add(branch.newBranch(random(-10.0, 10.0), random(minLength, maxLength)));
  //  newBranches.add(branch.newBranch(random(15.0, 45.0), random(minLength, maxLength)));
  //  break;
  //default:
  //  newBranches.add(branch.newBranch(random(-45.0, 45.0), random(minLength, maxLength)));
  //  break;
  //}

  if (newBranchCount == 2) {
    newBranches.add(branch.newBranch(random(-45.0, -10.0), random(minLength, maxLength)));
    newBranches.add(branch.newBranch(random(10.0, 45.0), random(minLength, maxLength)));
  }
  if (newBranchCount == 3) {
    newBranches.add(branch.newBranch(random(-45.0, -15.0), random(minLength, maxLength)));
    newBranches.add(branch.newBranch(random(-10.0, 10.0), random(minLength, maxLength)));
    newBranches.add(branch.newBranch(random(15.0, 45.0), random(minLength, maxLength)));
  } else
    newBranches.add(branch.newBranch(random(-45.0, 45.0), random(minLength, maxLength)));


  for (Branch newBranch : newBranches) {
    branches.add(newBranch);

    if (newBranch.level < maxLevel) {
      subDivide(newBranch);
    } else {
      // Randomly generate leaves position on last branch
      float offset = 5.0;
      for (int i = 0; i < 5; i++) {
        leaves.add(new Leaf(newBranch.end.x+random(-offset, offset), newBranch.end.y+random(-offset, offset), newBranch));
      }
    }
  }
}


void generateNewTree() {
  branches.clear();
  leaves.clear();

  float rootLength = random(80.0, 150.0);
  branches.add(new Branch(width*0.4, height, width*0.4, height-rootLength, 0, null));

  subDivide(branches.get(0));
}


float distSquared(float x1, float y1, float x2, float y2) {
  return (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
}


void explod() {
  PVector source = new PVector(mouseX, mouseY);

  float branchDistThreshold = 300*300*force;
  for (Branch b : branches) {
    float dist = distSquared(mouseX, mouseY, b.end.x, b.end.y);
    if (dist > branchDistThreshold) continue;

    PVector explosion = new PVector(b.end.x, b.end.y);
    explosion.sub(source);
    explosion.normalize();
    float mult = map(dist, 0, branchDistThreshold, 6.0, 1.0);
    explosion.mult(mult);
    b.applyForce(explosion);
  }

  float leafDistThreshold = 100*100*force;
  for (Leaf f : leaves) {
    float distance = distSquared(mouseX, mouseY, f.pos.x, f.pos.y);
    if (distance > leafDistThreshold) continue;

    PVector explosion = new PVector(f.pos.x, f.pos.y);
    explosion.sub(source);
    explosion.normalize();
    float mult = map(distance, 0, leafDistThreshold, 2.0, 0.1);
    mult *= random(0.8, 1.2); // Explosion looks too spherical otherwise, this helps give it variation
    explosion.mult(mult);
    f.applyForce(explosion);

    f.dynamic = true;
  }
}
